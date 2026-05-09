import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/character_tile.dart';
import '../../../core/widgets/tactile_button.dart';
import '../../../core/models/lesson_models.dart';
import '../../../core/data/lesson_service.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;
  const LessonScreen({super.key, required this.lessonId});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _selectedIndex = -1;
  int _currentQuestionIndex = 0;
  late final Lesson _lesson;
  late final List<QuizQuestion> _questions;
  
  // Shuffled options for the current question
  List<Map<String, String>> _shuffledOptions = [];
  int _shuffledCorrectIndex = -1;

  @override
  void initState() {
    super.initState();
    _lesson = LessonService().units
        .expand((unit) => unit.lessons)
        .firstWhere((lesson) => lesson.id == widget.lessonId);
    _questions = _lesson.questions;
    
    if (_questions.isNotEmpty) {
      _prepareQuestion();
    }
  }

  void _prepareQuestion() {
    final originalQuestion = _questions[_currentQuestionIndex];
    final originalCorrectOption = originalQuestion.options[originalQuestion.correctIndex];
    
    // Create a mutable copy and shuffle
    _shuffledOptions = List<Map<String, String>>.from(originalQuestion.options)..shuffle();
    
    // Find the new index of the correct option
    _shuffledCorrectIndex = _shuffledOptions.indexOf(originalCorrectOption);
    _selectedIndex = -1;
  }

  double get _progress => (_currentQuestionIndex) / _questions.length;

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Chưa có bài tập cho bài học này.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Quay lại'),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      currentQuestion.text,
                      style: GoogleFonts.lexend(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                        height: 1.25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 32),
                    _buildOptionsGrid(),
                  ],
                ),
              ),
            ),
            _buildActionArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 16),
      color: AppColors.background.withOpacity(0.9),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: const Icon(
                Icons.close_rounded, 
                color: AppColors.outline, 
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildProgressBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 16,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: _progress > 0 ? _progress : 0.05,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 2,
                left: 4,
                right: 4,
                height: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: _shuffledOptions.length,
      itemBuilder: (context, index) {
        final option = _shuffledOptions[index];
        return CharacterTile(
          character: option['character']!,
          pinyin: option['pinyin']!,
          imageUrl: option['image'],
          isSelected: _selectedIndex == index,
          onTap: () => setState(() => _selectedIndex = index),
        );
      },
    );
  }

  Widget _buildActionArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: AppColors.background,
      ),
      child: TactileButton(
        onPressed: _selectedIndex == -1 ? null : () => _checkAnswer(),
        backgroundColor: _selectedIndex == -1 ? AppColors.outlineVariant : AppColors.primary,
        shadowColor: _selectedIndex == -1 ? AppColors.outline : AppColors.primaryDark,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            'KIỂM TRA',
            style: GoogleFonts.lexend(
              color: _selectedIndex == -1 ? AppColors.textSecondary : AppColors.onPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  void _checkAnswer() {
    if (_selectedIndex == _shuffledCorrectIndex) {
      _showResultSheet(isCorrect: true);
    } else {
      _showResultSheet(isCorrect: false);
    }
  }

  void _showResultSheet({required bool isCorrect}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isCorrect ? AppColors.primary : AppColors.error,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCorrect ? Icons.check_rounded : Icons.close_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    isCorrect ? 'Tuyệt vời!' : 'Chưa chính xác!',
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TactileButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (isCorrect) {
                    if (_currentQuestionIndex < _questions.length - 1) {
                      setState(() {
                        _currentQuestionIndex++;
                        _prepareQuestion();
                      });
                    } else {
                      // Mark lesson as completed
                      LessonService().completeLesson(widget.lessonId);
                      context.pop(true); // Return true to signal completion
                    }
                  } else {
                    setState(() {
                      _selectedIndex = -1;
                      _prepareQuestion(); // Reshuffle even on wrong answer for challenge
                    });
                  }
                },
                backgroundColor: Colors.white,
                shadowColor: isCorrect ? AppColors.primaryDark : const Color(0xFFD32F2F),
                child: Text(
                  isCorrect ? 'TIẾP TỤC' : 'THỬ LẠI',
                  style: GoogleFonts.lexend(
                    color: isCorrect ? AppColors.primaryDark : AppColors.error,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
