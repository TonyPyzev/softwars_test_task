import 'package:flutter/material.dart';
import 'package:softwars_test_task/presentation/pages/home/home_screen.dart';

import '../pages/onboarding/onboarding_screen.dart';

class Navigation {
  static const String initialRoute = OnboardingScreen.pageRoute;

  static final Map<String, Widget Function(BuildContext)> routes = {
    OnboardingScreen.pageRoute: (context) => const OnboardingScreen(),
    HomeScreen.pageRoute: (context) => const HomeScreen(),
  };
}
