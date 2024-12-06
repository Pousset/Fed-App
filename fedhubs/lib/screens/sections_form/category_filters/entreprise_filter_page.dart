import 'package:fedhubs_pro/models/section/all_filters.dart';
import 'package:fedhubs_pro/models/section/entreprise_categories_model.dart';
import 'package:fedhubs_pro/models/section/payment_methods.dart';
import 'package:fedhubs_pro/screens/sections_form/category_filters/entreprise_ordering_categories_page.dart';
import 'package:fedhubs_pro/screens/sections_form/category_filters/entreprise_tag_page.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/buttons/filter_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EntrepriseCatgoryFiltersPage extends StatefulWidget {
  const EntrepriseCatgoryFiltersPage({
    super.key,
    required this.allFilters,
    required this.paymentSection,
    required this.model,
    required this.allCategories,
  });

  final List<FilterSection> allFilters;
  final List<FilterSection> allCategories;
  final List<PaymentSection> paymentSection;
  final EntrepriseCategoriesModel model;

  static Future<void> show(
    BuildContext context,
  ) async {
    final companyProvider =
        Provider.of<CompanyProvider>(context, listen: false);
    final apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    List<FilterSection> filters = await apiRead.fetchFilters();
    List<PaymentSection> paymentSection = await apiRead.fetchPaymentMethods();
    EntrepriseCategoriesModel model =
        await apiRead.fetchEntrepriseCategories(companyProvider.idClient!);
    if (model.filters != null && model.filters!.isNotEmpty) {
      filters = filters.map((section) {
        section.filters = section.filters.map((filter) {
          filter.isSelected = model.filters!.contains(filter.id);
          return filter;
        }).toList();
        return section;
      }).toList();
    }

    const filterSectionNames = ['Fourchette de prix', 'Moyen de paiement'];
    // ignore: use_build_context_synchronously
    await Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
      builder: (context) => EntrepriseCatgoryFiltersPage(
        allCategories: filters
            .where((e) => !filterSectionNames.contains(e.categoryName))
            .where((e) => e.categoryName != 'Distance')
            .toList(),
        allFilters: filters
            .where((e) => filterSectionNames.contains(e.categoryName))
            .where((e) => e.categoryName != 'Distance')
            .toList(),
        model: model,
        paymentSection: paymentSection,
      ),
      fullscreenDialog: false,
    ));
  }

  @override
  State<EntrepriseCatgoryFiltersPage> createState() =>
      _EntrepriseCatgoryFiltersPageState();
}

class _EntrepriseCatgoryFiltersPageState
    extends State<EntrepriseCatgoryFiltersPage> {
  bool isChanged = false;

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
        leading: const CustomBackButton(),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
            child: FilterFlatButton(
                text: '# Hashtags',
                color: Theme.of(context).secondaryHeaderColor,
                textColor: Theme.of(context).secondaryHeaderColor,
                verticalPadding: 0,
                onPressed: () => EntrepriseTagPage.show(context, widget.model)),
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildContent(screenSize),
      floatingActionButton: isChanged
          ? Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: CustomFlatButton(
                color: Theme.of(context).secondaryHeaderColor,
                width: screenSize.width - 48,
                text: 'Suivant',
                onPressed: () {
                  EntrepriseOrderingCategoriesPage.show(
                      context, widget.model, widget.allCategories);
                },
              ),
            )
          : null,
    );
  }

  Widget _buildContent(Size screenSize) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minHeight: screenSize.height - 156),
        margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Catégories',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              "Les catégories décrivent votre établissement. Elles vous "
              "permettent de toucher les clients qui recherchent vos produits "
              "ou services.",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            _buildCategory(),
            Text(
              'Filtres',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              "Les filtres décrivent votre établissement. Ils vous permettent "
              "de toucher les clients qui recherchent vos produits ou "
              "services.",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            _buildFilters(),
          ],
        ),
      ),
    );
  }

  void _toggleFilter(Filter filter) {
    isChanged = true;
    setState(() => filter.isSelected = !filter.isSelected);
    widget.model.filters ??= [];
    if (filter.isSelected) {
      if (!widget.model.filters!.contains(filter.id)) {
        widget.model.filters!.add(filter.id);
      }
    } else {
      widget.model.filters!.remove(filter.id);
    }
  }

  void _togglePaymentMethods(Filter filter) {
    isChanged = true;
    setState(() => filter.isSelected = !filter.isSelected);
    widget.model.paymentMethods ??= [];
    final paymentMethods = widget.paymentSection
        .expand((e) => e.methods)
        .where((e) => e.name == filter.name);
    for (var paymentMethod in paymentMethods) {
      if (filter.isSelected) {
        if (!widget.model.paymentMethods!.contains(paymentMethod.id)) {
          widget.model.paymentMethods!.add(paymentMethod.id);
        }
      } else {
        widget.model.paymentMethods!.remove(paymentMethod.id);
      }
    }
  }

  void _togglePrice(Filter filter, int idx) {
    isChanged = true;
    setState(() => filter.isSelected = !filter.isSelected);
    if (filter.isSelected) {
      widget.model.price = idx;
    }
  }

  Widget _buildCategory() {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          children: List.generate(
            widget.allCategories.length,
            (index) {
              final categories = widget.allCategories[index].filters;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      widget.allCategories[index].categoryName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: List.generate(categories.length, (i) {
                        late final VoidCallback onPressed;
                        late final bool isSelected;
                        onPressed = () => _toggleFilter(categories[i]);
                        isSelected = categories[i].isSelected;

                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FilterFlatButton(
                            onPressed: onPressed,
                            color: Theme.of(context).secondaryHeaderColor,
                            text: categories[i].name,
                            isSelected: isSelected,
                            icon: const Icon(Icons.check_sharp),
                            width: 0,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildFilters() {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          children: List.generate(
            widget.allFilters.length,
            (index) {
              final filters = widget.allFilters[index].filters;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      widget.allFilters[index].categoryName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: List.generate(filters.length, (i) {
                        late final VoidCallback onPressed;
                        late final bool isSelected;
                        switch (widget.allFilters[index].categoryName) {
                          case "Fourchette de prix":
                            onPressed = () => _togglePrice(filters[i], i);
                            isSelected = widget.model.price == i;
                            filters[i].isSelected = isSelected;
                            break;
                          case "Moyen de paiement":
                            onPressed = () => _togglePaymentMethods(filters[i]);

                            isSelected = widget.model.paymentMethods!.contains(
                                widget.paymentSection
                                    .expand((e) => e.methods)
                                    .where((e) => e.name == filters[i].name)
                                    .toList()[0]
                                    .id);
                            filters[i].isSelected = isSelected;
                            break;
                          default:
                            break;
                        }

                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FilterFlatButton(
                            onPressed: onPressed,
                            color: Theme.of(context).secondaryHeaderColor,
                            text: filters[i].name,
                            isSelected: isSelected,
                            icon: const Icon(Icons.check_sharp),
                            width: 0,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
