import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/add_quiz/add_quiz_bloc.dart';

import '../features/quiz/data/data_sources/remote/quiz_impl_api.dart';
import '../features/quiz/data/repositories/quiz_repository_impl.dart';
import '../features/quiz/domain/repositories/abstract_quiz_repository.dart';
import '../features/quiz/domain/usecases/add_quiz_usecase.dart';
import '../features/quiz/domain/usecases/fetch_quiz_usecase.dart';
import '../features/quiz/presentation/bloc/fetch_quiz/fetch_quiz_bloc.dart';

final sl = GetIt.I;

Future<void> initAppInjections() async {
  // sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<QuizImplApi>(QuizImplApi(sl<Dio>()));
  sl.registerSingleton<QuizRepositoryImplementation>(QuizRepositoryImplementation(sl<QuizImplApi>()));
  sl.registerSingleton<AbstractQuizRepository>(sl<QuizRepositoryImplementation>());
  sl.registerSingleton<FetchQuizUseCase>(FetchQuizUseCase(sl<AbstractQuizRepository>()));
  sl.registerSingleton<AddQuizUseCase>(AddQuizUseCase(sl<AbstractQuizRepository>()));
  sl.registerFactory<FetchQuizBloc>(() => FetchQuizBloc(sl<FetchQuizUseCase>()));
  sl.registerFactory<AddQuizBloc>(() => AddQuizBloc(sl<AddQuizUseCase>()));

}