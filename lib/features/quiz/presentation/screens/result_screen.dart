import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/question_card.dart';
import 'package:quiz_app/shared/presentation/widgets/custom_button.dart';

import '../../../../core/route/router.dart';
import '../../../../shared/service_locator.dart';
import '../../domain/entities/question_entity.dart';
import '../bloc/answer_question/answer_question_bloc.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.score, required this.questions});

  final List<QuestionEntity> questions;
  final int score;

  static Route route(RouteSettings routeSettings) {
    final args = routeSettings.arguments as Map<String, dynamic>;
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl.get<AnswerQuestionBloc>()),
        ],
        child: ResultScreen(
          score: args['score'],
          questions: args['questions'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              Routes.home,
            );
          },
          child: const Icon(Icons.home_filled),
        ),
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Score: $score/${questions.length}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return QuestionCard(
                      isReview: true,
                      question: question,
                      index: index,
                      totalQuestions: questions.length,
                    );
                  },
                  itemCount: questions.length,
                ),
              ),
            ],
          ),
        ));
  }
}
