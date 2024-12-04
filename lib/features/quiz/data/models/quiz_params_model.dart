import '../../domain/entities/quiz_enums.dart';
import '../../domain/entities/quiz_params.dart';

class QuizParamsModel extends QuizParams {
  QuizParamsModel({
    required super.amount,
    required super.categoryId,
    required super.difficulty,
    required super.type,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> queryParams = {};



    if (amount != null) queryParams['amount'] = amount;
    if (categoryId != null) queryParams['category'] = categoryId;
    if (difficulty != null && difficulty?.value != 'Any') queryParams['difficulty'] = difficulty?.value!.toLowerCase();
    if (type != null && type?.value != 'Any') queryParams['type'] = type == QuizType.trueFalse ? 'boolean' : 'multiple';

    return queryParams;
  }
}