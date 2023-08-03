
import 'package:copick_data_web/pages/admin/admin_page.dart';
import 'package:copick_data_web/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/login/login_page.dart';
import '../pages/splash/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      // case Routes.root:
      //   return MaterialPageRoute(
      //     builder: (context) => RootPage(),
      //   );
      // case Routes.home:
      //   return MaterialPageRoute(
      //     builder: (context) => Home(),
      //   );
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => SplashPage(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case Routes.admin:
        return MaterialPageRoute(
          builder: (context) => AdminPage(),
        );
      // case Routes.location:
      //   return MaterialPageRoute(
      //     builder: (context) => WasteLocationPage(),
      //   );
      default:
        return MaterialPageRoute(
          builder: (context) => MyApp(),
        );
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
