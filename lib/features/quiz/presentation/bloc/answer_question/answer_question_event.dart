part of 'answer_question_bloc.dart';

sealed class AnswerQuestionEvent extends Equatable {
  const AnswerQuestionEvent();
}

class AnswerQuestion extends AnswerQuestionEvent {
  final int questionIndex;
  final String selectedAnswer;
  final List<QuestionEntity> questions;

  const AnswerQuestion({
    required this.questionIndex,
    required this.selectedAnswer,
    required this.questions,
  });

  @override
  List<Object?> get props => [questionIndex, selectedAnswer, questions];
}

class CompleteQuiz extends AnswerQuestionEvent {
  final List<QuestionEntity> questions;
  final int score;

  const CompleteQuiz({
    required this.questions,
    required this.score,
  });

  @override
  List<Object?> get props => [questions, score];
}






