import 'package:flutter/material.dart';

import '../pages/description/create_task_screen.dart';
import '../pages/home/home_screen.dart';
import '../pages/onboarding/onboarding_screen.dart';

class Navigation {
  static const String initialRoute = OnboardingScreen.pageRoute;

  static final Map<String, Widget Function(BuildContext)> routes = {
    OnboardingScreen.pageRoute: (context) => const OnboardingScreen(),
    HomeScreen.pageRoute: (context) => const HomeScreen(),
    DescriptionScreen.pageRoute: (context) =>
        DescriptionScreen(context: context),
  };
}
