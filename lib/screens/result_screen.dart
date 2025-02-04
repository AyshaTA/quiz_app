import 'package:flutter/material.dart';
import 'package:quizapp/components/question_summary.dart';
import 'package:quizapp/data/questions.dart';
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key,required this.chosenAnswers,required this.onRestart});
  final void Function() onRestart;
  final List<String>chosenAnswers;

  List<Map<String,Object>> getSummaryData(){
    final List<Map<String,Object>> summary =[];
    for (var i =0; i < chosenAnswers.length;i++){
      summary.add(
  {
    'questions_index' : i,
    'question' : questions[i].text,
    'correct_answer':questions[i].answer[0],
    'user_answer':chosenAnswers[i],
  }
      );
  }
    return summary;
}




  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = getSummaryData().where((data){
      return data['user_answer'] == data['correct_answer'];
    }).length;


    return SizedBox(
      width: double.infinity ,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly..!',
           style: const TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold,
             color: Colors.brown,
           ), ),
            const SizedBox(height: 30),
            QuestionSummary(getSummaryData()),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,

              ),
                icon: Icon(Icons.restart_alt),
                onPressed: onRestart,
                label: const Text('Restart Quiz')),
          ],
        ),
      ),
    );
  }
}
