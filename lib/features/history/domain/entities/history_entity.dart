import 'package:equatable/equatable.dart';

import '../../../quiz/domain/entities/question_entity.dart';
import '../../../quiz/domain/entities/quiz_enums.dart';

class HistoryEntity extends Equatable {
  final String quizTitle;
  final int score;
  final QuizType type;
  final QuizDifficulty difficulty;
  final int totalQuestions;
  final List<QuestionEntity> questions;
  final DateTime completedAt;

  const HistoryEntity({
    required this.quizTitle,
    required this.score,
    required this.type,
    required this.difficulty,
    required this.totalQuestions,
    required this.questions,
    required this.completedAt,
  });

  @override
  List<Object?> get props => [
        quizTitle,
        score,
        type,
        difficulty,
        totalQuestions,
        questions,
        completedAt,
      ];
}
