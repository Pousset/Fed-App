import 'dart:io';

import 'package:fedhubs_pro/models/section/entreprise_gallery_model.dart';
import 'package:fedhubs_pro/screens/sections_form/galerie/entreprise_gallery_form_page.dart';
import 'package:fedhubs_pro/screens/sections_form/galerie/entreprise_gallery_list_page.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/entreprise_gallery_page/photo_gallery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EntrepriseGalleryPage extends StatefulWidget {
  const EntrepriseGalleryPage({super.key});

  @override
  State<EntrepriseGalleryPage> createState() => _EntrepriseGalleryPageState();
}

class _EntrepriseGalleryPageState extends State<EntrepriseGalleryPage> {
  late final CompanyProvider companyProvider;
  late Future<EntrepriseGalleryModel> _futureEntrepriseGalleryListModel;
  late final ApiReadEnterprise apiRead;

  @override
  void initState() {
    apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    _futureEntrepriseGalleryListModel =
        apiRead.fetchEntrepriseGalleryList(companyProvider.idClient!);
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
                    type: 2,
                    picture: value,
                  );
                }
              }),
            ),
            const SizedBox(height: 24),
            Text(
              'Vos photos',
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

    return FutureBuilder<EntrepriseGalleryModel>(
        future: _futureEntrepriseGalleryListModel,
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.hasError) {
            final gallery = snapshot.data;
            final allPictures = gallery?.gallery ?? [];
            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                PhotoGallery(
                  url: gallery?.bannerPicture?.url ?? '',
                  size: size,
                  text: 'Bannière',
                  subText:
                      '${gallery?.bannerPicture != null ? '1' : '0'} Photo',
                  onTap: () => EntrepriseGalleryListPage.push(context,
                      GalleryViewTypes.selectBanner, allPictures, updateList),
                ),
                PhotoGallery(
                  url: gallery?.profilPicture?.url ?? '',
                  size: size,
                  text: 'Photo de profil',
                  subText:
                      '${gallery?.profilPicture != null ? '1' : '0'} Photo',
                  onTap: () => EntrepriseGalleryListPage.push(context,
                      GalleryViewTypes.selectLogo, allPictures, updateList),
                ),
                PhotoGallery(
                  url: gallery?.gallery.isNotEmpty ?? false
                      ? gallery?.gallery.first.url ?? ''
                      : '',
                  size: size,
                  text: 'Galerie',
                  subText:
                      '${allPictures.length} Photo${allPictures.length > 1 ? 's' : ''}',
                  onTap: () => EntrepriseGalleryListPage.push(context,
                      GalleryViewTypes.readOnly, allPictures, updateList),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  void updateList() {
    setState(() {
      _futureEntrepriseGalleryListModel =
          apiRead.fetchEntrepriseGalleryList(companyProvider.idClient!);
    });
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
