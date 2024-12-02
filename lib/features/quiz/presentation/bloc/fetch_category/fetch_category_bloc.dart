import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/quiz/domain/entities/category_entity.dart';

import '../../../domain/usecases/fetch_category_usecase.dart';

part 'fetch_category_event.dart';
part 'fetch_category_state.dart';

class FetchCategoryBloc extends Bloc<FetchCategoryEvent, FetchCategoryState> {
  final FetchCategoryUseCase fetchCategoryUseCase;

  FetchCategoryBloc(this.fetchCategoryUseCase) : super(FetchCategoryInitial()) {

    on<FetchCategory>(fetchCategory);
  }

  void fetchCategory(FetchCategory event, Emitter<FetchCategoryState> emit) async {
    emit(FetchCategoryLoadInProgress());
    final result = await fetchCategoryUseCase();
    result.fold(
      (failure) => emit(FetchCategoryLoadFailure(failure.errorMessage)),
      (category) => emit(FetchCategoryLoadSuccess(category)),
    );
  }
}
