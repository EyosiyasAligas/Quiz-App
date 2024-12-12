enum QuizType {
  any('Any'),
  multipleChoice('Multiple Choice'),
  trueFalse('True/False');

  final String? value;
  const QuizType(this.value);

  @override
  String toString() => value!;

  static QuizType fromString(String? value) {
    switch (value) {
      case 'Multiple Choice':
        return multipleChoice;
      case 'True/False':
        return trueFalse;
      default:
        return any;
    }
  }
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

  static QuizDifficulty fromString(String? value) {
    switch (value) {
      case 'Easy':
        return easy;
      case 'Medium':
        return medium;
      case 'Hard':
        return hard;
      default:
        return any;
    }
  }
}