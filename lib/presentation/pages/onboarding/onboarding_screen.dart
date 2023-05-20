import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:softwars_test_task/presentation/constants/app_colors.dart';
import 'package:softwars_test_task/presentation/pages/home/home_screen.dart';
import 'package:softwars_test_task/presentation/theme/app_theme.dart';

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
        child: GestureDetector(
          onTap: () {
            //TODO fetch data
            Navigator.of(context).pushNamed(HomeScreen.pageRoute);
          },
          child: Container(
            height: 50,
            width: 140,
            decoration: BoxDecoration(
              color: AppColors.primaryVariant,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                'Вхід',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
