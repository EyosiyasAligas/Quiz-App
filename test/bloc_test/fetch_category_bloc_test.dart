import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/network/errors/exceptions.dart';
import 'package:quiz_app/core/network/errors/failures.dart';
import 'package:quiz_app/core/utils/usecase.dart';
import 'package:quiz_app/features/quiz/domain/entities/category_entity.dart';
import 'package:quiz_app/features/quiz/domain/usecases/fetch_category_usecase.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/fetch_category/fetch_category_bloc.dart';

import 'fetch_category_bloc_test.mocks.dart';

@GenerateMocks([FetchCategoryUseCase])
void main() {
  MockFetchCategoryUseCase mockFetchCategoryUseCase;
  CategoryEntity category = CategoryEntity(
    id: 1,
    name: 'General Knowledge',
  );
  Failure failure = ServerFailure('Server Failure', 500);

  group('Fetch Category Bloc Test', () {
    mockFetchCategoryUseCase = MockFetchCategoryUseCase();

    setUpAll(() {
      when(mockFetchCategoryUseCase.call(NoParams()))
          .thenAnswer((_) async => Right([category]));
    });

    tearDown(() {
      when(mockFetchCategoryUseCase.call(NoParams()))
          .thenAnswer((_) async => Left(failure));
    });
    blocTest(
      'Fetch Category Successful',
      build: () => FetchCategoryBloc(mockFetchCategoryUseCase),
      act: (bloc) => bloc.add(FetchCategory()),
      expect: () => <FetchCategoryState>[
        FetchCategoryLoadSuccess([category])
      ],
      skip: 1,
    );

    blocTest(
      'Fetch Category Failure',
      build: () => FetchCategoryBloc(mockFetchCategoryUseCase),
      act: (bloc) => bloc.add(FetchCategory()),
      expect: () => <FetchCategoryState>[FetchCategoryLoadFailure('Server Failure')],
      skip: 1,
    );
  });
}
