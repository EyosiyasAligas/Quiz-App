import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/quiz/domain/entities/question_entity.dart';

class QuizEntity extends Equatable {
  String id;
  String title;
  List<QuestionEntity> questions;

  QuizEntity({
    required this.id,
    required this.title,
    required this.questions,
  });

  @override
  List<Object?> get props => [id, title, questions];
}
