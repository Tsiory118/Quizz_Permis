import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: ElevatedButton.icon(
            icon: Icon(Icons.play_arrow),
            label: Text("Examen Code Permis B"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => QuizScreen()),
              );
            },
          ),
        ),
      ),
    );
  }
}
