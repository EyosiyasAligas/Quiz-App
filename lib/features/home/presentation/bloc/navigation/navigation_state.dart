part of 'navigation_cubit.dart';

sealed class NavigationState extends Equatable {
  final int index;

  NavigationState({this.index = 0});

  @override
  List<Object> get props => [index];
}

final class NavigationInitial extends NavigationState {
  @override
  List<Object> get props => [];
}

final class NavigationChanged extends NavigationState {
  final int index;
  NavigationChanged(this.index);
  @override
  List<Object> get props => [index];
}
