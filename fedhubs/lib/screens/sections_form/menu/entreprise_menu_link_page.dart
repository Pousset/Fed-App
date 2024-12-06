import 'package:fedhubs_pro/models/section/entreprise_menu_model.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_create_entreprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_delete_entreprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/forms/custom_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EntrepriseMenuLinkPage extends StatefulWidget {
  const EntrepriseMenuLinkPage({super.key, this.model});

  static Future<bool> push(BuildContext context, {MenuLink? model}) async {
    return await Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(
      builder: (context) => EntrepriseMenuLinkPage(model: model),
      fullscreenDialog: true,
    ));
  }

  final MenuLink? model;

  @override
  State<EntrepriseMenuLinkPage> createState() => _EntrepriseMenuLinkPageState();
}

class _EntrepriseMenuLinkPageState extends State<EntrepriseMenuLinkPage> {
  late final apiCreate =
      Provider.of<ApiCreateEnterprise>(context, listen: false);
  late final apiUpdate =
      Provider.of<ApiUpdateEnterprise>(context, listen: false);
  late final apiDelete =
      Provider.of<ApiDeleteEnterprise>(context, listen: false);

  late final bool isUpdate = widget.model != null;
  bool isChanged = false;
  bool pendingState = false;

  late final CompanyProvider companyProvider =
      Provider.of<CompanyProvider>(context, listen: false);
  late final _modelMenuLink =
      MenuLink.fromJson(widget.model != null ? widget.model!.toJson() : {});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit() async {
    if (pendingState) return;
    pendingState = true;

    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      late final bool state;
      if (isUpdate) {
        state = await apiUpdate.putEntrepriseMenuLink(
            _modelMenuLink, companyProvider.idClient!);
      } else {
        state = await apiCreate.postEntrepriseMenuLink(
            _modelMenuLink, companyProvider.idClient!);
      }
      setState(() => isChanged = !state);
      pendingState = false;

      if (!mounted) return;
      if (isUpdate) {
        if (state) widget.model!.setMenuLink(_modelMenuLink);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: SizedBox(
            height: 40,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(state
                    ? "Changement enregisté"
                    : "Une erreur est survenue")),
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ));
      } else {
        Navigator.of(context).pop(true);
      }
    }
  }

  void delete() async {
    final state =
        await apiDelete.deleteEntrepriseMenuLink(_modelMenuLink.idMenu);
    if (!mounted) return;
    Navigator.of(context).pop(state);
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
        leading: const CustomBackButton(popValue: false),
        title: Text(
          'Menu',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: isUpdate
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/trash.svg',
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    onPressed: delete,
                  ),
                ),
              ]
            : null,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildContent(screenSize),
      floatingActionButton: isChanged || !isUpdate
          ? Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: CustomFlatButton(
                color: Theme.of(context).secondaryHeaderColor,
                width: screenSize.width - 48,
                text: 'Enregistrer',
                onPressed: _submit,
              ),
            )
          : null,
    );
  }

  Widget _buildContent(Size screenSize) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(false);
        return false;
      },
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Form(
            key: _formKey,
            onChanged: (() => setState(() => isChanged = true)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lien vers le menu",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  "Ajoutez directement un lien vers votre menu pour montrer aux "
                  "clients les plats et boissons que vous proposez. ",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                ..._buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildForm() {
    return [
      CustomTextFormField(
        initialValue: _modelMenuLink.name,
        label: "Nom de la carte",
        errorText: "Le nom est obligatoire",
        onSaved: (String? value) => _modelMenuLink.name = value ?? '',
      ),
      const SizedBox(height: 8),
      CustomTextFormField(
        initialValue: _modelMenuLink.link,
        label: "Lien",
        errorText: "Le lien est obligatoire",
        onSaved: (String? value) => _modelMenuLink.link = value ?? '',
      ),
    ];
  }
}
