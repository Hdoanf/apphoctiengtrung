import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/tactile_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Premium Logo Illustration
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryDark.withOpacity(0.5),
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  size: 90,
                  color: AppColors.onPrimary,
                ),
              ),
              const SizedBox(height: 60),
              Text(
                'MANDARIN QUEST',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Học tiếng Trung một cách vui vẻ và đầy hứng khởi mỗi ngày.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const Spacer(),
              TactileButton(
                onPressed: () => context.go('/register'),
                backgroundColor: AppColors.primary,
                shadowColor: AppColors.primaryDark,
                child: Text(
                  'BẮT ĐẦU NGAY',
                  style: GoogleFonts.lexend(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TactileButton(
                onPressed: () => context.go('/login'),
                backgroundColor: AppColors.surface,
                shadowColor: AppColors.outline,
                child: Text(
                  'TÔI ĐÃ CÓ TÀI KHOẢN',
                  style: GoogleFonts.lexend(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
