import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/data/lesson_service.dart';
import '../../../core/models/lesson_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LessonService _lessonService = LessonService();

  @override
  Widget build(BuildContext context) {
    final units = _lessonService.units;
    final nextLesson = _findNextLesson(units);

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: _buildCustomBottomNav(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              sliver: SliverToBoxAdapter(
                child: _buildDashboardGrid(context, nextLesson),
              ),
            ),
            ...units.map((unit) => _buildUnitSection(context, unit)),
          ],
        ),
      ),
    );
  }

  Lesson? _findNextLesson(List<Unit> units) {
    for (final unit in units) {
      if (unit.isLocked) continue;
      for (final lesson in unit.lessons) {
        if (!lesson.isCompleted && !lesson.isLocked) {
          return lesson;
        }
      }
    }
    return null;
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      pinned: true,
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
          child: Row(
            children: [
              Text(
                '🔥 12',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardGrid(BuildContext context, Lesson? nextLesson) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Daily Goal',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 8,
                        valueColor: AlwaysStoppedAnimation(AppColors.surfaceContainer),
                      ),
                      const CircularProgressIndicator(
                        value: 0.75,
                        strokeWidth: 8,
                        strokeCap: StrokeCap.round,
                        valueColor: AlwaysStoppedAnimation(AppColors.tertiary),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '3/4',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.tertiary,
                            ),
                          ),
                          const Icon(Icons.bolt_rounded, size: 16, color: AppColors.tertiary),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: nextLesson == null ? null : () async {
              final result = await context.push('/lesson/${nextLesson.id}');
              if (result == true) setState(() {});
            },
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color: nextLesson == null ? AppColors.outline : AppColors.primaryDark,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: nextLesson == null ? AppColors.surfaceContainer : AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NEXT UP',
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                letterSpacing: 1.2,
                                color: (nextLesson == null ? AppColors.textSecondary : AppColors.onPrimary).withValues(alpha: 0.9),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              nextLesson?.title ?? 'Tất cả xong!',
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: nextLesson == null ? AppColors.textPrimary : AppColors.onPrimary,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (nextLesson != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star_rounded, size: 14, color: AppColors.onPrimary),
                                    const SizedBox(width: 4),
                                    Text(
                                      '10 XP',
                                      style: GoogleFonts.lexend(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: AppColors.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: nextLesson == null ? AppColors.outline : AppColors.onPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                nextLesson == null ? Icons.check_rounded : Icons.play_arrow_rounded,
                                size: 20,
                                color: nextLesson == null ? Colors.white : AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnitSection(BuildContext context, Unit unit) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          sliver: SliverToBoxAdapter(
            child: _buildUnitHeader(unit),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          sliver: SliverToBoxAdapter(
            child: _buildPathMap(context, unit),
          ),
        ),
      ],
    );
  }

  Widget _buildUnitHeader(Unit unit) {
    return Opacity(
      opacity: unit.isLocked ? 0.5 : 1.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                unit.title,
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                unit.subtitle,
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.outline.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                Text(
                  'Guide',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.menu_book_rounded, size: 18, color: AppColors.textSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
Widget _buildPathMap(BuildContext context, Unit unit) {
  final lessons = unit.lessons;
  final double mapHeight = (lessons.length + 1) * 120.0;

  // Calculate how far the active line should go
  double activeHeight = 0;
  int lastReachedIndex = -1;
  for (int i = 0; i < lessons.length; i++) {
    if (lessons[i].isCompleted || !lessons[i].isLocked) {
      lastReachedIndex = i;
    }
  }

  if (lastReachedIndex != -1) {
    activeHeight = 20.0 + (lastReachedIndex * 120.0) + 32.0;
  }

  return Opacity(
    opacity: unit.isLocked ? 0.5 : 1.0,
    child: SizedBox(
      height: mapHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background Path Line
          Container(
            width: 12,
            height: mapHeight - 60,
            decoration: BoxDecoration(
              color: AppColors.outline.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          // Active Path Line
          if (!unit.isLocked && activeHeight > 0)
            Positioned(
              top: 0,
              child: Container(
                width: 12,
                height: activeHeight,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          // Nodes for each lesson
            ...lessons.asMap().entries.map((entry) {
              final index = entry.key;
              final lesson = entry.value;
              final bool isEven = index % 2 == 0;
              final double top = 20.0 + (index * 120.0);
              final double offset = isEven ? -40.0 : 40.0;
              
              NodeStatus status;
              if (unit.isLocked || lesson.isLocked) {
                status = NodeStatus.locked;
              } else if (lesson.isCompleted) {
                status = NodeStatus.completed;
              } else {
                status = NodeStatus.current;
              }

              return Positioned(
                top: top,
                left: MediaQuery.of(context).size.width / 2 - 32 + offset,
                child: _buildPathNode(
                  context: context,
                  icon: status == NodeStatus.completed ? Icons.check_rounded : (status == NodeStatus.locked ? Icons.lock_rounded : Icons.play_arrow_rounded),
                  status: status,
                  onTap: () async {
                    final result = await context.push('/lesson/${lesson.id}');
                    if (result == true) setState(() {});
                  },
                ),
              );
            }),
            Positioned(
              top: 20.0 + (lessons.length * 120.0),
              child: _buildTreasureNode(unit.isLocked),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPathNode({
    required BuildContext context,
    required IconData icon,
    required NodeStatus status,
    double size = 64,
    double iconSize = 32,
    VoidCallback? onTap,
  }) {
    final bool isLocked = status == NodeStatus.locked;
    final bool isCurrent = status == NodeStatus.current;
    
    final Color bgColor = isLocked ? AppColors.surfaceContainer : (isCurrent ? AppColors.surface : AppColors.primary);
    final Color shadowColor = isLocked ? AppColors.outline : (isCurrent ? AppColors.primary : AppColors.primaryDark);
    final Color iconColor = isLocked ? AppColors.textTertiary : (isCurrent ? AppColors.primary : AppColors.onPrimary);

    Widget node = GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: shadowColor,
          shape: BoxShape.circle,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: isCurrent ? Border.all(color: AppColors.primary, width: 6) : null,
          ),
          child: Center(
            child: Icon(icon, color: iconColor, size: iconSize),
          ),
        ),
      ),
    );

    if (isCurrent) {
      return Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: 1.3),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: (1.0 - ((value - 1.0) / 0.3)).clamp(0.0, 1.0),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
          node,
        ],
      );
    }

    return node;
  }

  Widget _buildTreasureNode(bool isLocked) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: isLocked ? AppColors.outline : AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isLocked ? AppColors.surfaceContainer : AppColors.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Icon(
            isLocked ? Icons.lock_outline_rounded : Icons.emoji_events_rounded, 
            color: isLocked ? AppColors.textTertiary : Colors.white, 
            size: 32
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
          _buildNavItem(context, 'Trang chủ', Icons.home_rounded, true, '/home'),
          _buildNavItem(context, 'Học tập', Icons.auto_stories_rounded, false, '/learn'),
          _buildNavItem(context, 'Luyện tập', Icons.fitness_center_rounded, false, '/writing-practice'),
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

enum NodeStatus { completed, current, locked }
