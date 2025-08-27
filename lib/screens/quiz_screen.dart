import 'package:flutter/material.dart';
import '../data/questions.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  void answerQuestion(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }

    setState(() {
      currentQuestionIndex++;
    });

    if (currentQuestionIndex >= questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.help_outline, color: Colors.deepPurpleAccent, size: 40),
            SizedBox(height: 20),
            Text(
              question.questionText,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ...List.generate(
              question.answers.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => answerQuestion(index),
                  child: Text(question.answers[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
