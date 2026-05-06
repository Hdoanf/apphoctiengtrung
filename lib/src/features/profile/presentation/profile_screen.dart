import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: _buildBottomNav(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              const Divider(color: AppColors.outlineVariant, thickness: 1),
              const SizedBox(height: 24),
              _buildStatsSection(),
              const SizedBox(height: 32),
              _buildAchievementsSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceContainerHighest,
            border: Border.all(color: AppColors.surfaceContainerLowest, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCRvp7BBt1gSoOk7BHVQtveBaO_yz6jZlzlgGnB36RSCyu5QjWCLBqDkSyoArOTw3f-cMyqpeT-P-gHRHlWrIDNVPNK5H2sf-oLce0SbSAIcexDsv_qt-_F5qcGi5pZPaB5oS-NY97cAiCc4EKuoS99qKg79K4_jFsD-LhvBh8GcbYGIvEprujrKqaP1DgvV8wv7sdhEsix0ni_2HEUWHWZ7KPq5pR1JsyachgVlAiehthEcHteSRR2tcroU30-JAR4brRePYckuew',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Alex',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w700,
            fontSize: 32,
            letterSpacing: -0.02 * 32,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Member since Oct 2023',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Stats',
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.local_fire_department_rounded,
                iconColor: AppColors.streak,
                iconBgColor: AppColors.streak.withOpacity(0.2),
                value: '30',
                label: 'Day Streak',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.bolt_rounded,
                iconColor: AppColors.tertiary,
                iconBgColor: AppColors.tertiary.withOpacity(0.3),
                value: '4,250',
                label: 'Total XP',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildLeagueCard(),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: AppColors.outlineVariant,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBgColor,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: AppColors.outlineVariant,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryContainer.withOpacity(0.2),
            ),
            child: const Icon(Icons.shield_rounded, color: AppColors.secondaryContainer, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gold League',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Top 10% this week',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.outlineVariant, size: 28),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Achievements',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'View All',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.secondaryContainer,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildAchievementCard(
          title: 'Wildfire',
          level: 'Level 3',
          description: 'Reach a 30-day streak.',
          progressText: '30 / 30',
          progress: 1.0,
          icon: Icons.local_fire_department_rounded,
          iconColor: AppColors.surface,
          iconBgColor: AppColors.streak,
          rotation: 0.05,
        ),
        const SizedBox(height: 12),
        _buildAchievementCard(
          title: 'Scholar',
          level: 'Level 5',
          description: 'Learn 1000 new words.',
          progressText: '850 / 1000',
          progress: 0.85,
          icon: Icons.menu_book_rounded,
          iconColor: AppColors.surface,
          iconBgColor: AppColors.secondaryContainer,
          rotation: -0.05,
        ),
      ],
    );
  }

  Widget _buildAchievementCard({
    required String title,
    required String level,
    required String description,
    required String progressText,
    required double progress,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required double rotation,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: AppColors.outlineVariant,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Transform.rotate(
            angle: rotation,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceContainerLowest, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(icon, color: iconColor, size: 40),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      level,
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: iconBgColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
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
                            height: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    progressText,
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
          _buildNavItem(context, 'Học tập', Icons.auto_stories_rounded, false, '/learn'),
          _buildNavItem(context, 'Luyện tập', Icons.fitness_center_rounded, false, '/writing-practice'),
          _buildNavItem(context, 'Hồ sơ', Icons.person_rounded, true, '/profile'),
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
