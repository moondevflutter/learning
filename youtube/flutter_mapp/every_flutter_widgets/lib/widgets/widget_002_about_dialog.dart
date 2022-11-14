import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AboutDialog(
              applicationName: 'Application Name',
              applicationVersion: '1.0.0',
              applicationIcon: Icon(Icons.ac_unit),
              applicationLegalese: 'Application Legalese',
              children: [
                Text('This is a text created by Moon'),
              ],
            ),
          );
        },
        child: const Text('Show About Dialog'),
      ),
    );
  }
}
