import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static const LinearGradient scaffoldgradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.secondary,
      AppColors.secondaryVariant,
    ],
  );

  static const List<BoxShadow> shadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      offset: Offset(0, 4),
      blurRadius: 4,
    ),
  ];

  static ThemeData get theme {
    return ThemeData().copyWith(
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.disabled,
        onPrimary: AppColors.secondaryVariant,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
    );
  }
}
