import 'package:flutter/material.dart';

class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 20.0;
  static const double paddingXLarge = 24.0;
  
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  
  static const double iconSmall = 16.0;
  static const double iconMedium = 20.0;
  static const double iconLarge = 24.0;
  
  static const double fontSmall = 12.0;
  static const double fontMedium = 14.0;
  static const double fontLarge = 16.0;
  static const double fontXLarge = 18.0;
  static const double fontXXLarge = 20.0;
  static const double fontXXXLarge = 24.0;
}

class AppColors {
  static const Color primary = Color(0xFF4B7BF5);
  static const Color primaryDark = Color(0xFF3B5FE8);
  static const Color secondary = Color(0xFF00C896);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFFF5252);
  
  static const Color textPrimary = Color(0xFF2D3142);
  static const Color textSecondary = Color(0xFF8F9BB3);
  static const Color textLight = Color(0xFFE8E8E8);
  
  static const Color background = Color(0xFFF8F9FB);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);
}

class AppTextStyles {
  static const TextStyle headingLarge = TextStyle(
    fontSize: AppSizes.fontXXXLarge,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle headingMedium = TextStyle(
    fontSize: AppSizes.fontXXLarge,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle headingSmall = TextStyle(
    fontSize: AppSizes.fontXLarge,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: AppSizes.fontLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: AppSizes.fontMedium,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: AppSizes.fontSmall,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle labelLarge = TextStyle(
    fontSize: AppSizes.fontLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontSize: AppSizes.fontMedium,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: AppSizes.fontSmall,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );
}

class AppShadows {
  static List<BoxShadow> get soft => [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get medium => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 15,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get hard => [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];
}
