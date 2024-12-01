part of 'add_quiz_bloc.dart';

sealed class AddQuizState extends Equatable {
  const AddQuizState();

  @override
  List<Object> get props => [];
}

final class AddQuizInitial extends AddQuizState {
  @override
  List<Object> get props => [];
}

final class AddQuizLoading extends AddQuizState {
  @override
  List<Object> get props => [];
}

final class AddQuizSuccess extends AddQuizState {
  final String message;
  final QuizEntity quiz;

  const AddQuizSuccess(this.message, this.quiz);

  @override
  List<Object> get props => [message, quiz];
}

final class AddQuizFailure extends AddQuizState {
  final String message;

  const AddQuizFailure(this.message);

  @override
  List<Object> get props => [message];
}
