import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../cubit/home/home_cubit.dart';
import '../../theme/app_theme.dart';
import 'components/home_components.dart';

class HomeScreen extends StatefulWidget {
  static const String pageRoute = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppTheme.scaffoldgradient,
      body: SafeArea(
        child: Column(
          children: [
            HomeNavBar(
              pageController: _pageController,
            ),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: [
                      TaskListView(
                        tasks: state.tasks,
                      ),
                      TaskListView(
                        tasks: state.workTasks,
                      ),
                      TaskListView(
                        tasks: state.personalTasks,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const HomeFAB(),
    );
  }
}
