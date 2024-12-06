import 'package:fedhubs_pro/router/constants_root_name.dart';
import 'package:fedhubs_pro/screens/change_reservation_forms/change_reservation_step_1.dart';
import 'package:fedhubs_pro/screens/change_reservation_forms/change_reservation_step_2.dart';
import 'package:fedhubs_pro/screens/change_reservation_forms/change_reservation_step_3.dart';
import 'package:fedhubs_pro/screens/companies/companies_display.dart';
import 'package:fedhubs_pro/screens/gestion_equipe/gestion_equipe.dart';
import 'package:fedhubs_pro/screens/gestion_equipe/gestion_equipe_change_profile.dart';
import 'package:fedhubs_pro/screens/gestion_equipe/gestion_equipe_profile.dart';
import 'package:fedhubs_pro/screens/message_reservation_attente/send_message_page_step_1.dart';
import 'package:fedhubs_pro/screens/message_reservation_attente/send_message_page_step_2.dart';
import 'package:fedhubs_pro/screens/message_reservation_attente/send_message_page_step_3.dart';
import 'package:fedhubs_pro/screens/settings/press_publication_add_picture.dart';
import 'package:fedhubs_pro/screens/settings_page.dart';
import 'package:fedhubs_pro/screens/sign_in/complete_profile.dart';
import 'package:fedhubs_pro/screens/sign_in/login_page.dart';
import 'package:fedhubs_pro/screens/root_page.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:fedhubs_pro/services/local/login_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/menu/create_carte.dart';


final observer = RouteObserver<PageRoute>();

class MyRouter {
  final LoginState loginState;

  MyRouter(this.loginState);

  late final router = GoRouter(
      refreshListenable: loginState,
      // debugLogDiagnostics: true,
      urlPathStrategy: UrlPathStrategy.path,
      routes: [
        GoRoute(
          name: rootRouteName,
          path: '/',
          redirect: (state) =>
              state.namedLocation(mainRouteName, params: {'tab': 'settings'}),
        ),
        GoRoute(
          name: loginRouteName,
          path: '/login',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: const CreateCarte(  sectionNames: [], )

            ),
          ),
        ),
        GoRoute(
          name: mainRouteName,
          path: '/:tab(events|reservations|settings)',
          pageBuilder: (context, state) {
            final tab = state.params['tab']!;
            return MaterialPage<void>(
                key: state.pageKey,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: RootPage(tab: tab),
                ));
          },
        ),
        // forwarding routes to remove the need to put the 'tab' param in the code
        GoRoute(
          path: '/events',
          redirect: (state) =>
              state.namedLocation(mainRouteName, params: {'tab': 'events'}),
        ),
        GoRoute(
          path: '/reservations',
          redirect: (state) => state
              .namedLocation(mainRouteName, params: {'tab': 'reservations'}),
        ),
        GoRoute(
          path: '/settings',
          redirect: (state) =>
              state.namedLocation(mainRouteName, params: {'tab': 'settings'}),
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: Scaffold(
                body: Center(child: Text(state.error?.toString() ?? 'Error'))),
          ),
      // redirect to the login page if the user is not logged in
      redirect: (state) {
        // if the user is not logged in, they need to login
        bool loggedIn = loginState.loggedIn;
        final user = LocalDatabase().getUser();
        try {
          loggedIn = user != null &&
              DateTime.parse(user.tokenExp).isAfter(DateTime.now());
        } on FormatException {
          loggedIn = false;
        }

        final loggingIn = state.subloc == '/login';
        if (!loggedIn) return loggingIn ? null : '/login';
        // if the user is logged in but still on the login page, send them to
        // the settings page
        if (loggingIn) return '/settings';

        // no need to redirect at all
        return null;
      },
      observers: [observer]);
}
