import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 40,
    this.showText = false,
    this.textColor,
  });

  final double size;
  final bool showText;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        AppAssets.logo,
        fit: BoxFit.contain,
        // إذا لم يوجد الملف، اعرض Placeholder مرسوماً
        errorBuilder: (_, __, ___) => _fallback(size),
      ),
    );

    if (!showText) return logo;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        logo,
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            'شركة الجواد الدولية العربية',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: textColor ?? AppColors.navy,
            ),
          ),
        ),
      ],
    );
  }

  /// Placeholder احتياطي — يظهر فقط إذا فُقد ملف الشعار.
  Widget _fallback(double size) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.navy, AppColors.navyLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.28),
        border: Border.all(color: AppColors.green, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(
        'الجواد',
        style: TextStyle(
          color: AppColors.white,
          fontSize: size * 0.32,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}