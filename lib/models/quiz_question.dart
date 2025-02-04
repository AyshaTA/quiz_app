import 'package:flutter/material.dart';

class QuizQuestion extends StatefulWidget {

  const QuizQuestion(this.text, this.answer, {super.key});
  final String text;
  final List<String> answer;

  List<String>getShuffledAnswers(){
    final shuffleList = List.of(answer);
    shuffleList.shuffle();
    return shuffleList;
  }


  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
