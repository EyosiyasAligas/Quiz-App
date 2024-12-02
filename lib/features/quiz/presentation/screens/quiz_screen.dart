import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/service_locator.dart';
import '../bloc/fetch_question/fetch_question_bloc.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  static Route route(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) =>
          BlocProvider(
            create: (context) => sl.get<FetchQuestionBloc>(),
            child: const QuizScreen(),
          ),
    );
  }

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('quiz_screen_app_bar'),
        title: const Text('Quizzes'),
      ),
      body: Center(
        child: Text('Quiz Screen'),
      ),
    );
  }
}
