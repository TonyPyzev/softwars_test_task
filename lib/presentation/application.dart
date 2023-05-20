import 'package:flutter/material.dart';

import 'navigation/navigation.dart';

class Application extends StatelessWidget {
  final String _title = 'Todoshechka';

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      routes: Navigation.routes,
      initialRoute: Navigation.initialRoute,
    );
  }
}
