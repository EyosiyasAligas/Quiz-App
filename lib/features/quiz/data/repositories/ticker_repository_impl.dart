import 'package:quiz_app/features/quiz/domain/repositories/abstract_ticker_repository.dart';

class TickerRepositoryImplementation implements AbstractTickerRepository {
  @override
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
