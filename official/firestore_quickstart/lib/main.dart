import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'add_user.dart';
// import 'get_username.dart';
import 'user_information.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: AddUser("Moon Jung Sam", "Nasaret Hospital", 52),  // AddUser("John Doe", "Stokes and Sons", 42),
      // home: GetUserName(
      // "TuB46NPFiHy7Fe9CAqsW"), // GetUserName("TuB46NPFiHy7Fe9CAqsW"),
      home: UserInformation(),
    );
  }
}
