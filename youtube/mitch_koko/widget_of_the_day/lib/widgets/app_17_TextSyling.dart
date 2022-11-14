import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text('Flutter Widget'),
      ),
      body: const Text('Text Widet Tutorial',
          style: TextStyle(
            fontSize: 35,
            fontStyle: FontStyle.italic,
          )),
    );
  }
}
