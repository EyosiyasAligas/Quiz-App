import 'package:equatable/equatable.dart';

class QuizParams extends Equatable {
  final int? amount;
  final int? categoryId;
  final String? difficulty;
  final String? type;

  const QuizParams({
    this.amount,
    this.categoryId,
    this.difficulty,
    this.type,
  });

  @override
  List<Object?> get props => [amount, categoryId, difficulty, type];
}
