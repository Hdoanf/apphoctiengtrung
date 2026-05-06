import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/tactile_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'TẠO HỒ SƠ',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            _buildTextField(hint: 'Tuổi'),
            const SizedBox(height: 16),
            _buildTextField(hint: 'Tên (tùy chọn)'),
            const SizedBox(height: 16),
            _buildTextField(hint: 'Email'),
            const SizedBox(height: 16),
            _buildTextField(hint: 'Mật khẩu', obscure: true),
            const SizedBox(height: 32),
            TactileButton(
              onPressed: () => context.go('/home'),
              backgroundColor: AppColors.primary,
              shadowColor: AppColors.primaryDark,
              child: Text(
                'TẠO TÀI KHOẢN',
                style: GoogleFonts.lexend(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Bằng cách tạo tài khoản trên Mandarin Quest, bạn đồng ý với Các điều khoản và Chính sách bảo mật của chúng tôi.',
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                fontSize: 12,
                color: AppColors.textTertiary,
                height: 1.5,
              ),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
