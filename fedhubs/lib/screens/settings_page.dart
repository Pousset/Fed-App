import 'package:fedhubs_pro/models/section/sect1_visit_card.dart';
import 'package:fedhubs_pro/screens/sections_form/category_filters/entreprise_filter_page.dart';
import 'package:fedhubs_pro/screens/sections_form/entreprise_information_page.dart';
import 'package:fedhubs_pro/screens/sections_form/entreprise_reservation_timetable_page.dart';
import 'package:fedhubs_pro/screens/sections_form/entreprise_timetable_page.dart';
import 'package:fedhubs_pro/screens/sections_form/menu/entreprise_menu_page.dart';
// import 'package:fedhubs_pro/screens/sections_form/menu/entreprise_menu_page.dart';
import 'package:fedhubs_pro/screens/sections_form/sect7_edit_external_services.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/company_header.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/expansion_tile.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/expansion_tile_text.dart';
import 'package:fedhubs_pro/widgets/select_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late CompanyProvider companyProvider;
  late ApiReadEnterprise apiRead;
  late Future<VisitCardSect1> _futureVisitCardSect1;
  bool alreadyRunFuture = false;

  Future changeCompany() async {
    await showDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        builder: (context) =>
            SelectAccountDialog(force: false, dialogContext: context));
  }

  Future signOut() async {
    await Provider.of<Auth>(context, listen: false).signOut();
  }

  @override
  void initState() {
    companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final companyProvider = Provider.of<CompanyProvider>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: GestureDetector(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(12, screenSize.height * 0.08, 12, 90),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (companyProvider.idClient != null) ...[
                      _buildHeader(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: _buildSettingsRows(companyProvider.idClient!),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (!alreadyRunFuture) {
      alreadyRunFuture = true;
      _futureVisitCardSect1 =
          apiRead.fetchVisitCardSect1(companyProvider.idClient!);
      _futureVisitCardSect1.then((value) => companyProvider.visitcard = value);
    }
    return FutureBuilder<VisitCardSect1?>(
      initialData: companyProvider.visitcard,
      future: _futureVisitCardSect1,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CompanyHeader(data: snapshot.data!);
        } else {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildSettingsRows(String idClient) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomExpansionTile(
          title: 'Compte',
          children: {
            "Information sur l'établissement":
                const EntrepriseInformationPage(),
            "Changer d'établissement": changeCompany,
            //"Gestion d'équipe": () {},
            //"Factures & abonnements": () {},
            "Déconnexion": signOut,
          },
        ),
        CustomExpansionTile(
          title: 'Personnalisation',
          children: {
            "Menu": const EntrepriseMenuPage(),
            "Horaires de réservation":
                const EntrepriseReservationTimetablePage(),
            //"Carte de fidélité numérique": () {},
           // "Photo de couverture & Logo": const EntrepriseGalleryPage(),
            "Horaires d'ouverture": const EntrepriseTimetablePage(),
            "Catégories et filtres": () =>
                EntrepriseCatgoryFiltersPage.show(context),
          },
        ),
        const SizedBox(height: 24),
        ExpansionTileText(
            text: "Services externes",
            page: FormEditServicesExtInfoPage(companyProvider.idClient!),
            bottom: 32),
        // ExpansionTileText(
        //     text: "Configuration des réservation", bottom: 32),
        // ExpansionTileText(text: "Publication presse", bottom: 32),
        // ExpansionTileText(text: "Avis"),
      ],
    );
  }
}
