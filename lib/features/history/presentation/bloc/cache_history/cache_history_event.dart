part of 'cache_history_bloc.dart';

sealed class CacheHistoryEvent extends Equatable {
  const CacheHistoryEvent();
}

class CacheHistory extends CacheHistoryEvent {
  final HistoryEntity history;

  const CacheHistory(this.history);

  @override
  List<Object> get props => [history];
}
