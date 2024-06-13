import 'package:flutter/material.dart';
import 'package:student_management/db_helper/db_functions.dart';
// import 'package:student_management/login_screen.dart';
import 'package:student_management/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDataBase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromARGB(255, 141, 171, 185)),
      title: 'Student_Management_System',
      home: LoginPage(),
    );
  }
}
