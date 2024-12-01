part of 'fetch_quiz_bloc.dart';

sealed class FetchQuizState extends Equatable {
  const FetchQuizState();

  @override
  List<Object> get props => [];
}

final class FetchQuizInitial extends FetchQuizState {
  @override
  List<Object> get props => [];
}
final class FetchQuizLoadInProgress extends FetchQuizState {
  @override
  List<Object> get props => [];

}
final class FetchQuizLoadSuccess extends FetchQuizState {
  final List<QuizEntity> quiz;

  const FetchQuizLoadSuccess(this.quiz);

  @override
  List<Object> get props => [quiz];
}

final class FetchQuizLoadFailure extends FetchQuizState {
  final String errorMessage;

  const FetchQuizLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}


