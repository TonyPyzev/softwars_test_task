import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class FormConatiner extends StatelessWidget {
  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;

  const FormConatiner({
    super.key,
    required this.child,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: const BoxDecoration(
        color: AppColors.disabled,
      ),
      child: child,
    );
  }
}
