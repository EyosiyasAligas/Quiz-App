import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quiz/data/data_sources/remote/quiz_impl_api.dart';
import 'package:quiz_app/features/quiz/data/repositories/quiz_repository_impl.dart';

import '../../domain/entities/question_entity.dart';
import '../../domain/entities/quiz_entity.dart';
import '../../domain/usecases/add_quiz_usecase.dart';
import '../bloc/add_quiz/add_quiz_bloc.dart';
import '../bloc/fetch_quiz/fetch_quiz_bloc.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var isSubmitted = false;

  var controller = TextEditingController();

  QuizEntity quiz = QuizEntity(
    id: '',
    title: '',
    questions: [
      QuestionEntity(
        id: '',
        questionText: '',
        options: ['', '', '', ''],
        correctAnswer: '',
        selectedAnswer: '',
      ),
    ],
  );

  Widget buildAddQuizBottomSheet(ctx) {
    // create a quiz object
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(ctx).size.height * 0.8,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              key: const Key('title'),
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter quiz title',
              ),
              onChanged: (value) {
                quiz.title = value;
              },
            ),
            const SizedBox(height: 10),
            // add question form
            Column(
              children: quiz.questions.map((question) {
                return Column(
                  children: [
                    TextField(
                      key: const Key('question'),
                      decoration: const InputDecoration(
                        hintText: 'Enter question',
                      ),
                      onChanged: (value) {
                        question.questionText = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    // add options form
                    Column(
                      children: [
                        ...List.generate(
                          4,
                          (index) {
                            return TextField(
                              key: Key('option_$index'),
                              decoration: InputDecoration(
                                hintText: 'Enter option ${index + 1}',
                              ),
                              onChanged: (value) {
                                print('option $index value: $value');
                                question.options[index] = value;
                                print(
                                    'option $index: ${question.options[index]}');
                              },
                            );
                          },
                        ),
                        // correct answer form
                        const SizedBox(height: 10),
                        TextField(
                          key: const Key('correct_answer'),
                          decoration: const InputDecoration(
                            hintText: 'Enter correct answer',
                          ),
                          onChanged: (value) {
                            question.correctAnswer = value;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
            ),
            ElevatedButton(
              key: const Key('add_button'),
              onPressed: () {
                // check if the quiz title, question and options are not empty
                print('quiz: ${quiz.questions.first.options}');
                print('quiz correct: ${quiz.questions.first.correctAnswer}');
                print('quiz correct: ${quiz.questions.first.questionText}');
                if (quiz.title.isEmpty ||
                    quiz.questions.any((question) =>
                        question.questionText.isEmpty ||
                        question.options.any((option) => option.isEmpty) ||
                        question.correctAnswer.isEmpty)) {
                  showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please fill all fields'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                  return;
                }
                context.read<AddQuizBloc>().add(AddQuiz(quiz));
                quiz = QuizEntity(
                  id: '',
                  title: '',
                  questions: [
                    QuestionEntity(
                      id: '',
                      questionText: '',
                      options: const ['', '', '', ''],
                      correctAnswer: '',
                      selectedAnswer: '',
                    ),
                  ],
                );
                Navigator.pop(context);
              },
              child: const Text(
                key: Key('add_quiz_button'),
                'Add Quiz',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('quiz_screen_app_bar'),
        title: const Text('Quizzes'),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => AddQuizBloc(
          AddQuizUseCase(
            QuizRepositoryImplementation(QuizImplApi(Dio())),
          ),
        ),
        child: FloatingActionButton(
          key: const Key('addIcon'),
          onPressed: () async {
            await showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return buildAddQuizBottomSheet(context);
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: BlocConsumer<AddQuizBloc, AddQuizState>(
        listener: (context, state) {
          if (state is AddQuizSuccess) {
            context.read<FetchQuizBloc>().add(FetchQuiz());
            print('error message: ${state.message}');
          }
          if (state is AddQuizFailure) {
            print('error message: ${state.message}');
            showAdaptiveDialog(
              context: context,
              builder: (context) {
                print('error message: ${state.message}');
                return AlertDialog(
                  key: const Key('error dialog'),
                  title: const Text('Error'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<FetchQuizBloc, FetchQuizState>(
            builder: (context, state) {
              if (state is FetchQuizLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is FetchQuizLoadFailure) {
                return Center(
                  key: const Key('error widget'),
                  child: Text(state.errorMessage),
                );
              }
              if (state is FetchQuizLoadSuccess) {
                final quizzes = state.quiz;
                return ListView.builder(
                  key: const Key('quizList'),
                  itemCount: quizzes.length,
                  itemBuilder: (context, quizIndex) {
                    final quiz = quizzes[quizIndex];
                    return Padding(
                      key: Key(quiz.title),
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Center(
                          child: Column(
                            children: [
                              ExpansionTile(
                                title: Text(
                                  quiz.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                children: quiz.questions.map((question) {
                                  return ListTile(
                                    title: Text(question.questionText),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: question.options.map((option) {
                                        return RadioListTile(
                                          title: Text(option),
                                          // selected: question.selectedAnswer == question.correctAnswer,
                                          // subtitle: question.selectedAnswer == question.correctAnswer
                                          //     ? const Text('Correct')
                                          //     : const Text('Incorrect'),
                                          secondary: option ==
                                                      question.selectedAnswer ||
                                                  option ==
                                                          question
                                                              .correctAnswer &&
                                                      option ==
                                                          question
                                                              .selectedAnswer
                                              ? question.correctAnswer ==
                                                      question.selectedAnswer
                                                  ? const Icon(Icons.check,
                                                      color: Colors.green)
                                                  : const Icon(Icons.close,
                                                      color: Colors.red)
                                              : null,
                                          value: option,
                                          groupValue: question.selectedAnswer,
                                          onChanged: (value) {
                                            setState(() {
                                              question.selectedAnswer = value!;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
