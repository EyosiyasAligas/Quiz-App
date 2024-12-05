import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/route/router.dart';
import '../../../../shared/service_locator.dart';
import '../../domain/entities/question_entity.dart';
import '../bloc/fetch_question/fetch_question_bloc.dart';
import '../bloc/submit_quiz/submit_quiz_bloc.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen(
      {super.key, required this.questions, required this.category});

  final List<QuestionEntity> questions;

  final String category;

  static Route route(RouteSettings routeSettings) {
    final args = routeSettings.arguments as Map<String, dynamic>;
    return MaterialPageRoute(
      builder: (_) =>
          MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => sl.get<FetchQuestionBloc>()),
                BlocProvider(create: (context) => sl.get<SubmitQuizBloc>()),
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
  int score = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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

  void _onOptionSelected(String selectedOption) {
    setState(() {
      widget.questions[_currentIndex].selectedAnswer = selectedOption;
    });
  }

  void _validateAnswer() {
    final currentQuestion = widget.questions[_currentIndex];
    if (currentQuestion.selectedAnswer == currentQuestion.correctAnswer) {
      score++;
    }
    print('score: $score');
    if (_currentIndex == widget.questions.length - 1) {
      context.read<SubmitQuizBloc>().add(SubmitQuiz(score));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('quiz_screen_app_bar'),
        title: Text(widget.category),
      ),
      body: BlocConsumer<SubmitQuizBloc, SubmitQuizState>(
        listener: (context, state) {
          if (state is SubmitQuizSuccess) {
            Navigator.of(context).pushReplacementNamed(
              Routes.resultScreen,
              arguments: score,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              height: size.height - AppBar().preferredSize.height,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(
                minHeight: size.height - AppBar().preferredSize.height,
                maxHeight: double.infinity,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: PageView.builder(
                      scrollBehavior: const MaterialScrollBehavior(),
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
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                          label: Text(_currentIndex == widget.questions.length - 1 ? 'Finish' : 'Next'),
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
