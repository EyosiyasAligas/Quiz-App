import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../core/utils/theme_mode_cubit.dart';
import '../features/quiz/data/data_sources/remote/quiz_impl_api.dart';
import '../features/quiz/data/repositories/quiz_repository_impl.dart';
import '../features/quiz/domain/repositories/abstract_quiz_repository.dart';
import '../features/quiz/domain/usecases/fetch_category_usecase.dart';
import '../features/quiz/domain/usecases/fetch_quiz_usecase.dart';
import '../features/quiz/presentation/bloc/choose_preference/choose_preference_cubit.dart';
import '../features/quiz/presentation/bloc/fetch_category/fetch_category_bloc.dart';
import '../features/quiz/presentation/bloc/fetch_question/fetch_question_bloc.dart';

final sl = GetIt.I;

Future<void> initAppInjections() async {
  // External
  sl.registerSingleton<Dio>(Dio());

  // Data Sources
  sl.registerSingleton<QuizImplApi>(QuizImplApi(sl<Dio>()));

  // Repository
  sl.registerSingleton<QuizRepositoryImplementation>(QuizRepositoryImplementation(sl<QuizImplApi>()));
  sl.registerSingleton<AbstractQuizRepository>(sl<QuizRepositoryImplementation>());

  // UseCase
  sl.registerSingleton<FetchCategoryUseCase>(FetchCategoryUseCase(sl<AbstractQuizRepository>()));
  sl.registerSingleton<FetchQuizUseCase>(FetchQuizUseCase(sl<AbstractQuizRepository>()));

  // Bloc
  sl.registerFactory<ThemeModeCubit>(() => ThemeModeCubit(ThemeMode.system));
  sl.registerFactory<ChoosePreferenceCubit>(() => ChoosePreferenceCubit());
  sl.registerFactory<FetchQuestionBloc>(() => FetchQuestionBloc(sl<FetchQuizUseCase>()));
  sl.registerFactory<FetchCategoryBloc>(() => FetchCategoryBloc(sl<FetchCategoryUseCase>()));
}