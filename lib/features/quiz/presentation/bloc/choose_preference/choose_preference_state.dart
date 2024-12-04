part of 'choose_preference_cubit.dart';

sealed class ChoosePreferenceState extends Equatable {
  const ChoosePreferenceState();
}

final class ChoosePreferenceInitial extends ChoosePreferenceState {
  // provide initial values of QuizParams
  final QuizParams? params;

  const ChoosePreferenceInitial({
  required this.params,
  });

  @override
  List<Object> get props => [];
}

// create a state class for finishing updating preferences

final class ChoosePreferenceUpdated extends ChoosePreferenceState {
  final QuizParams? params;

  const ChoosePreferenceUpdated({
  required this.params,
  });

  @override
  List<Object> get props => [];
}
