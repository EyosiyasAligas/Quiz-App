import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_enums.dart';

class QuizParams extends Equatable {
  int? amount;
  int? categoryId;
  QuizDifficulty? difficulty;
  QuizType? type;

  QuizParams({
    this.amount,
    this.categoryId,
    this.difficulty,
    this.type,
  });

  @override
  List<Object?> get props => [amount, categoryId, difficulty, type];

  QuizParams copyWith({
    int? amount,
    int? categoryId,
    QuizDifficulty? difficulty,
    QuizType? type,
  }) {
    return QuizParams(
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
    );
  }
}
