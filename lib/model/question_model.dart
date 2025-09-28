class QuestionModel {
  final String questionText;
  final int correctAnswer;
  final List<int> options;

  QuestionModel({
    required this.questionText,
    required this.correctAnswer,
    required this.options,
  });
}
