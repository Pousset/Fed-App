import 'package:fedhubs_pro/screens/sections_form/menu/entreprise_menu_link_list_page.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntrepriseMenuPage extends StatelessWidget {
  const EntrepriseMenuPage({super.key});

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
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildContent(context, screenSize),
    );
  }

  Widget _buildContent(BuildContext context, Size screenSize) {
    return SingleChildScrollView(
      child: Container(
        height: screenSize.height - 156,
        margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // _buildButton(context, 'Remplir le menu manuellement', () {}),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 40.0),
            //   child: Text(
            //     'OU',
            //     textAlign: TextAlign.center,
            //     style: Theme.of(context)
            //         .textTheme
            //         .displaySmall!
            //         .copyWith(fontSize: 16),
            //   ),
            // ),
            _buildButton(context, 'Ajouter le lien de votre menu', () {
              EntrepriseMenuLinkListPage.push(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: double.infinity,
        height: 176,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 16,
                ),
          ),
        ),
      ),
    );
  }
}
