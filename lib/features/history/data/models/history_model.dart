import '../../../quiz/data/models/question_model.dart';
import '../../../quiz/domain/entities/question_entity.dart';
import '../../../quiz/domain/entities/quiz_enums.dart';
import '../../domain/entities/history_entity.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required super.quizTitle,
    required super.score,
    required super.type,
    required super.difficulty,
    required super.totalQuestions,
    required super.questions,
    required super.completedAt,
  });

  factory HistoryModel.fromEntity(HistoryEntity entity) {
    return HistoryModel(
      quizTitle: entity.quizTitle,
      score: entity.score,
      type: entity.type,
      difficulty: entity.difficulty,
      totalQuestions: entity.totalQuestions,
      questions: entity.questions,
      completedAt: entity.completedAt,
    );
  }

  // fromJson
  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      quizTitle: json['quiz_title'],
      score: json['score'],
      type: QuizType.fromString(json['type']),
      difficulty: QuizDifficulty.fromString(json['difficulty']),
      totalQuestions: json['total_questions'],
      questions: (json['questions'] as List<dynamic>)
          .map((question) =>
              QuestionModel.fromJson(Map<String, dynamic>.from(question)))
          .toList(),
      completedAt: DateTime.parse(json['completed_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quiz_title': super.quizTitle,
      'score': super.score,
      'type': super.type.value,
      'difficulty': super.difficulty.value,
      'total_questions': super.totalQuestions,
      'questions': super
          .questions
          .map((question) => (question as QuestionModel).toJson())
          .toList(),
      'completed_at': super.completedAt.toIso8601String(),
    };
  }
}
