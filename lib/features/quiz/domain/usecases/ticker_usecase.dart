import '../repositories/abstract_ticker_repository.dart';

class TickerUseCase {
  final AbstractTickerRepository _tickerRepository;

  TickerUseCase(this._tickerRepository);

  //use call
  Stream<int> call({required int ticks}) {
    return _tickerRepository.tick(ticks: ticks);
  }
}