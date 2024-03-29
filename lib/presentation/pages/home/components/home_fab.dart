import 'package:flutter/material.dart';

import '../../description/create_task_screen.dart';
import '../../../theme/app_theme.dart';
import '../../../constants/app_colors.dart';

class HomeFAB extends StatelessWidget {
  const HomeFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DescriptionScreen.pageRoute);
      },
      child: Container(
        height: 71,
        width: 71,
        decoration: BoxDecoration(
          color: AppColors.primaryVariant,
          borderRadius: BorderRadius.circular(25),
          boxShadow: AppTheme.shadow,
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 48,
            color: AppColors.secondaryVariant,
          ),
        ),
      ),
    );
  }
}
