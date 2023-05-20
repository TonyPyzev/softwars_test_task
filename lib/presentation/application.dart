import 'package:flutter/material.dart';
import 'package:softwars_test_task/presentation/theme/app_theme.dart';

import 'navigation/navigation.dart';

class Application extends StatelessWidget {
  final String _title = 'Todoshechka';

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routes: Navigation.routes,
      initialRoute: Navigation.initialRoute,
    );
  }
}
