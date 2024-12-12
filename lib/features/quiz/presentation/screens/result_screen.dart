import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/history/domain/entities/history_entity.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_enums.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/question_card.dart';
import 'package:quiz_app/shared/presentation/widgets/custom_button.dart';

import '../../../../core/route/router.dart';
import '../../../../shared/service_locator.dart';
import '../../../history/presentation/bloc/cache_history/cache_history_bloc.dart';
import '../../domain/entities/question_entity.dart';
import '../bloc/answer_question/answer_question_bloc.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.questions,
    required this.quizTitle,
    required this.type,
    required this.difficulty,
  });

  final List<QuestionEntity> questions;
  final int score;
  final String quizTitle;
  final QuizType type;
  final QuizDifficulty difficulty;

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
          quizTitle: args['quiz_title'],
          type: args['type'],
          difficulty: args['difficulty'],
        ),
      ),
    );
  }

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print all values
    context.read<CacheHistoryBloc>().add(
          CacheHistory(
            HistoryEntity(
              quizTitle: widget.quizTitle,
              score: widget.score,
              type: widget.type,
              difficulty: widget.difficulty,
              totalQuestions: widget.questions.length,
              questions: widget.questions,
              completedAt: DateTime.now(),
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
                    'Your Score: ${widget.score}/${widget.questions.length}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final question = widget.questions[index];
                    return QuestionCard(
                      isReview: true,
                      question: question,
                      index: index,
                      totalQuestions: widget.questions.length,
                    );
                  },
                  itemCount: widget.questions.length,
                ),
              ),
            ],
          ),
        ));
  }
}
