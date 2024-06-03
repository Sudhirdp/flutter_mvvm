import 'package:flutter/material.dart';
import 'package:flutter_mvvm_learning/view/splash_view.dart';
import '../../view/signup_view.dart';
import 'routes_name.dart';
import '/view/home_screen.dart';
import '/view/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => const SignupScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold( 
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
