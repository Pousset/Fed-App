import 'dart:io';
import 'package:fedhubs_pro/models/section/entreprise_gallery_model.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_create_entreprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_delete_entreprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/forms/custom_text_form_field.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/entreprise_gallery_page/photo_gallery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EntrepriseGalleryFormPage extends StatefulWidget {
  const EntrepriseGalleryFormPage({
    super.key,
    this.model,
    this.picture,
    this.type,
  }) : assert((type != null) ^ (model != null));

  final GalleryPicture? model;
  final int? type;
  final File? picture;

  static Future<bool> push(BuildContext context,
      {GalleryPicture? model, int? type, File? picture}) async {
    return await Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(
      builder: (context) => EntrepriseGalleryFormPage(
        model: model,
        type: type,
        picture: picture,
      ),
      fullscreenDialog: true,
    ));
  }

  @override
  State<EntrepriseGalleryFormPage> createState() =>
      _EntrepriseGalleryFormPageState();
}

class _EntrepriseGalleryFormPageState extends State<EntrepriseGalleryFormPage> {
  late final bool isUpdate = widget.model != null;
  late File? picture = widget.picture;
  bool state = false;
  bool isChanged = false;
  bool pendingState = false;

  late final companyProvider =
      Provider.of<CompanyProvider>(context, listen: false);
  late final apiCreate =
      Provider.of<ApiCreateEnterprise>(context, listen: false);
  late final apiUpdate =
      Provider.of<ApiUpdateEnterprise>(context, listen: false);
  late final apiDelete =
      Provider.of<ApiDeleteEnterprise>(context, listen: false);

  late final GalleryPicture _modelGalleryPicture;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _modelGalleryPicture = GalleryPicture.fromJson(
        widget.model != null ? widget.model!.toJson() : {});
    if (widget.type != null) _modelGalleryPicture.type = widget.type!;
    super.initState();
  }

  void _submit() async {
    if (pendingState) return;
    pendingState = true;

    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      if (isUpdate) {
        state = await apiUpdate.putEntrepriseGalleryPicture(
            _modelGalleryPicture, companyProvider.idClient!,
            picture: picture);
      } else {
        state = await apiCreate.postEntrepriseGalleryPicture(
            _modelGalleryPicture, picture!, companyProvider.idClient!);
      }
      setState(() => isChanged = !state);
      pendingState = false;

      if (!mounted) return;
      if (isUpdate) {
        if (state) widget.model!.setGalleryPicture(_modelGalleryPicture);
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
        await apiDelete.deleteEntrepriseGalleryPicture(_modelGalleryPicture.id);
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
      body: _buildContent(context, screenSize),
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

  Widget _buildContent(BuildContext context, Size screenSize) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(state);
        return false;
      },
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: screenSize.height - 156),
          margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Form(
            key: _formKey,
            onChanged: (() => setState(() => isChanged = true)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 16),
                Text(
                  "Ajouter une description à vos images pour informer au mieux vos "
                  "utilisateurs.",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                _buildForm(screenSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(Size screenSize) {
    final double size = screenSize.width / 2 - 30;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            _buildName(size),
            const SizedBox(height: 16),
            _buildDescription(size),
          ],
        ),
        PhotoGallery(
            url: picture != null ? null : _modelGalleryPicture.url,
            file: picture,
            size: size,
            onTap: () => _pickImage(ImageSource.gallery).then((value) {
                  if (value != null) {
                    setState(() {
                      isChanged = true;
                      picture = value;
                    });
                  }
                }))
      ],
    );
  }

  Widget _buildName(double width) {
    return CustomTextFormField(
      initialValue: _modelGalleryPicture.name,
      label: "Nom",
      width: width,
      onSaved: (String? value) => _modelGalleryPicture.name = value!,
    );
  }

  Widget _buildDescription(double width) {
    return CustomTextFormField(
      initialValue: _modelGalleryPicture.description,
      label: "Description",
      width: width,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
      onSaved: (String? value) => _modelGalleryPicture.description = value!,
    );
  }

  Future<File?> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (image == null) return null;
      final imageTemp = File(image.path);
      return await editPicture(imageTemp) ?? imageTemp;
    } on PlatformException {
      rethrow;
    }
  }

  Future<File?> editPicture(File originalPicture) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: originalPicture.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Redimensionner',
          toolbarColor: Theme.of(context).secondaryHeaderColor,
          toolbarWidgetColor: Colors.white,
          statusBarColor: Theme.of(context).secondaryHeaderColor,
          initAspectRatio: CropAspectRatioPreset.original,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }
}
