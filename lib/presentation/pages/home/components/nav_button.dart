import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../theme/app_theme.dart';

class NavButton extends StatelessWidget {
  final String title;
  final bool isActive;

  const NavButton({
    super.key,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isActive ? AppColors.disabled : AppColors.primary,
          boxShadow: isActive ? AppTheme.shadow : [],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryVariant,
            ),
          ),
        ),
      ),
    );
  }
}
