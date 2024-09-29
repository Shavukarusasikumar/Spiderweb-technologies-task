import 'package:flutter/material.dart';
import 'screens/employee_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      theme: ThemeData(
        hintColor: Colors.tealAccent,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
          displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue[800]),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.blue[900]),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.blue[800]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.grey[100]),
      ),
      home: const EmployeeScreen(),
    );
  }
}