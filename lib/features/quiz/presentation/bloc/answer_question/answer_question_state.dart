part of 'answer_question_bloc.dart';

sealed class AnswerQuestionState extends Equatable {
  const AnswerQuestionState();
}

final class AnswerQuestionInitial extends AnswerQuestionState {
  final List<QuestionEntity> questions;

  const AnswerQuestionInitial({
    required this.questions,
  });

  @override
  List<Object> get props => [];
}

final class AnswerQuestionLoading extends AnswerQuestionState {
  @override
  List<Object> get props => [];
}

class AnswerQuestionSuccess extends AnswerQuestionState {
  final int score;
  final List<QuestionEntity> questions;
  final String selectedAnswer;

  AnswerQuestionSuccess({
    required this.score,
    required this.questions,
    required this.selectedAnswer,
  });

  @override
  List<Object> get props => [score, questions, selectedAnswer];
}

final class AnswerQuestionError extends AnswerQuestionState {
  final String message;

  AnswerQuestionError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}


final class AnswerQuestionComplete extends AnswerQuestionState {
  final int score;
  final List<QuestionEntity> questions;

  AnswerQuestionComplete({
    required this.score,
    required this.questions,
  });

  @override
  List<Object> get props => [score, questions];
}
