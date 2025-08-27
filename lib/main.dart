import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen code',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.deepPurpleAccent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
