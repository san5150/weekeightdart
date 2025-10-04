import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyFinanceApp());
}

class MyFinanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Finance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
