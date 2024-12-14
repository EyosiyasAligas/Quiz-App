part of 'filter_cubit.dart';

sealed class FilterState extends Equatable {
  final FilterParamsEntity filterParams;

  const FilterState(this.filterParams);


  @override
  List<Object> get props => [filterParams];
}

final class FilterInitial extends FilterState {
  const FilterInitial(super.filterParams);

  copyWith({
    String? completedAt,
    String? difficulty,
    String? type,
    String? category,
    int? minScore,
    int? maxScore,
  }) {
    return FilterInitial(
      FilterParamsEntity(
        completedAt: completedAt ?? super.filterParams.completedAt,
        difficulty: difficulty ?? super.filterParams.difficulty,
        type: type ?? super.filterParams.type,
        category: category ?? super.filterParams.category,
        minScore: minScore ?? super.filterParams.minScore,
        maxScore: maxScore ?? super.filterParams.maxScore,
      ),
    );
  }

  @override
  List<Object> get props => [];
}

final class FilterUpdated extends FilterState {
  const FilterUpdated(super.filterParams);

  copyWith({
    String? completedAt,
    String? difficulty,
    String? type,
    String? category,
    int? minScore,
    int? maxScore,
  }) {
    return FilterUpdated(
      FilterParamsEntity(
        completedAt: completedAt ?? super.filterParams.completedAt,
        difficulty: difficulty ?? super.filterParams.difficulty,
        type: type ?? super.filterParams.type,
        category: category ?? super.filterParams.category,
        minScore: minScore ?? super.filterParams.minScore,
        maxScore: maxScore ?? super.filterParams.maxScore,
      ),
    );
  }

  @override
  List<Object> get props => [filterParams];
}

// FilterCleared

final class FilterCleared extends FilterState {
  const FilterCleared(super.filterParams);

  copyWith({
    String? completedAt,
    String? difficulty,
    String? type,
    String? category,
    int? minScore,
    int? maxScore,
  }) {
    return FilterCleared(
      FilterParamsEntity(
        completedAt: completedAt ?? super.filterParams.completedAt,
        difficulty: difficulty ?? super.filterParams.difficulty,
        type: type ?? super.filterParams.type,
        category: category ?? super.filterParams.category,
        minScore: minScore ?? super.filterParams.minScore,
        maxScore: maxScore ?? super.filterParams.maxScore,
      ),
    );
  }

  @override
  List<Object> get props => [];
}