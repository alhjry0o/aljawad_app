import 'package:flutter/material.dart';

import '../constants/app_colors.dart';


enum AppButtonVariant {
  
  primary,

  
  secondary,

  
  outline,

  
  ghost,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.fullWidth = true,
    this.loading = false,
    this.height = 54,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool fullWidth;
  final bool loading;
  final double height;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || loading;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height,
      child: _build(context, disabled),
    );
  }

  Widget _build(BuildContext context, bool disabled) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (variant) {
      case AppButtonVariant.primary:
        return _GradientButton(
          onPressed: disabled ? null : onPressed,
          gradient: LinearGradient(
            colors: disabled
                ? [AppColors.grey300, AppColors.grey300]
                : const [AppColors.greenDeep, AppColors.greenBright],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shadowColor: disabled
              ? Colors.transparent
              : AppColors.green.withOpacity(isDark ? 0.45 : 0.32),
          child: _content(AppColors.white),
        );

      case AppButtonVariant.secondary:
        return _GradientButton(
          onPressed: disabled ? null : onPressed,
          gradient: LinearGradient(
            colors: disabled
                ? [AppColors.grey300, AppColors.grey300]
                : const [AppColors.navyDeep, AppColors.navyLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shadowColor: disabled
              ? Colors.transparent
              : AppColors.navy.withOpacity(isDark ? 0.5 : 0.28),
          child: _content(AppColors.white),
        );

      case AppButtonVariant.outline:
        final color = isDark ? AppColors.greenBright : AppColors.navy;
        return OutlinedButton(
          onPressed: disabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: color,
            side: BorderSide(color: color, width: 1.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: _content(color),
        );

      case AppButtonVariant.ghost:
        final color = isDark ? AppColors.greenBright : AppColors.navy;
        return TextButton(
          onPressed: disabled ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: _content(color),
        );
    }
  }

  Widget _content(Color color) {
    if (loading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.2,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      );
    }

    final textStyle = TextStyle(
      color: color,
      fontSize: 15,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.3,
    );

    if (icon == null) return Text(label, style: textStyle);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(label, style: textStyle),
      ],
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.onPressed,
    required this.gradient,
    required this.shadowColor,
    required this.child,
  });

  final VoidCallback? onPressed;
  final LinearGradient gradient;
  final Color shadowColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(14),
        boxShadow: onPressed == null
            ? const []
            : [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                  spreadRadius: -2,
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          splashColor: Colors.white.withOpacity(0.18),
          highlightColor: Colors.white.withOpacity(0.06),
          child: Center(child: child),
        ),
      ),
    );
  }
}
