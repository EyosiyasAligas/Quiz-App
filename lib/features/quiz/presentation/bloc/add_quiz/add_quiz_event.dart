part of 'add_quiz_bloc.dart';

sealed class AddQuizEvent extends Equatable {
  const AddQuizEvent();
}

class AddQuiz extends AddQuizEvent {
  final QuizEntity quiz;

  const AddQuiz(this.quiz);

  @override
  List<Object?> get props => [quiz];
}
