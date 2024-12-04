import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/service_locator.dart';
import '../../domain/entities/question_entity.dart';
import '../bloc/fetch_question/fetch_question_bloc.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.questions});

  final List<QuestionEntity> questions ;

  static Route route(RouteSettings routeSettings) {
    List<QuestionEntity> questions = routeSettings.arguments as List<QuestionEntity>;
    return MaterialPageRoute(
      builder: (_) =>
          BlocProvider(
            create: (context) => sl.get<FetchQuestionBloc>(),
            child: QuizScreen(questions: questions,),
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
      body: Container(
        child: ListView(
          children: [
            ...widget.questions.map((question) => Text(question.question) )
          ],
        ),
      )
    );
  }
}
