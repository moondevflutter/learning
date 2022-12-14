import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  TextEditingController inputController = TextEditingController();
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('$inputText'),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                child: TextField(
                  controller: inputController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    labelStyle: TextStyle(color: Colors.redAccent),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    inputText = inputController.text;
                  });
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
