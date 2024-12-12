import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
  bool canSeeReview = false;
  late Size size;
  late ThemeData themeData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.sizeOf(context);
    themeData = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.home,
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height * 0.9,
            padding: const EdgeInsets.all(20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!canSeeReview)
                  Container(
                    padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
                    width: double.infinity,
                    height: size.height * 0.7,
                    decoration: BoxDecoration(
                      color: themeData.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Your Score',
                          style: themeData.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: size.height * 0.3,
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  width: size.height * 0.2,
                                  child: CircularProgressIndicator(
                                    value: widget.score / widget.questions.length,
                                    strokeWidth: 8,
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${((widget.score / widget.questions.length) * 100).toStringAsFixed(2)}%',
                                  textAlign: TextAlign.center,
                                  style: themeData.textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Lottie.asset(
                          'assets/json/trophy.json',
                          height: size.height * 0.2,
                        ),
                        const Spacer(),
                        CustomButton(
                          onPressed: () {
                            setState(() {
                              canSeeReview = true;
                            });
                          },
                          width: size.width * 0.7,
                          text: 'Check Solutions',
                        ),
                      ],
                    ),
                  ),
                if (canSeeReview)
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
          ),
        ));
  }
}
