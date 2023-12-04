import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:water_tank_automation/routes/route_names.dart';
import 'package:water_tank_automation/views/error_page.dart';
import 'package:water_tank_automation/views/home_page.dart';
import 'package:water_tank_automation/views/login_page.dart';
import 'package:water_tank_automation/views/water_tank_level.dart';

class MyAppRouter {
  /// The route configuration.
  static GoRouter router() {
    return GoRouter(
      routes: [
        GoRoute(
          name: RouteNames.loginRoute,
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(child: LoginPage());
          },
        ),
        GoRoute(
          name: RouteNames.homeRoute,
          path: '/homePageRoute',
          pageBuilder: (context, state) {
            return MaterialPage(child: HomePage());
          },
        ),
        // GoRoute(
        //   name: RouteNames.profileRoute,
        //   path: '/profile/:username/:userid',
        //   pageBuilder: (context, state) {
        //     return MaterialPage(
        //         child: Profile(
        //           userid: state.params['userid']!,
        //           username: state.params['username']!,
        //         ));
        //   },
        // ),
        GoRoute(
          name: RouteNames.waterLevelRoute,
          path: '/waterLevelRoute',
          pageBuilder: (context, state) {
            return const MaterialPage(child: WaterTankLevelPage());
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        return const MaterialPage(child: ErrorPage());
      },
    );
  }

  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: RouteNames.homeRoute,
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: HomePage());
          },
        ),
        // GoRoute(
        //   name: RouteNames.profileRoute,
        //   path: '/profile/:username/:userid',
        //   pageBuilder: (context, state) {
        //     return MaterialPage(
        //         child: Profile(
        //           userid: state.params['userid']!,
        //           username: state.params['username']!,
        //         ));
        //   },
        // ),
        GoRoute(
          name: RouteNames.waterLevelRoute,
          path: '/waterLevelRoute',
          pageBuilder: (context, state) {
            return const MaterialPage(child: WaterTankLevelPage());
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        return const MaterialPage(child: ErrorPage());
      },
    );
    return router;
  }
}
