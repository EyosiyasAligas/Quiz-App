import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/usecase.dart';
import '../../../domain/entities/filter_params_entity.dart';
import '../../../domain/entities/history_entity.dart';
import '../../../domain/usecases/fetch_history_by_filter_usecase.dart';
import '../../../domain/usecases/fetch_history_usecase.dart';

part 'fetch_history_event.dart';
part 'fetch_history_state.dart';

class FetchHistoryBloc extends Bloc<FetchHistoryEvent, FetchHistoryState> {
  final FetchHistoryUseCase fetchHistoryUseCase;
  final FetchHistoryByFilterUseCase fetchHistoryByFilterUseCase;

  FetchHistoryBloc(this.fetchHistoryUseCase, this.fetchHistoryByFilterUseCase) : super(FetchHistoryInitial()) {
    on<FetchHistory>(fetchHistory);
    on<FetchHistoryByFilter>(fetchHistoryByFilter);
  }

  void fetchHistory(FetchHistory event, Emitter<FetchHistoryState> emit) async {
    emit(FetchHistoryLoading());
    final result = await fetchHistoryUseCase.call(NoParams());
    result.fold(
      (failure) => emit(FetchHistoryFailure(failure.errorMessage)),
      (historyList) => emit(FetchHistorySuccess(historyList)),
    );
  }

  void fetchHistoryByFilter(FetchHistoryByFilter event, Emitter<FetchHistoryState> emit) async {
    emit(FetchHistoryLoading());
    final result = await fetchHistoryByFilterUseCase.call(event.filterParams);
    print('fetch by filter: $result');
    result.fold(
      (failure) => emit(FetchHistoryFailure(failure.errorMessage)),
      (historyList) => emit(FetchHistorySuccess(historyList)),
    );
  }
}
