import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/tactile_button.dart';

class WritingPracticeScreen extends StatefulWidget {
  const WritingPracticeScreen({super.key});

  @override
  State<WritingPracticeScreen> createState() => _WritingPracticeScreenState();
}

class _WritingPracticeScreenState extends State<WritingPracticeScreen> {
  final List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildCustomBottomNav(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    _buildHeader(),
                    const SizedBox(height: 40),
                    _buildCanvas(),
                    const SizedBox(height: 32),
                    _buildControls(),
                    const Spacer(),
                    _buildActionArea(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          const Icon(Icons.language_rounded, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            'Mandarin',
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: AppColors.primary,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            '🔥 12',
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: AppColors.outline.withOpacity(0.5),
          height: 2,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'shuǐ',
          style: GoogleFonts.lexend(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'water',
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCanvas() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Tian Zi Ge Grid Lines
            Positioned(
              left: 140,
              top: 16,
              bottom: 16,
              child: Container(
                width: 1,
                color: AppColors.outline.withOpacity(0.5),
              ),
            ),
            Positioned(
              top: 140,
              left: 16,
              right: 16,
              child: Container(
                height: 1,
                color: AppColors.outline.withOpacity(0.5),
              ),
            ),
            // Faint Character
            Center(
              child: Opacity(
                opacity: 0.1,
                child: Text(
                  '水',
                  style: TextStyle(
                    fontSize: 180,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    height: 1.0,
                  ),
                ),
              ),
            ),
            // Drawing Layer
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: (details) {
                setState(() {
                  _points.add(details.localPosition);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _points.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _points.add(null);
                });
              },
              child: CustomPaint(
                painter: HandwritingPainter(points: _points),
                size: Size.infinite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Undo / Clear button
        GestureDetector(
          onTap: () => setState(() => _points.clear()),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.secondaryDark,
              shape: BoxShape.circle,
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.replay_rounded, color: AppColors.surface, size: 32),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionArea() {
    return TactileButton(
      onPressed: _checkResult,
      backgroundColor: AppColors.primary,
      shadowColor: AppColors.primaryDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.edit_rounded, color: AppColors.onPrimary),
          const SizedBox(width: 8),
          Text(
            'HOÀN THÀNH',
            style: GoogleFonts.lexend(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  void _checkResult() {
    int drawnPoints = _points.where((p) => p != null).length;
    
    if (drawnPoints < 20) {
      _showResultSheet(isCorrect: false);
    } else {
      _showResultSheet(isCorrect: true);
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
                    setState(() => _points.clear()); // Reset for next practice
                  } else {
                    setState(() => _points.clear());
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

  Widget _buildCustomBottomNav(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.outline, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 'Trang chủ', Icons.home_rounded, false, '/home'),
          _buildNavItem(context, 'Học tập', Icons.auto_stories_rounded, false, '/learn'),
          _buildNavItem(context, 'Luyện tập', Icons.fitness_center_rounded, true, '/writing-practice'),
          _buildNavItem(context, 'Hồ sơ', Icons.person_rounded, false, '/profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String label, IconData icon, bool isActive, String route) {
    final color = isActive ? AppColors.primary : AppColors.textSecondary;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isActive) context.go(route);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            border: isActive ? Border(top: BorderSide(color: AppColors.primary, width: 4)) : const Border(top: BorderSide(color: Colors.transparent, width: 4)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.lexend(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HandwritingPainter extends CustomPainter {
  final List<Offset?> points;

  HandwritingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primaryDark
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(HandwritingPainter oldDelegate) => true;
}
