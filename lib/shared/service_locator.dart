import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../features/history/data/data_sources/local/history_local_datasource_impl.dart';
import '../features/history/data/repositories/history_repository_impl.dart';
import '../features/history/domain/repositories/abstract_history_repository.dart';
import '../features/history/domain/usecases/cache_history_usecase.dart';
import '../features/history/domain/usecases/fetch_history_usecase.dart';
import '../features/history/presentation/bloc/cache_history/cache_history_bloc.dart';
import '../features/history/presentation/bloc/fetch_history/fetch_history_bloc.dart';
import '../features/home/presentation/bloc/navigation/navigation_cubit.dart';
import '../features/quiz/data/data_sources/local/quiz_local_impl.dart';
import '../features/quiz/data/repositories/ticker_repository_impl.dart';
import '../features/quiz/domain/repositories/abstract_ticker_repository.dart';
import '../features/quiz/domain/usecases/ticker_usecase.dart';
import '../features/quiz/presentation/bloc/answer_question/answer_question_bloc.dart';
import '../features/quiz/presentation/bloc/submit_quiz/submit_quiz_bloc.dart';
import '../features/quiz/presentation/bloc/timer/timer_bloc.dart';
import 'presentation/bloc/theme_mode/theme_mode_cubit.dart';
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
  sl.registerSingleton<QuizLocalImplementation>(QuizLocalImplementation());
  sl.registerSingleton<HistoryLocalDatasourceImpl>(HistoryLocalDatasourceImpl());

  // Repository
  sl.registerSingleton<QuizRepositoryImplementation>(QuizRepositoryImplementation(sl<QuizImplApi>(), sl<QuizLocalImplementation>()));
  sl.registerSingleton<AbstractQuizRepository>(sl<QuizRepositoryImplementation>());
  sl.registerSingleton<TickerRepositoryImplementation>(TickerRepositoryImplementation());
  sl.registerSingleton<AbstractTickerRepository>(sl<TickerRepositoryImplementation>());
  sl.registerSingleton<HistoryRepositoryImplementation>(HistoryRepositoryImplementation(sl<HistoryLocalDatasourceImpl>()));
  sl.registerSingleton<AbstractHistoryRepository>(sl<HistoryRepositoryImplementation>());

  // UseCase
  sl.registerSingleton<FetchCategoryUseCase>(FetchCategoryUseCase(sl<AbstractQuizRepository>()));
  sl.registerSingleton<FetchQuizUseCase>(FetchQuizUseCase(sl<AbstractQuizRepository>()));
  sl.registerSingleton<TickerUseCase>(TickerUseCase(sl<AbstractTickerRepository>()));
  sl.registerSingleton<FetchHistoryUseCase>(FetchHistoryUseCase(sl<AbstractHistoryRepository>()));
  sl.registerSingleton<CacheHistoryUseCase>(CacheHistoryUseCase(sl<AbstractHistoryRepository>()));

  // Bloc
  sl.registerFactory<ThemeModeCubit>(() => ThemeModeCubit(ThemeMode.system));
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());
  sl.registerFactory<ChoosePreferenceCubit>(() => ChoosePreferenceCubit());
  sl.registerFactory<FetchQuestionBloc>(() => FetchQuestionBloc(sl<FetchQuizUseCase>()));
  sl.registerFactory<FetchCategoryBloc>(() => FetchCategoryBloc(sl<FetchCategoryUseCase>()));
  sl.registerFactory<SubmitQuizBloc>(() => SubmitQuizBloc());
  sl.registerFactory<TimerBloc>(() => TimerBloc(sl<TickerUseCase>()));
  sl.registerFactory<AnswerQuestionBloc>(() => AnswerQuestionBloc());
  sl.registerFactory<FetchHistoryBloc>(() => FetchHistoryBloc(sl<FetchHistoryUseCase>()));
  sl.registerFactory<CacheHistoryBloc>(() => CacheHistoryBloc(sl<CacheHistoryUseCase>()));
}