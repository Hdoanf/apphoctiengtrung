import '../models/lesson_models.dart';
import 'mock_data.dart';

class LessonService {
  static final LessonService _instance = LessonService._internal();
  factory LessonService() => _instance;
  LessonService._internal();

  List<Unit> get units => mockUnits;

  void completeLesson(String lessonId) {
    int unitIndex = -1;
    int lessonIndex = -1;

    // Find the current lesson
    for (int i = 0; i < mockUnits.length; i++) {
      for (int j = 0; j < mockUnits[i].lessons.length; j++) {
        if (mockUnits[i].lessons[j].id == lessonId) {
          unitIndex = i;
          lessonIndex = j;
          break;
        }
      }
      if (unitIndex != -1) break;
    }

    if (unitIndex != -1 && lessonIndex != -1) {
      final currentLesson = mockUnits[unitIndex].lessons[lessonIndex];
      currentLesson.isCompleted = true;
      currentLesson.statusText = 'Hoàn thành';
      currentLesson.progress = 1.0;

      // Unlock next lesson in the same unit
      if (lessonIndex + 1 < mockUnits[unitIndex].lessons.length) {
        final nextLesson = mockUnits[unitIndex].lessons[lessonIndex + 1];
        if (nextLesson.isLocked) {
          nextLesson.isLocked = false;
          nextLesson.statusText = 'Sẵn sàng';
        }
      } 
      // Or unlock first lesson of next unit
      else if (unitIndex + 1 < mockUnits.length) {
        mockUnits[unitIndex + 1].isLocked = false;
        final nextUnitFirstLesson = mockUnits[unitIndex + 1].lessons.first;
        if (nextUnitFirstLesson.isLocked) {
          nextUnitFirstLesson.isLocked = false;
          nextUnitFirstLesson.statusText = 'Sẵn sàng';
        }
      }
    }
  }
}
