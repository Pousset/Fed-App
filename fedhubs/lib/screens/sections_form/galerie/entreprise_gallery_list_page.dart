import 'dart:io';

import 'package:fedhubs_pro/models/section/entreprise_gallery_model.dart';
import 'package:fedhubs_pro/screens/sections_form/galerie/entreprise_gallery_form_page.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/entreprise_gallery_page/photo_gallery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum GalleryViewTypes {
  selectBanner,
  selectLogo,
  readOnly,
}

class EntrepriseGalleryListPage extends StatefulWidget {
  const EntrepriseGalleryListPage({
    super.key,
    required this.viewTypes,
    required this.gallery,
    required this.updateList,
  });

  final GalleryViewTypes viewTypes;
  final List<GalleryPicture> gallery;
  final VoidCallback updateList;

  static Future<void> push(
    BuildContext context,
    GalleryViewTypes viewTypes,
    List<GalleryPicture> gallery,
    VoidCallback updateList,
  ) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => EntrepriseGalleryListPage(
        viewTypes: viewTypes,
        gallery: gallery,
        updateList: updateList,
      ),
      fullscreenDialog: true,
    ));
  }

  @override
  State<EntrepriseGalleryListPage> createState() =>
      _EntrepriseGalleryListPageState();
}

class _EntrepriseGalleryListPageState extends State<EntrepriseGalleryListPage> {
  late final CompanyProvider companyProvider =
      Provider.of<CompanyProvider>(context, listen: false);
  late final apiUpdate =
      Provider.of(context)<ApiUpdateEnterprise>(context, listen: false);

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
              'Galerie',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              "Présentez votre établissement aux utilisateurs avec un visuel "
              "attrayant.",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            _buildButton(
              'Sélectionner une photo',
              () => _pickImage(ImageSource.gallery).then((value) {
                if (value != null) {
                  EntrepriseGalleryFormPage.push(
                    context,
                    type: widget.viewTypes == GalleryViewTypes.selectBanner
                        ? 0
                        : (widget.viewTypes == GalleryViewTypes.selectLogo
                            ? 1
                            : 2),
                    picture: value,
                  ).then((state) {
                    if (state) {
                      widget.updateList();
                    } else {
                      setState(() {});
                    }
                    if (widget.viewTypes != GalleryViewTypes.readOnly) {
                      Navigator.of(context).pop();
                    }
                  });
                }
              }),
            ),
            const SizedBox(height: 24),
            Text(
              'Galerie',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 24),
            _buildCase(screenSize),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String title, VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_camera_outlined,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCase(Size screenSize) {
    final double size = screenSize.width / 2 - 30;

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(
        widget.gallery.length,
        (index) => PhotoGallery(
          url: widget.gallery[index].url,
          size: size,
          onTap: () async {
            if (widget.viewTypes == GalleryViewTypes.readOnly) {
              EntrepriseGalleryFormPage.push(context,
                      model: widget.gallery[index])
                  .then((state) {
                if (state) {
                  widget.updateList();
                } else {
                  setState(() {});
                }
              });
            } else {
              widget.gallery[index].type =
                  widget.viewTypes == GalleryViewTypes.selectLogo ? 1 : 0;
              await apiUpdate.putEntrepriseGalleryPicture(
                  widget.gallery[index], companyProvider.idClient!);
              if (!mounted) return;
              Navigator.of(context).pop();
            }
          },
        ),
      ),
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
