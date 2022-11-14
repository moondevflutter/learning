import 'widgets/widget__test.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text('Every Flutter Widgets'),
      ),
      body: const TestWidget(),
    );
  }
}
