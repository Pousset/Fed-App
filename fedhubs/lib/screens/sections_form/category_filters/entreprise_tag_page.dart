import 'package:fedhubs_pro/models/section/entreprise_categories_model.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_create_entreprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_delete_entreprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/buttons/filter_flat_button.dart';
import 'package:fedhubs_pro/widgets/others/search_bar.dart' as custom;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EntrepriseTagPage extends StatefulWidget {
  const EntrepriseTagPage({Key? key, required this.model}) : super(key: key);

  final EntrepriseCategoriesModel model;

  static Future<void> show(
    BuildContext context,
    EntrepriseCategoriesModel model,
  ) async {
    await Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
      builder: (context) => EntrepriseTagPage(model: model),
      fullscreenDialog: false,
    ));
  }

  @override
  State<EntrepriseTagPage> createState() => _EntrepriseTagPageState();
}

class _EntrepriseTagPageState extends State<EntrepriseTagPage> {
  late final CompanyProvider companyProvider =
      Provider.of<CompanyProvider>(context, listen: false);
  late final apiCreate =
      Provider.of<ApiCreateEnterprise>(context, listen: false);
  late final apiDelete =
      Provider.of<ApiDeleteEnterprise>(context, listen: false);
  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
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
        centerTitle: false,
        title: custom.SearchBar(
          submit: (str) async {
            if (widget.model.tags!.contains(str)) return;
            bool state = await apiCreate.postEntrepriseTag(
                str, companyProvider.idClient!);

            if (state) widget.model.tags!.add(str);
          },
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
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tags déja sélectionnées',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Pour ajouter un nouveau tag, mettre un # avant votre mot.',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: List.generate(widget.model.tags!.length, (index) {
              return FilterFlatButton(
                text: "#${widget.model.tags![index]}",
                color: Theme.of(context).secondaryHeaderColor,
                isSelected: true,
                onPressed: () async {
                  bool state = await apiDelete.deleteEntrepriseTag(
                      widget.model.tags![index], companyProvider.idClient!);

                  if (state) {
                    setState(() {
                      widget.model.tags!.remove(widget.model.tags![index]);
                    });
                  }
                },
                fontSize: 12,
                verticalPadding: 0,
                width: 0,
                trailing: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Stack(children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(
                      height: 14,
                      width: 14,
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).secondaryHeaderColor,
                        size: 9,
                      ),
                    ),
                  ]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
