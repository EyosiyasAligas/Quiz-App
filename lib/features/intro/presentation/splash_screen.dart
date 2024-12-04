import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../core/route/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Route route(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if(mounted) {
        Navigator.pushReplacementNamed(
        context,
        Routes.preferenceScreen,
      );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Animate(
          effects: const [
            ScaleEffect(
              delay: Duration(
                milliseconds: 10,
              ),
              duration: Duration(
                seconds: 1,
              ),
            ),
          ],
          child: RotatedBox(
            quarterTurns: 0,
            child: Lottie.asset(
              'assets/json/splash.json',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
