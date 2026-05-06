import 'package:flutter/material.dart';
import 'package:hoctiengtrung/src/core/theme/app_colors.dart';

class TactileButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color shadowColor;
  final double borderRadius;
  final double height;
  final double depth;

  const TactileButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = AppColors.primary,
    this.shadowColor = AppColors.primaryDark,
    this.borderRadius = 16,
    this.height = 56,
    this.depth = 4,
  });

  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.height,
        padding: EdgeInsets.only(bottom: _isPressed ? 0 : widget.depth),
        decoration: BoxDecoration(
          color: widget.shadowColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: double.infinity,
          height: widget.height - widget.depth,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}
