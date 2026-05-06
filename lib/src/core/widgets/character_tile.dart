import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class CharacterTile extends StatelessWidget {
  final String character;
  final String pinyin;
  final String? imageUrl;
  final VoidCallback onTap;
  final bool isSelected;

  const CharacterTile({
    super.key,
    required this.character,
    required this.pinyin,
    this.imageUrl,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.secondaryFixed.withOpacity(0.3) 
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            top: BorderSide(
                color: isSelected ? AppColors.secondaryContainer : AppColors.outlineVariant, 
                width: 2),
            left: BorderSide(
                color: isSelected ? AppColors.secondaryContainer : AppColors.outlineVariant, 
                width: 2),
            right: BorderSide(
                color: isSelected ? AppColors.secondaryContainer : AppColors.outlineVariant, 
                width: 2),
            bottom: BorderSide(
                color: isSelected ? AppColors.secondaryContainer : AppColors.outlineVariant, 
                width: 4), // Thicker bottom for 3D effect
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? AppColors.secondaryContainer.withOpacity(0.08)
                  : Colors.black.withOpacity(0.02),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (imageUrl != null) ...[
              SizedBox(
                width: 96,
                height: 96,
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported_rounded,
                    size: 48,
                    color: AppColors.outline,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              character,
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.secondaryContainer : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              pinyin,
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.secondary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
