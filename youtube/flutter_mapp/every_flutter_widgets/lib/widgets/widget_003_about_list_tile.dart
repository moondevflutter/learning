import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AboutListTile(
        icon: Icon(Icons.info),
        applicationName: 'Application Name',
        applicationVersion: '1.0.0',
        applicationIcon: Icon(Icons.ac_unit),
        aboutBoxChildren: [
          Text('This is a text created by Moon'),
        ],
      ),
    );
  }
}
