import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  String id;
  String questionText;
  List<String> options;
  String correctAnswer;
  String? selectedAnswer = '';

  QuestionEntity({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.selectedAnswer,
  });

  @override
  List<Object?> get props => [id, questionText, options, correctAnswer, selectedAnswer];
}
