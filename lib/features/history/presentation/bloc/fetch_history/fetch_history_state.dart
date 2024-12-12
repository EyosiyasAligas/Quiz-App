part of 'fetch_history_bloc.dart';

sealed class FetchHistoryState extends Equatable {
  const FetchHistoryState();
}

final class FetchHistoryInitial extends FetchHistoryState {
  @override
  List<Object> get props => [];
}

final class FetchHistoryLoading extends FetchHistoryState {
  @override
  List<Object> get props => [];
}

final class FetchHistorySuccess extends FetchHistoryState {
  final List<HistoryEntity> history;

  const FetchHistorySuccess(this.history);

  @override
  List<Object> get props => [history];
}

final class FetchHistoryFailure extends FetchHistoryState {
  final String errorMessage;

  const FetchHistoryFailure(this.errorMessage);


  @override
  List<Object> get props => [errorMessage];
}
