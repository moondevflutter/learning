import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  bool _first = true;
  double _fontSize = 60;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 120,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: _color,
              fontSize: _fontSize,
              fontWeight: FontWeight.bold,
            ),
            child: const Text('Flutter'),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _fontSize = _first ? 90 : 60;
              _color = _first ? Colors.blue : Colors.red;
              _first = !_first;
            });
          },
          child: const Text(
            'Switch',
            // style: TextStyle(
            //   color: Colors.blueAccent,
            // ),
          ),
        ),
      ],
    );
  }
}
