import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/theme/app_colors.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/timer/timer_bloc.dart';

import '../../../../core/route/router.dart';
import '../../../../core/utils/helper.dart';
import '../../../../shared/service_locator.dart';
import '../../domain/entities/question_entity.dart';
import '../bloc/answer_question/answer_question_bloc.dart';
import '../bloc/fetch_question/fetch_question_bloc.dart';

// import '../bloc/submit_quiz/submit_quiz_bloc.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen(
      {super.key, required this.questions, required this.category});

  final List<QuestionEntity> questions;

  final String category;

  static Route route(RouteSettings routeSettings) {
    final args = routeSettings.arguments as Map<String, dynamic>;
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl.get<FetchQuestionBloc>()),
            BlocProvider(create: (context) => sl.get<TimerBloc>()),
            BlocProvider(create: (context) => sl.get<AnswerQuestionBloc>()),
          ],
          child: QuizScreen(
            questions: args['questions'],
            category: args['category'],
          )),
    );
  }

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  late Size size;
  late ThemeData themeData;
  late int totalDuration;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    totalDuration = widget.questions.length * 10;
    context.read<TimerBloc>().add(TimerStarted(duration: totalDuration));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.sizeOf(context);
    themeData = Theme.of(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    if (_currentIndex < widget.questions.length - 1 /*&&
        widget.questions[_currentIndex].selectedAnswer!.isNotEmpty*/) {
      setState(() {
        _currentIndex++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }
  }

  void _onSkipQuestion() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }
  }

  void _onOptionSelected(String selectedOption) {
    context.read<AnswerQuestionBloc>().add(
          AnswerQuestion(
            questionIndex: _currentIndex,
            selectedAnswer: selectedOption,
            questions: widget.questions,
          ),
        );
  }

  void _validateAnswer() {
    if (_currentIndex == widget.questions.length - 1) {
      var score = context.read<AnswerQuestionBloc>().score;
      context.read<AnswerQuestionBloc>().add(
            CompleteQuiz(
              questions: widget.questions,
              score: score,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('quiz_screen_app_bar'),
        title: Text(widget.category),
      ),
      body: BlocListener<AnswerQuestionBloc, AnswerQuestionState>(
        listener: (context, state) {
          if (state is AnswerQuestionComplete) {
            Navigator.of(context).pushReplacementNamed(
              Routes.resultScreen,
              arguments: {
                'score': state.score,
                'questions': state.questions,
              },
            );
          }
        },
        child: Container(
          // height: size.height - AppBar().preferredSize.height,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildTimer(),
              Flexible(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                      key: Key('question ${index + 1}'),
                      index: index,
                      totalQuestions: widget.questions.length,
                      question: widget.questions[index],
                      shadowColor: themeData.colorScheme.secondary,
                      onOptionSelected: _onOptionSelected,
                      onSkipPressed: _onSkipQuestion,
                    );
                  },
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentIndex != 0)
                    TextButton.icon(
                      onPressed: _previousQuestion,
                      label: Text('Previous'),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                    ),
                  const SizedBox(width: 10),
                  TextButton.icon(
                    onPressed: () {
                      _validateAnswer();
                      _nextQuestion();
                    },
                    iconAlignment: IconAlignment.end,
                    label: Text(_currentIndex == widget.questions.length - 1
                        ? 'Finish'
                        : 'Next'),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimer() {
    return BlocConsumer<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state is TimerRunComplete) {
          var score = context.read<AnswerQuestionBloc>().score;
          context.read<AnswerQuestionBloc>().add(
                CompleteQuiz(
                  questions: widget.questions,
                  score: score,
                ),
              );
        }
      },
      builder: (context, state) {
        final duration = state.duration;
        final minutesStr =
            ((duration / 60) % 60).floor().toString().padLeft(2, '0');
        final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
        final progress = duration / totalDuration;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  // width: size.width - 100,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    color: (progress <= 0.2)
                        ? AppColors.errorColor
                        : themeData.colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                '$minutesStr:$secondsStr',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
