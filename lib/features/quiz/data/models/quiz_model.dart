import 'package:quiz_app/features/quiz/data/models/question_model.dart';

import '../../domain/entities/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required super.id,
    required super.title,
    required super.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['title'],
      questions: List<QuestionModel>.from(
          json['questions'].map((x) => QuestionModel.fromJson(x))),
    );
  }

  // covert QuestionModel to json

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questions': questions
          .map((question) => (question as QuestionModel).toJson())
          .toList(),
    };
  }
}
