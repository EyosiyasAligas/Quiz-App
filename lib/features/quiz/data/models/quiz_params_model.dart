import '../../domain/entities/quiz_params.dart';

class QuizParamsModel extends QuizParams {
  const QuizParamsModel({
    required super.amount,
    required super.categoryId,
    required super.difficulty,
    required super.type,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> queryParams = {};

    if (amount != null) queryParams['amount'] = amount;
    if (categoryId != null) queryParams['category'] = categoryId;
    if (difficulty != null) queryParams['difficulty'] = difficulty;
    if (type != null) queryParams['type'] = type;

    return queryParams;
  }
}