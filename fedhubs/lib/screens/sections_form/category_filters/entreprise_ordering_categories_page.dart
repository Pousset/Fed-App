import 'package:fedhubs_pro/models/section/all_filters.dart';
import 'package:fedhubs_pro/models/section/entreprise_categories_model.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_create_entreprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EntrepriseOrderingCategoriesPage extends StatefulWidget {
  const EntrepriseOrderingCategoriesPage({
    Key? key,
    required this.model,
    required this.allCategories,
  }) : super(key: key);

  final EntrepriseCategoriesModel model;
  final List<Filter> allCategories;

  static Future<void> show(
    BuildContext context,
    EntrepriseCategoriesModel model,
    List<FilterSection> allCategories,
  ) async {
    await Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
      builder: (context) => EntrepriseOrderingCategoriesPage(
        model: model,
        allCategories: allCategories
            .expand((i) => i.filters)
            .where((e) => model.filters!.contains(e.id))
            .toList(),
      ),
      fullscreenDialog: false,
    ));
  }

  @override
  State<EntrepriseOrderingCategoriesPage> createState() =>
      _EntrepriseOrderingCategoriesPageState();
}

class _EntrepriseOrderingCategoriesPageState
    extends State<EntrepriseOrderingCategoriesPage> {
  late final CompanyProvider companyProvider =
      Provider.of<CompanyProvider>(context, listen: false);
  late final apiCreate =
      Provider.of<ApiCreateEnterprise>(context, listen: false);
  late final apiUpdate =
      Provider.of<ApiUpdateEnterprise>(context, listen: false);
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submit() async {
    bool state = true;

    if (widget.model.filters!.isNotEmpty) {
      state &= await apiCreate.postEntrepriseCategories(
          widget.model.filters!.join(','), companyProvider.idClient!);
    }
    state &= await apiUpdate.putEntrepriseCategoriesPosition(
        widget.allCategories.map((e) => e.id).join(','),
        companyProvider.idClient!);

    if (widget.model.paymentMethods!.isNotEmpty) {
      state &= await apiCreate.postEntreprisePaymentMethods(
          widget.model.paymentMethods!.join(','), companyProvider.idClient!);
    }

    state &= await apiUpdate.putEntreprisePriceRange(
        widget.model.price, companyProvider.idClient!);

    if (state && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        leading: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: CustomBackButton(),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildContent(context, screenSize),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: CustomFlatButton(
          color: Theme.of(context).secondaryHeaderColor,
          width: screenSize.width - 48,
          text: 'Enregistrer',
          onPressed: _submit,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ordre de préférence',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Choisissez parmi vos catégories séléctionées celles qui '
            'apparaîtront en prioritées.',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Container(
            clipBehavior: Clip.antiAlias,
            constraints: BoxConstraints(maxHeight: screenSize.height - 280),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ReorderableListView.builder(
              itemCount: widget.allCategories.length,
              itemBuilder: (context, index) => ListTile(
                key: Key(widget.allCategories[index].id),
                title: Text(
                  '${index + 1}  -  ${widget.allCategories[index].name}',
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: ReorderableDragStartListener(
                  index: index,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.fromLTRB(48, 16, 0, 16),
                    child: const Icon(Icons.drag_handle),
                  ),
                ),
              ),
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final Filter item = widget.allCategories.removeAt(oldIndex);
                  widget.allCategories.insert(newIndex, item);
                });
              },
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
