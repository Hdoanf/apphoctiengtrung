class QuizQuestion {
  final String text;
  final List<Map<String, String>> options;
  final int correctIndex;

  QuizQuestion({
    required this.text,
    required this.options,
    required this.correctIndex,
  });
}

class Lesson {
  final String id;
  final String title;
  String statusText;
  bool isCompleted;
  bool isLocked;
  double? progress;
  final List<QuizQuestion> questions;

  Lesson({
    required this.id,
    required this.title,
    required this.statusText,
    this.isCompleted = false,
    this.isLocked = false,
    this.progress,
    required this.questions,
  });
}

class Unit {
  final String id;
  final String title;
  final String subtitle;
  bool isLocked;
  final List<Lesson> lessons;

  Unit({
    required this.id,
    required this.title,
    required this.subtitle,
    this.isLocked = false,
    required this.lessons,
  });
}
