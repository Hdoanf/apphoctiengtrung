import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: _buildDashboardGrid(context),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: SliverToBoxAdapter(
                child: _buildUnitHeader(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: SliverToBoxAdapter(
                child: _buildPathMap(context),
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _buildDashboardGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outline.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
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
                      CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 8,
                        valueColor: AlwaysStoppedAnimation(AppColors.surfaceContainer),
                      ),
                      CircularProgressIndicator(
                        value: 0.75,
                        strokeWidth: 8,
                        strokeCap: StrokeCap.round,
                        valueColor: const AlwaysStoppedAnimation(AppColors.tertiary),
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
            onTap: () => context.push('/lesson'),
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
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
                          color: Colors.white.withOpacity(0.1),
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
                                color: AppColors.onPrimary.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Greetings 1',
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.onPrimary,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
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
                              decoration: const BoxDecoration(
                                color: AppColors.onPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                size: 20,
                                color: AppColors.primary,
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

  Widget _buildUnitHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unit 1',
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'The Basics',
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
            border: Border.all(color: AppColors.outline.withOpacity(0.5)),
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
    );
  }

  Widget _buildPathMap(BuildContext context) {
    return SizedBox(
      height: 600, // Fixed height for the map
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background Path Line
          Container(
            width: 12,
            height: 500,
            decoration: BoxDecoration(
              color: AppColors.outline.withOpacity(0.5),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          // Active Path Line (Progress)
          Positioned(
            top: 0,
            child: Container(
              width: 12,
              height: 250, // Halfway down
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          // Nodes
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 32 - 20, // offset -20
            child: _buildPathNode(
              context: context,
              icon: Icons.star_rounded,
              status: NodeStatus.completed,
              onTap: () => context.push('/lesson'),
            ),
          ),
          Positioned(
            top: 120,
            left: MediaQuery.of(context).size.width / 2 - 32 + 30, // offset +30
            child: _buildPathNode(
              context: context,
              icon: Icons.star_rounded,
              status: NodeStatus.completed,
              onTap: () => context.push('/lesson'),
            ),
          ),
          Positioned(
            top: 230,
            left: MediaQuery.of(context).size.width / 2 - 40 - 15, // offset -15, larger node
            child: _buildPathNode(
              context: context,
              icon: Icons.play_arrow_rounded,
              status: NodeStatus.current,
              size: 80,
              iconSize: 40,
              onTap: () => context.push('/lesson'),
            ),
          ),
          Positioned(
            top: 360,
            left: MediaQuery.of(context).size.width / 2 - 28 + 25, // offset +25, smaller locked
            child: _buildPathNode(
              context: context,
              icon: Icons.lock_rounded,
              status: NodeStatus.locked,
              size: 56,
              iconSize: 28,
            ),
          ),
          Positioned(
            top: 460,
            left: MediaQuery.of(context).size.width / 2 - 32 - 10, // offset -10, treasure
            child: _buildTreasureNode(),
          ),
        ],
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
    final Color borderColor = isLocked ? AppColors.outline : AppColors.primary;
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
          margin: const EdgeInsets.only(bottom: 4), // tactile depth
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
      // Add pulsing ring for current node
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
                      color: AppColors.primary.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
            onEnd: () {
              // Note: A real implementation would loop this, but TweenAnimationBuilder alone just runs once.
              // We'll leave it simple for now, or use an AnimationController for a continuous ping.
            },
          ),
          node,
        ],
      );
    }

    return node;
  }

  Widget _buildTreasureNode() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.outline,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Icon(Icons.cruelty_free_rounded, color: AppColors.textTertiary, size: 32), // Treasure/Rib cage placeholder
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
