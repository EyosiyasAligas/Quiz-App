import '../../domain/entities/filter_params_entity.dart';

class FilterParamsModel extends FilterParamsEntity {
  const FilterParamsModel({
    required super.completedAt,
    required super.difficulty,
    required super.type,
    required super.category,
    required super.minScore,
    required super.maxScore,
  });

  @override
  copyWith(
      {String? completedAt,
      String? difficulty,
      String? type,
      String? category,
      int? minScore,
      int? maxScore}) {
    // TODO: implement copyWith
    return super.copyWith(
        completedAt: completedAt,
        difficulty: difficulty,
        type: type,
        category: category,
        minScore: minScore,
        maxScore: maxScore);
  }

  factory FilterParamsModel.fromEntity(FilterParamsEntity entity) {
    return FilterParamsModel(
      completedAt: entity.completedAt,
      difficulty: entity.difficulty,
      type: entity.type,
      category: entity.category,
      minScore: entity.minScore,
      maxScore: entity.maxScore,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> queryParams = {};

    if (completedAt != null) queryParams['completed_at'] = completedAt;
    if (difficulty != null) queryParams['difficulty'] = difficulty;
    if (type != null) queryParams['type'] = type;
    if (category != null) queryParams['category'] = category;
    if (minScore != null) queryParams['min_score'] = minScore;
    if (maxScore != null) queryParams['max_score'] = maxScore;

    return queryParams;
  }
}
