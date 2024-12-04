import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../features/intro/presentation/splash_screen.dart';
import '../../features/quiz/presentation/screens/preference_screen.dart';
import '../../features/quiz/presentation/screens/quiz_screen.dart';
import '../../features/quiz/presentation/screens/result_screen.dart';

class Routes {
  static const String splash = "splash";
  static const String home = "/";
  static const String preferenceScreen = "/preferenceScreen";
  static const String quizScreen = "/quizScreen";
  static const String resultScreen = "/resultScreen";


  static String currentRoute = splash;

  static Route<dynamic> onGenerateRouted(RouteSettings routeSettings) {
    currentRoute = routeSettings.name ?? "";
    if (kDebugMode) {
      print("Route: $currentRoute");
    }
    switch (routeSettings.name) {
      case splash:
        {
          return SplashScreen.route(routeSettings);
        }
      case preferenceScreen:
        {
          return PreferenceScreen.route(routeSettings);
        }
      case quizScreen:
        {
          return QuizScreen.route(routeSettings);
        }
      case resultScreen:
        {
          return ResultScreen.route(routeSettings);
        }
      default:
        {
          return MaterialPageRoute(builder: (context) => const Scaffold());
        }
    }
  }
}
