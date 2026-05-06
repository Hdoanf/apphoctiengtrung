import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: _buildBottomNav(context),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUnitSection(
              title: 'Unit 1: Chào hỏi & Giới thiệu',
              subtitle: 'Học các câu cơ bản',
              isLocked: false,
              children: [
                _buildLessonCard(
                  title: 'Xin chào',
                  statusText: 'Hoàn thành',
                  icon: Icons.check_rounded,
                  iconColor: AppColors.onPrimary,
                  iconBgColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  isCompleted: true,
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _buildLessonCard(
                  title: 'Tên của bạn',
                  statusText: 'Đang học',
                  icon: Icons.play_arrow_rounded,
                  iconColor: AppColors.surface,
                  iconBgColor: AppColors.secondaryContainer,
                  borderColor: AppColors.outline,
                  progress: 0.5,
                  onTap: () => context.push('/lesson'),
                ),
                const SizedBox(height: 12),
                _buildLessonCard(
                  title: 'Số đếm',
                  statusText: 'Khóa',
                  icon: Icons.lock_rounded,
                  iconColor: AppColors.textSecondary,
                  iconBgColor: AppColors.surfaceContainerHighest,
                  borderColor: AppColors.outline,
                  isLocked: true,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildUnitSection(
              title: 'Unit 2: Giao tiếp hàng ngày',
              subtitle: 'Hoàn thành Unit 1 để mở khóa',
              isLocked: true,
              children: [
                _buildLessonCard(
                  title: 'Bài 1',
                  statusText: 'Khóa',
                  icon: Icons.lock_rounded,
                  iconColor: AppColors.textSecondary,
                  iconBgColor: AppColors.surfaceContainerHighest,
                  borderColor: AppColors.outline,
                  isLocked: true,
                  onTap: () {},
                  hideSubtitle: true,
                ),
              ],
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
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: AppColors.outline, height: 1),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceContainerHighest,
              border: Border.all(color: AppColors.outlineVariant),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDGg2jes9OR4dbnuzeRefNSIW7Cs454hR9NTP9aDsnqFprsuBmWU5Jo-I0dIdmkps5__lSOiNrPeN1KLuby1nCe6RsZCvfi30igkEqXbLpzjF0FIhOFXr-K618Muy3_7JxVfksrkzUbpZmYAoTR-pVCi01_wE4Oq8NxAXB4LUswt2HI2Z-xMyoVyphckrnpaqYuU5rYdw5dCntUp4j9TFLEGp6nQB8hJYS6BwFPAgE6L0ILmKjLVc4J4pRwAvjmJmwwpVSjoD4nDoQ',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Học tập',
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            const Icon(Icons.local_fire_department_rounded, color: AppColors.streak, size: 24),
            const SizedBox(width: 4),
            Text(
              '12',
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.streak,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            const Icon(Icons.military_tech_rounded, color: AppColors.secondaryContainer, size: 24),
            const SizedBox(width: 4),
            Text(
              '450',
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.secondaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildUnitSection({
    required String title,
    required String subtitle,
    required bool isLocked,
    required List<Widget> children,
  }) {
    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isLocked) ...[
                const Icon(Icons.lock_rounded, color: AppColors.textSecondary, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: isLocked ? AppColors.textSecondary : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildLessonCard({
    required String title,
    required String statusText,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required Color borderColor,
    bool isCompleted = false,
    bool isLocked = false,
    bool hideSubtitle = false,
    double? progress,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isLocked ? AppColors.surfaceContainerHighest : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isLocked ? Colors.transparent : borderColor),
          boxShadow: [
            BoxShadow(
              color: isLocked ? AppColors.outlineVariant : borderColor,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBgColor,
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.lexend(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: isLocked ? AppColors.textSecondary : AppColors.textPrimary,
                        ),
                      ),
                      if (!hideSubtitle)
                        Text(
                          statusText,
                          style: GoogleFonts.lexend(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (progress != null) ...[
              const SizedBox(height: 12),
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(6),
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
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
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
          _buildNavItem(context, 'Học tập', Icons.auto_stories_rounded, true, '/learn'),
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
