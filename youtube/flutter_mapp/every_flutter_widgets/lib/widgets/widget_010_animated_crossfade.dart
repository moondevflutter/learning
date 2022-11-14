import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with TickerProviderStateMixin {
  bool _bool = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: double.infinity,
          height: 100,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _bool = !_bool;
            });
          },
          child: const Text(
            'Switch',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Image.asset(
            'assets/icon/blue.jpg',
            width: double.infinity,
          ),
          secondChild: Image.asset(
            'assets/icon/ocean.jpg',
            width: double.infinity,
          ),
          crossFadeState:
              _bool ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(seconds: 2),
        ),
      ],
    );
  }
}
