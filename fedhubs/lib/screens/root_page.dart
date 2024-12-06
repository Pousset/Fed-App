import 'package:fedhubs_pro/router/routes.dart';
import 'package:fedhubs_pro/screens/event_displays/event_list.dart';
import 'package:fedhubs_pro/screens/settings_page.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:fedhubs_pro/widgets/navigations/bottom_bar_navigation.dart';
import 'package:fedhubs_pro/widgets/navigations/tab_item.dart';
import 'package:fedhubs_pro/widgets/select_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RootPage extends StatefulWidget {
  RootPage({required String tab, Key? key})
      : index = indexFrom(tab),
        super(key: key);
  final int index;

  @override
  State<RootPage> createState() => _RootPageState();

  static int indexFrom(String tab) {
    switch (tab) {
      case 'events':
        return 0;
      case 'reservations':
        return 1;
      case 'settings':
        return 2;
      default:
        return 0;
    }
  }
}

class _RootPageState extends State<RootPage>
    with RouteAware, WidgetsBindingObserver {
  final pc = PanelController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return BottomBarNavigation(
      currentPage: widget.index,
      tabs: TabItem.values,
      panelController: pc,
      page: [
        const EventListPage(),
        Container(color: Theme.of(context).colorScheme.background),
        const SettingsPage(),
      ],
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    final cp = Provider.of<CompanyProvider>(context, listen: false);
    final id = LocalDatabase().getAccountId;

    if (cp.idClient == null || cp.idAccount != id) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            barrierDismissible: false,
            context: context,
            builder: (context) =>
                SelectAccountDialog(force: true, dialogContext: context));
      });
    }

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Provider.of<Auth>(context, listen: false).loginState.checkLoggedIn();
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    observer.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPushNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<Auth>(context, listen: false).loginState.checkLoggedIn());
    super.didPush();
  }

  @override
  void didPopNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<Auth>(context, listen: false).loginState.checkLoggedIn());
    super.didPush();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    observer.unsubscribe(this);
    super.dispose();
  }
}
