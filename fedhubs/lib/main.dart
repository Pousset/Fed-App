import 'package:fedhubs_pro/models/post/sign_up/sign_up_form.dart';
import 'package:fedhubs_pro/router/routes.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_create_entreprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_delete_entreprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/services/local/global_state.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:fedhubs_pro/services/local/login_state.dart';
import 'package:fedhubs_pro/widgets/navigations/panel_provider.dart';
import 'package:fedhubs_pro/widgets/others/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalDatabase().initializeHive();

  runApp(MyApp(
    loginState: LoginState(LocalDatabase()),
  ));
}

class MyApp extends StatelessWidget {
  final LoginState loginState;

  Future<PersistCookieJar> getCookieManager() async {
    final tempDir = await getTemporaryDirectory();
    return PersistCookieJar(storage: FileStorage(tempDir.path));
  }

  const MyApp({Key? key, required this.loginState}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final cookieJar = getCookieManager();
    return MultiProvider(
      providers: [
        Provider(
            lazy: false, create: (context) => ApiReadEnterprise(cookieJar)),
        Provider(
            lazy: false, create: (context) => ApiCreateEnterprise(cookieJar)),
        Provider(
            lazy: false, create: (context) => ApiUpdateEnterprise(cookieJar)),
        Provider(
            lazy: false, create: (context) => ApiDeleteEnterprise(cookieJar)),
        Provider(lazy: false, create: (context) => Auth(loginState, cookieJar)),
        Provider(lazy: false, create: (context) => GlobalState()),
        ChangeNotifierProvider(
            lazy: false, create: (context) => CompanyProvider()),
        ChangeNotifierProvider(lazy: false, create: (context) => SignUpForm()),
        ChangeNotifierProvider<PanelProvider>(
            lazy: false, create: (_) => PanelProvider(Container())),
        Provider<MyRouter>(
          lazy: false,
          create: (BuildContext createContext) => MyRouter(loginState),
        ),
      ],
      child: Builder(builder: (context) {
        final router = Provider.of<MyRouter>(context, listen: false).router;
        return MaterialApp.router(
          routeInformationProvider: router.routeInformationProvider,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          debugShowCheckedModeBanner: false,
          title: 'FEDHUBS',
          theme: CustomThemeData.data,
        );
      }),
    );
  }
}
