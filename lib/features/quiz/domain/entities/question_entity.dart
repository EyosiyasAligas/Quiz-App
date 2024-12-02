import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String type;
  final String difficulty;
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final List<String> options;
  final String? selectedAnswer;

  const QuestionEntity({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.options,
    this.selectedAnswer,
  });

  @override
  List<Object?> get props => [
        type,
        difficulty,
        category,
        question,
        correctAnswer,
        incorrectAnswers,
        options,
        selectedAnswer,
      ];
}
