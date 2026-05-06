import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/character_tile.dart';
import '../../../core/widgets/tactile_button.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

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

class _LessonScreenState extends State<LessonScreen> {
  int _selectedIndex = -1;
  int _currentQuestionIndex = 0;

  final List<Map<String, String>> _sharedOptions = [
    {
      'character': '再见',
      'pinyin': 'zài jiàn',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDXHe5aFWkI49u9riqv70QHh5TKcZkBaj0eOgQG_g77VIqAcWqLD6sY88eyN2sM8j6CBeLOeDHSxke-GIsIxqAa7NuqlptLYn6c_DUHpK01x8nOUbRUwTacntPja5dpntacfATVrvYmgMPfniVlESTOlFVIJHtecQZJ7zB19OnTqtMNLnorE8lCJebJ1VrHVdmqeB8lXcuzMogDj5Z64gP0bM55FPZUe-fmJlbfVJDinf5EVTqRSQ__Sun_L4JK8EGN-4f2pppHOBY',
    },
    {
      'character': '你好',
      'pinyin': 'nǐ hǎo',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB8QRQQSx9PNEB0QAm_Wl0suXH2uOO9_ktKmSi5mabaqZndTbaFfOdxnJjth0AfP0ilgFR64VYHsGsFQO7fyplXrZChVfC1WmHXmiQkVh3BKnIdDrIZS7pfe-HGoSAG6L58UeiGTraJSP31nNOa7CKcVWEFd47EUokgIpb_79LXjpWnPlkLlV_h58mf1g19LbdUfFDM591k0HDAUdeUBNnGw5lXd7fCGnJXUHF3CypB6rVDrb9esVcHmOXteVyeeklOaarO_fd_89o',
    },
    {
      'character': '谢谢',
      'pinyin': 'xiè xiè',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBHegCa95zxbzDS31uPxfeQuwzcu6VOt9ckRd9ksFCbwcSpF6dYy2JTUkSeaOciGTxiWMJPuujlRNCTKGTz9OXQqzcoN10I2GIElJDIUr8kXBoRg8tA8qCCKef-W1c1vHHwnomugpVU_uwZ6g0ma3M_laWByoLWgIGWTzOOCvSZxpdx0gT-OVq7_LIdLwk08xzYildxE4xooHRW0y0uNqW63MGUwKlFNNUN6FIRMNWnRDaPVsgh7q6Rte1mi1kF-gbAQ1rBr84Cfxo',
    },
    {
      'character': '水',
      'pinyin': 'shuǐ',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCQgML5rlVdi4oNOSSDPvtb9vV5wol5jgGAK7wU1rMI2LNUPTz2e4Ly_dSTHA3ZPuPGsLLZ9cmv-jK_sGl3L7SncdIR_mgwHlFZlFVmjEvFvseV52FbnigRRtLYZKAtlMZAxixfhwU6N_0PKiYS2Yh2_XOQ_c4XmU-PeiBl3sfZJMdolTID41i6ubnNxptMtwPRLCBKqhghLy3GLADTOdUrNr_fN3YgoxHuwkj6QLvuSqttoBQSTfz-B_jS0N9GOyYGdLCXwSVlwmU',
    },
  ];

  late final List<QuizQuestion> _questions;

  @override
  void initState() {
    super.initState();
    _questions = [
      QuizQuestion(
        text: 'Từ nào có nghĩa là "Xin chào"?',
        options: _sharedOptions,
        correctIndex: 1, // 你好
      ),
      QuizQuestion(
        text: 'Từ nào có nghĩa là "Cảm ơn"?',
        options: _sharedOptions,
        correctIndex: 2, // 谢谢
      ),
      QuizQuestion(
        text: 'Từ nào có nghĩa là "Tạm biệt"?',
        options: _sharedOptions,
        correctIndex: 0, // 再见
      ),
      QuizQuestion(
        text: 'Từ nào có nghĩa là "Nước"?',
        options: _sharedOptions,
        correctIndex: 3, // 水
      ),
    ];
  }

  double get _progress => (_currentQuestionIndex) / _questions.length;

  @override
  Widget build(BuildContext context) {
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
                    _buildOptionsGrid(currentQuestion),
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
              decoration: BoxDecoration(
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
              // Liquid 3D highlight
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

  Widget _buildOptionsGrid(QuizQuestion currentQuestion) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75, // Adjust based on your images
      ),
      itemCount: currentQuestion.options.length,
      itemBuilder: (context, index) {
        final option = currentQuestion.options[index];
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
      decoration: BoxDecoration(
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
    final currentQuestion = _questions[_currentQuestionIndex];
    if (_selectedIndex == currentQuestion.correctIndex) {
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
                  Navigator.pop(context); // close bottom sheet
                  if (isCorrect) {
                    if (_currentQuestionIndex < _questions.length - 1) {
                      setState(() {
                        _currentQuestionIndex++;
                        _selectedIndex = -1;
                      });
                    } else {
                      // Finished all questions!
                      context.push('/writing-practice');
                    }
                  } else {
                    setState(() => _selectedIndex = -1);
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
