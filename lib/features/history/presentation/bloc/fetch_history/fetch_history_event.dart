part of 'fetch_history_bloc.dart';

sealed class FetchHistoryEvent extends Equatable {
  const FetchHistoryEvent();
}

class FetchHistory extends FetchHistoryEvent {
  const FetchHistory();

  @override
  List<Object> get props => [];
}


