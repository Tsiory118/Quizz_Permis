class Question {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;
  final String? imagePath; // 👈 ajout du champ image optionnel

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
    this.imagePath, // 👈 on l’ajoute ici aussi
  });
}
