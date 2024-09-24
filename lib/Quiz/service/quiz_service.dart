import 'dart:convert';

import 'package:feku_store/Quiz/model/quiz_model.dart';
import 'package:http/http.dart' as http;

class QuizService {
  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=9&difficulty=medium&type=multiple'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final questions =
          (data['results'] as List).map((e) => Question.fromJson(e)).toList();
      return questions;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
