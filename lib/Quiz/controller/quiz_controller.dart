import 'package:feku_store/Quiz/controller/quiz_state.dart';
import 'package:feku_store/Quiz/service/quiz_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizController extends StateNotifier<QuizState> {
//   Quiz Game Manager:
// The QuizController is like a manager or teacher who runs the quiz game,
// keeps track of questions, scores, and more.
// Quiz State:
// The QuizState is like a special notebook or board where all the current details
// of the quiz game are written down. It includes:
// The list of quiz questions.
// The current question being asked.
// The player's current score.
// Any other important information about the game.
  final QuizService quizService;

  // Constructor initializes the state and fetches questions
// The QuizService instance (quizService) in the QuizController class holds the logic to fetch
//quiz questions from an external source, such as an API. This instance is used to call the method
//fetchQuestions which retrieves the quiz questions and provides them to the QuizController.
  QuizController(this.quizService) : super(QuizState(questions: []));
}
