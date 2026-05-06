import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/progress_bar.dart';
import '../../../core/widgets/tactile_button.dart';

class ListeningSpeakingScreen extends StatelessWidget {
  const ListeningSpeakingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: () => context.pop(),
                  ),
                  const Expanded(
                    child: ProgressBar(progress: 0.6),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 4),
                  const Text('5', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Nghe và chọn nghĩa đúng',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 40),
                    // Speaker Button
                    TactileButton(
                      onPressed: () {
                        // Play audio logic here
                      },
                      backgroundColor: AppColors.secondary,
                      shadowColor: AppColors.secondaryDark,
                      height: 120,
                      borderRadius: 24,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.volume_up, size: 48, color: Colors.white),
                          SizedBox(height: 8),
                          Text(
                            'NHẤN ĐỂ NGHE',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Options
                    _buildOption(context, 'Xin chào'),
                    const SizedBox(height: 16),
                    _buildOption(context, 'Tạm biệt'),
                    const SizedBox(height: 16),
                    _buildOption(context, 'Cảm ơn'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TactileButton(
                onPressed: () => context.pop(),
                backgroundColor: AppColors.primary,
                shadowColor: AppColors.primaryDark,
                child: const Text(
                  'KIỂM TRA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline, width: 2),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
