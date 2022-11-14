import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120.0,
        width: double.infinity,
        color: Colors.blueGrey,
        child: const Align(
          alignment: Alignment.topRight,
          child: FlutterLogo(
            size: 60.0,
          ),
        ),
      ),
    );
  }
}
