import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quiz/domain/repositories/abstract_quiz_repository.dart';
import 'package:quiz_app/features/quiz/domain/usecases/add_quiz_usecase.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/add_quiz/add_quiz_bloc.dart';
import 'package:quiz_app/shared/service_locator.dart';

import 'features/quiz/data/data_sources/remote/quiz_impl_api.dart';
import 'features/quiz/data/repositories/quiz_repository_impl.dart';
import 'features/quiz/domain/usecases/fetch_quiz_usecase.dart';
import 'features/quiz/presentation/bloc/fetch_quiz/fetch_quiz_bloc.dart';
import 'features/quiz/presentation/screens/quiz_screen.dart';

Future<void> main() async {

  // await initAppInjections();

  runApp(
    const MyApp(/*quizRepositoryImplementation: quizRepositoryImplementation*/),
  );
}

class MyApp extends StatelessWidget {
  // final QuizRepositoryImplementation quizRepositoryImplementation;

  const MyApp({super.key, required
/*this.quizRepositoryImplementation*/
      });

  @override
  Widget build(BuildContext context) {
    // var quizRepositoryImplementation = sl<AbstractQuizRepository>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<FetchQuizBloc>(
            create: (context) => sl<FetchQuizBloc>()..add(FetchQuiz()),
          ),
          // add quiz bloc
          BlocProvider<AddQuizBloc>(
            create: (context) => sl<AddQuizBloc>(),
          ),
        ],
        child: const QuizScreen(),
      ),
    );
  }
}
