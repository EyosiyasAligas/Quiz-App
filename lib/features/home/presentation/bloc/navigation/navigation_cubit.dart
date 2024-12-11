import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());


  void changeIndex(int index) {
    emit(NavigationChanged(index));
  }

  void resetIndex() {
    emit(NavigationInitial());
  }
}
