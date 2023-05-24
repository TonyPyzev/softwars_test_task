import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../constants/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rounded_button.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String pageRoute = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppTheme.scaffoldgradient,
      body: Center(
        child: RoundedButton(
          title: 'Вхід',
          width: 140,
          color: AppColors.primaryVariant,
          onTap: () {
            Navigator.of(context).pushNamed(HomeScreen.pageRoute);
          },
        ),
      ),
    );
  }
}
