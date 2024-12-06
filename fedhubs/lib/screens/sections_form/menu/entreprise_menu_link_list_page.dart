import 'package:fedhubs_pro/models/section/entreprise_menu_model.dart';
import 'package:fedhubs_pro/screens/sections_form/menu/entreprise_menu_link_page.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EntrepriseMenuLinkListPage extends StatefulWidget {
  const EntrepriseMenuLinkListPage({super.key});

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => const EntrepriseMenuLinkListPage(),
      fullscreenDialog: true,
    ));
  }

  @override
  State<EntrepriseMenuLinkListPage> createState() =>
      _EntrepriseMenuLinkListPageState();
}

class _EntrepriseMenuLinkListPageState
    extends State<EntrepriseMenuLinkListPage> {
  bool isChanged = false;

  late final CompanyProvider companyProvider;
  late final ApiReadEnterprise apiRead;
  late Future<EntrepriseMenuLinkListModel> _futureEntrepriseMenuLinkListModel;

  @override
  void initState() {
    apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    _futureEntrepriseMenuLinkListModel =
        apiRead.fetchEntrepriseMenuLinkList(companyProvider.idClient!);
    super.initState();
  }

  void updateList() {
    setState(() {
      _futureEntrepriseMenuLinkListModel =
          apiRead.fetchEntrepriseMenuLinkList(companyProvider.idClient!);
    });
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
      body: _buildContent(screenSize),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: CustomFlatButton(
          color: Theme.of(context).secondaryHeaderColor,
          width: screenSize.width - 48,
          text: 'Ajouter un menu',
          icon: Icons.add_rounded,
          onPressed: () => EntrepriseMenuLinkPage.push(context).then((state) {
            if (state) updateList();
          }),
        ),
      ),
    );
  }

  Widget _buildContent(Size screenSize) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cartes ajoutés",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              "Retrouver ici les cartes que vous avez déjà ajouté.",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildMenuList(screenSize)
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList(Size screenSize) {
    return FutureBuilder<EntrepriseMenuLinkListModel>(
      future: _futureEntrepriseMenuLinkListModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MenuLink> menuList = snapshot.data!.menulist;
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screenSize.height - 264),
            child: ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                final menu = menuList[index];
                return _buildMenuLinkRow(screenSize, menu, context);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return const SizedBox();
        } else {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildMenuLinkRow(
      Size screenSize, MenuLink menu, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenSize.width - 80,
                ),
                child: Text(
                  menu.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenSize.width - 80,
                ),
                child: Text(
                  menu.link,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              EntrepriseMenuLinkPage.push(
                context,
                model: menu,
              ).then((state) {
                if (state) {
                  updateList();
                } else {
                  setState(() {});
                }
              });
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ],
      ),
    );
  }
}
