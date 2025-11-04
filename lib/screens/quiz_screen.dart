import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../data/questions.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int remainingTime = 30;
  Timer? timer;

  late List<int> randomOrder; // Contiendra les index des 8 questions tirées au hasard
  final int totalQuestions = 8; // 🔹 nombre de questions à afficher

  @override
  void initState() {
    super.initState();
    generateRandomQuestions();
    startTimer();
  }

  /// Sélectionne 8 questions aléatoires parmi toutes
  void generateRandomQuestions() {
    final allIndexes = List<int>.generate(questions.length, (i) => i);
    allIndexes.shuffle(Random());

    // 🔹 Si tu veux afficher 8 questions
    randomOrder = allIndexes.take(
      questions.length >= totalQuestions ? totalQuestions : questions.length,
    ).toList();
  }

  void startTimer() {
    timer?.cancel();
    setState(() {
      remainingTime = 30;
    });

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        t.cancel();
        moveToNextQuestion();
      }
    });
  }

  void answerQuestion(int selectedIndex) {
    int currentIndex = randomOrder[currentQuestionIndex];
    if (selectedIndex == questions[currentIndex].correctAnswerIndex) {
      score++;
    }
    moveToNextQuestion();
  }

  void moveToNextQuestion() {
    timer?.cancel();

    if (currentQuestionIndex + 1 >= randomOrder.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: score, total: randomOrder.length),
        ),
      );
    } else {
      setState(() {
        currentQuestionIndex++;
      });
      startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[randomOrder[currentQuestionIndex]];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1}/$totalQuestions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.help_outline, color: Colors.deepPurpleAccent, size: 40),
              SizedBox(height: 20),

              // Image responsive
              if (question.imagePath != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      question.imagePath!,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

              Text(
                question.questionText,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer, color: Colors.redAccent),
                  SizedBox(width: 8),
                  Text(
                    '$remainingTime s',
                    style: TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Boutons de réponses
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
      ),
    );
  }
}
