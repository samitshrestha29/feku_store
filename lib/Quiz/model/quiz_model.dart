import 'dart:math';

class Question {
  String question;
  String correctAnswer;
  List<String> incorrectAnswer;
  Question({
    required this.correctAnswer,
    required this.incorrectAnswer,
    required this.question,
  });
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        correctAnswer: json['correct_answer'],
        incorrectAnswer: json['incorrect_answers'],
        question: json['question']);
  }
  List<String> allanswer() {
    return [...incorrectAnswer, correctAnswer]..shuffle(Random());
  }
}



// List<String> allanswer() {
//   List<String> answers = List.from(incorrectAnswer); // Create a copy of incorrectAnswer
//   answers.add(correctAnswer); // Add the correctAnswer to the list
//   answers.shuffle(Random()); // Shuffle the list
//   return answers; // Return the shuffled list
// }

//use of spreadoperator and cascade operator