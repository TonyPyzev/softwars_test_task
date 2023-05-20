import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:softwars_test_task/presentation/theme/app_theme.dart';

import 'components/components.dart';

class HomeScreen extends StatefulWidget {
  static const String pageRoute = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppTheme.scaffoldgradient,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Column(
            children: [
              const HomeNavBar(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return ToDoCheckTile();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const HomeFAB(),
    );
  }
}
