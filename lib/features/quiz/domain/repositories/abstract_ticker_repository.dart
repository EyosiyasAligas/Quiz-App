abstract class AbstractTickerRepository {
  const AbstractTickerRepository();
  Stream<int> tick({required int ticks});
}