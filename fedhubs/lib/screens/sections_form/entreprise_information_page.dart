// ignore_for_file: unused_element

import 'package:fedhubs_pro/models/coordinates.dart';
import 'package:fedhubs_pro/models/section/entreprise_information_model.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/forms/custom_text_form_field.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/entreprise_info_page/map_preview.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/entreprise_info_page/social_network_section.dart';
import 'package:fedhubs_pro/widgets/others/validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:provider/provider.dart';

class EntrepriseInformationPage extends StatefulWidget {
  const EntrepriseInformationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return EntrepriseInformationPageState();
  }
}

class EntrepriseInformationPageState extends State<EntrepriseInformationPage> {
  bool isChanged = false;

  late final TextEditingController adressController;
  final mapController = MapController();
  final coordinates = CoordinatesModel();

  late final CompanyProvider companyProvider;
  late final Future<EntrepriseInformationModel> _futureEntrepriseInfo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EntrepriseInformationModel _modelEntrepriseInfo =
      EntrepriseInformationModel();
  late final ApiUpdateEnterprise apiUpdate;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      final state =
          await apiUpdate.putEstablishmentInformation(_modelEntrepriseInfo);
      setState(() => isChanged = !state);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SizedBox(
          height: 40,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  state ? "Changement enregisté" : "Une erreur est survenue")),
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ));
    }
  }

  @override
  void initState() {
    apiUpdate = Provider.of<ApiUpdateEnterprise>(context, listen: false);
    final apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    _futureEntrepriseInfo =
        apiRead.fetchEntrepriseInformation(companyProvider.idClient!);
    _futureEntrepriseInfo.then((value) {
      _modelEntrepriseInfo = value;
      adressController = TextEditingController(text: value.address);
      if (value.address != null) {
        coordinates
            .fromLocation(value.address!)
            .then((value) => setState(() {}));
      }
    });
    super.initState();
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
        leading: const CustomBackButton(),
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
      body: _buildContent(screenSize),
      floatingActionButton: isChanged
          ? Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: CustomFlatButton(
                color: Theme.of(context).secondaryHeaderColor,
                width: screenSize.width - 48,
                text: 'Appliquer',
                onPressed: _submit,
              ),
            )
          : null,
    );
  }

  Widget _buildContent(Size screenSize) {
    return FutureBuilder<EntrepriseInformationModel>(
      future: _futureEntrepriseInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return GestureDetector(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Form(
                  key: _formKey,
                  onChanged: (() => setState(() => isChanged = true)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Informations sur l’établissement',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 16),
                      _buildCompanyName(data!),
                      const SizedBox(height: 8),
                      _buildSpeciality(data),
                      const SizedBox(height: 8),
                      _buildDescription(data),
                      const SizedBox(height: 24),
                      Text(
                        'Coordonnées',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      _buildPhoneNumber(data),
                      const SizedBox(height: 8),
                      _buildWebsiteLink(data),
                      const SizedBox(height: 8),
                      _buildEmail(data),
                      const SizedBox(height: 16),
                      SocialNetworkFormSection(
                        data: data,
                        model: _modelEntrepriseInfo,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Emplacement',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      _buildAddress(data),
                      const SizedBox(height: 8),
                      MapPreview(
                          coordinates: coordinates, controller: mapController),
                      if (isChanged) const SizedBox(height: 56),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildCompanyName(EntrepriseInformationModel data) {
    return CustomTextFormField(
      initialValue: data.companyName,
      label: "Nom de l'entreprise",
      errorText: "Le nom de l'entreprise est nécessaire",
      onSaved: (String? value) => _modelEntrepriseInfo.companyName = value,
    );
  }

  Widget _buildSpeciality(EntrepriseInformationModel data) {
    return CustomTextFormField(
      initialValue: data.typeActivity,
      label: "Type d'activité",
      errorText: "Le type d'activité est récommandé",
      onSaved: (String? value) => _modelEntrepriseInfo.typeActivity = value,
    );
  }

  Widget _buildDescription(EntrepriseInformationModel data) {
    return CustomTextFormField(
      initialValue: data.description,
      label: "Description",
      errorText: "La description est fortement conseillé",
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      onSaved: (String? value) => _modelEntrepriseInfo.description = value,
    );
  }

  Widget _buildPhoneNumber(EntrepriseInformationModel data) {
    return CustomTextFormField(
      initialValue: data.phoneNumber,
      label: "Téléphone",
      keyboardType: TextInputType.phone,
      errorText: SignUpFormValidators().invalidWrongPhoneNumberErrorText,
      validator: (value) => PhoneNumberStringValidator().isValid(value ?? ''),
      onSaved: (String? value) => _modelEntrepriseInfo.phoneNumber = value,
    );
  }

  Widget _buildWebsiteLink(EntrepriseInformationModel data) {
    return CustomTextFormField(
      initialValue: data.websiteLink,
      label: "Site web",
      keyboardType: TextInputType.url,
      onSaved: (String? value) => _modelEntrepriseInfo.websiteLink = value,
    );
  }

  Widget _buildEmail(EntrepriseInformationModel data) {
    return CustomTextFormField(
      initialValue: data.email,
      label: "Email",
      keyboardType: TextInputType.emailAddress,
      onSaved: (String? value) => _modelEntrepriseInfo.email = value,
    );
  }

  Widget _buildAddress(EntrepriseInformationModel data) {
    return CustomTextFormField(
      controller: adressController,
      label: "Adresse de l'établissement",
      onSaved: (String? value) => _modelEntrepriseInfo.address = value,
      keyboardType: TextInputType.streetAddress,
      onEditingComplete: () async {
        await coordinates.fromLocation(adressController.text);
        mapController.move(LatLng(coordinates.lat, coordinates.lon), 15);
        setState(() {});
      },
    );
  }
}
