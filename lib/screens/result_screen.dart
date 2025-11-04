import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    String message;
    IconData icon;

    if (score == total) {
      message = "Arahabaina ianao !";
      icon = Icons.emoji_events;
    } else {
      message = "Mamerina afaka tapabolana";
      icon = Icons.mood_bad;
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 100, color: Colors.deepPurpleAccent),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Valiny marina : $score / $total",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                icon: Icon(Icons.replay),
                label: Text("Mpiadina manaraka"),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
