part of 'fetch_question_bloc.dart';

sealed class FetchQuestionState extends Equatable {
  const FetchQuestionState();

  @override
  List<Object> get props => [];
}

final class FetchQuestionInitial extends FetchQuestionState {
  @override
  List<Object> get props => [];
}
final class FetchQuestionLoadInProgress extends FetchQuestionState {
  @override
  List<Object> get props => [];

}
final class FetchQuestionLoadSuccess extends FetchQuestionState {
  final List<QuestionEntity> questions;

  const FetchQuestionLoadSuccess(this.questions);

  @override
  List<Object> get props => [questions];
}

final class FetchQuestionLoadFailure extends FetchQuestionState {
  final String errorMessage;

  const FetchQuestionLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}


