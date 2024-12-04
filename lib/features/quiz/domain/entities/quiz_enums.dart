enum QuizType {
  any('Any'),
  multipleChoice('Multiple Choice'),
  trueFalse('True/False');

  final String? value;
  const QuizType(this.value);

  @override
  String toString() => value!;
}

enum QuizDifficulty {
  any('Any'),
  easy('Easy'),
  medium('Medium'),
  hard('Hard');

  final String? value;
  const QuizDifficulty(this.value);

  @override
  String toString() => value!;
}