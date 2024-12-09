import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/quiz/domain/entities/question_entity.dart';

part 'answer_question_event.dart';

part 'answer_question_state.dart';

class AnswerQuestionBloc
    extends Bloc<AnswerQuestionEvent, AnswerQuestionState> {
  AnswerQuestionBloc() : super(AnswerQuestionInitial(questions: questions)) {
    on<AnswerQuestion>(answerQuestion);
    on<CompleteQuiz>(completeQuiz);
  }

  static List<QuestionEntity> questions = [];
  int score = 0;

  void answerQuestion(AnswerQuestion event, Emitter<AnswerQuestionState> emit) {
    final questionIndex = event.questionIndex;
    final selectedAnswer = event.selectedAnswer;
    List<QuestionEntity> questions = event.questions;
    final question = questions[questionIndex];
    final previousAnswer = question.selectedAnswer;

    // Update the selected answer
    question.selectedAnswer = selectedAnswer;

    // Adjust the score based on the previous and current answers
    if (previousAnswer != null) {
      if (previousAnswer == question.correctAnswer && selectedAnswer != question.correctAnswer) {
        score--;
      } else if (previousAnswer != question.correctAnswer && selectedAnswer == question.correctAnswer) {
        score++;
      }
    } else if (selectedAnswer == question.correctAnswer) {
      score++;
    }

    emit(
      AnswerQuestionSuccess(
        score: score,
        questions: questions,
        selectedAnswer: selectedAnswer,
      ),
    );
  }

  void completeQuiz(CompleteQuiz event, Emitter<AnswerQuestionState> emit) {
    emit(
      AnswerQuestionComplete(
        score: score,
        questions: event.questions,
      ),
    );
  }
}
