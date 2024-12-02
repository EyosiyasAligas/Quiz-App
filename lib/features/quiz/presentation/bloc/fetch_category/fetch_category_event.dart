part of 'fetch_category_bloc.dart';

sealed class FetchCategoryEvent extends Equatable {
  const FetchCategoryEvent();
}

class FetchCategory extends FetchCategoryEvent {
  const FetchCategory();

  @override
  List<Object> get props => [];
}
