import 'package:equatable/equatable.dart';

class FilterParamsEntity extends Equatable {
  final String? completedAt;
  final String? difficulty;
  final String? type;
  final String? category;
  final int? minScore;
  final int? maxScore;

  const FilterParamsEntity({
    this.completedAt,
    this.difficulty,
    this.type,
    this.category,
    this.minScore,
    this.maxScore,
  });

  copyWith({
    String? completedAt,
    String? difficulty,
    String? type,
    String? category,
    int? minScore,
    int? maxScore,
  }) {
    return FilterParamsEntity(
      completedAt: completedAt ?? this.completedAt,
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
      category: category ?? this.category,
      minScore: minScore ?? this.minScore,
      maxScore: maxScore ?? this.maxScore,
    );
  }

  @override
  List<Object?> get props => [
    completedAt,
        difficulty,
        type,
        category,
        minScore,
        maxScore,
      ];
}
