import 'dart:convert';

import '../../../quiz/data/models/question_model.dart';
import '../../../quiz/domain/entities/question_entity.dart';
import '../../../quiz/domain/entities/quiz_enums.dart';
import '../../domain/entities/history_entity.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    super.id,
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
      id: entity.id,
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
      id: json['id'],
      quizTitle: json['quiz_title'],
      score: json['score'],
      type: QuizType.fromString(json['type']),
      difficulty: QuizDifficulty.fromString(json['difficulty']),
      totalQuestions: json['total_questions'],
      questions: (jsonDecode(json['questions']) as List)
          .map((question) => QuestionModel.fromJson(question))
          .toList(),
      completedAt: DateTime.parse(json['completed_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'quiz_title': super.quizTitle,
      'score': super.score,
      'type': super.type.value,
      'difficulty': super.difficulty.value,
      'total_questions': super.totalQuestions,
      // jsonEncode the list of questions
      'questions': jsonEncode(super
          .questions
          .map((question) => (question as QuestionModel).toJson())
          .toList()),
      'completed_at': super.completedAt.toIso8601String(),
    };
  }
}
