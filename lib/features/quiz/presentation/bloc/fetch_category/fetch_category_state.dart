part of 'fetch_category_bloc.dart';

sealed class FetchCategoryState extends Equatable {
  const FetchCategoryState();
}

final class FetchCategoryInitial extends FetchCategoryState {
  @override
  List<Object> get props => [];
}

final class FetchCategoryLoadInProgress extends FetchCategoryState {
  @override
  List<Object> get props => [];
}

final class FetchCategoryLoadSuccess extends FetchCategoryState {
  final List<CategoryEntity> categories;

  const FetchCategoryLoadSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

final class FetchCategoryLoadFailure extends FetchCategoryState {
  final String message;

  const FetchCategoryLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
