part of 'cache_history_bloc.dart';

sealed class CacheHistoryState extends Equatable {
  const CacheHistoryState();
}

final class CacheHistoryInitial extends CacheHistoryState {
  @override
  List<Object> get props => [];
}

final class CacheHistoryLoading extends CacheHistoryState {
  @override
  List<Object> get props => [];
}

final class CacheHistorySuccess extends CacheHistoryState {
  final String message;

  const CacheHistorySuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class CacheHistoryFailure extends CacheHistoryState {
  final String errorMessage;

  const CacheHistoryFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
