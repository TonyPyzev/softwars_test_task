import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  final String _title = 'Todoshechka';

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
