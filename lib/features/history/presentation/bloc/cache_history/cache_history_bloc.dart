import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/entities/history_entity.dart';
import '../../../domain/usecases/cache_history_usecase.dart';

part 'cache_history_event.dart';
part 'cache_history_state.dart';

class CacheHistoryBloc extends Bloc<CacheHistoryEvent, CacheHistoryState> {
  final CacheHistoryUseCase cacheHistoryUseCase;

  CacheHistoryBloc(this.cacheHistoryUseCase) : super(CacheHistoryInitial()) {
    on<CacheHistory>(cacheHistory);
  }

  Future<void> cacheHistory(CacheHistory event, Emitter<CacheHistoryState> emit) async {
    emit(CacheHistoryLoading());
    final result = await cacheHistoryUseCase.call(event.history);

    result.fold(
      (failure) => emit(CacheHistoryFailure(failure.errorMessage)),
      (_) => emit(const CacheHistorySuccess('History cached successfully')),
    );
  }
}
