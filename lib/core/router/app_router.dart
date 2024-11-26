import 'package:flutter/material.dart';
import 'package:flutter_template/core/router/app_routes_names.dart';
import 'package:flutter_template/core/router/middleware.dart';
import 'package:flutter_template/core/widgets/splash_screen.dart';
import 'package:flutter_template/core/widgets/ui_components_screen.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.uiComponentScreen:
        return MaterialPageRoute(
          builder: (context) => const UiComponentScreen(),
          settings: routeSettings,
        );

      default:
        return null;
    }
  }
}
