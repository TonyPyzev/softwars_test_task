import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class TaskRadioTile extends StatelessWidget {
  final String title;
  final bool isActive;

  const TaskRadioTile({
    super.key,
    required this.isActive,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: Center(
            child: AnimatedContainer(
              width: isActive ? 16 : 0,
              height: isActive ? 16 : 0,
              curve: Curves.easeInCubic,
              duration: const Duration(milliseconds: 150),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryVariant,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.secondaryVariant,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
