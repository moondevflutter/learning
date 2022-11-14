import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with TickerProviderStateMixin {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          width: selected ? 200.0 : 100.0,
          height: selected ? 100.0 : 200.0,
          color: selected ? Colors.blueGrey : Colors.white,
          alignment:
              selected ? Alignment.center : AlignmentDirectional.topCenter,
          child: const FlutterLogo(size: 75),
          curve: Curves.fastOutSlowIn,
          // transform: Matrix4.rotationZ(selected ? pi / 12.0 : 0.0),
        ),
      ),
    );
  }
}
