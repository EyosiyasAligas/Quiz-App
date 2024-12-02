import '../../domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.type,
    required super.difficulty,
    required super.category,
    required super.question,
    required super.correctAnswer,
    required super.incorrectAnswers,
    required super.options,
    super.selectedAnswer = '',
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      type: json['type'],
      difficulty: json['difficulty'],
      category: json['category'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
      options: List<String>.from(json['incorrect_answers'])..add(json['correct_answer'])..shuffle(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': super.type,
      'difficulty': super.difficulty,
      'category': super.category,
      'question': super.question,
      'correct_answer': super.correctAnswer,
      'incorrect_answers': super.incorrectAnswers,
    };
  }
}