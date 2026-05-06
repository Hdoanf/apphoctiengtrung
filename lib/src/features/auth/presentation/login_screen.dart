import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/tactile_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'ĐĂNG NHẬP',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildTextField(hint: 'Email hoặc tên đăng nhập'),
            const SizedBox(height: 16),
            _buildTextField(hint: 'Mật khẩu', obscure: true),
            const SizedBox(height: 24),
            TactileButton(
              onPressed: () => context.go('/home'),
              backgroundColor: AppColors.primary,
              shadowColor: AppColors.primaryDark,
              child: Text(
                'ĐĂNG NHẬP',
                style: GoogleFonts.lexend(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: Text(
                'QUÊN MẬT KHẨU?',
                style: GoogleFonts.lexend(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chưa có tài khoản? ',
                  style: GoogleFonts.lexend(color: AppColors.textSecondary),
                ),
                GestureDetector(
                  onTap: () => context.go('/register'),
                  child: Text(
                    'Đăng ký ngay',
                    style: GoogleFonts.lexend(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      style: GoogleFonts.lexend(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.lexend(color: AppColors.textTertiary),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.outline, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.outline, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
