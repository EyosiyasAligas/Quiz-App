import 'package:flutter/material.dart';
import 'package:quiz_app/shared/presentation/widgets/custom_button.dart';

import '../../../../core/route/router.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.score});

  final int score;

  static Route route(RouteSettings routeSettings) {
    final int score = routeSettings.arguments as int;
    return MaterialPageRoute(
      builder: (_) => ResultScreen(
        score: score,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your score is $score',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Home',
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.preferenceScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
