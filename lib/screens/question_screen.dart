import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/components/answer_button.dart';
import 'package:quizapp/data/questions.dart';
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key,required this.onSelectAnswer});
  final void Function(String answer) onSelectAnswer;



  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  var currentQuestionIndex =0;
  void answerQuestion(String selectedAnswer) {
    final currentQuestion = questions[currentQuestionIndex];
    bool isCorrect = selectedAnswer == currentQuestion.answer[0];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isCorrect ? 'Correct Answer!' :'Wrong Answer!',
      style: const TextStyle(fontSize: 18),),
      backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });

  }


  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return  Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.stretch ,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
               textAlign: TextAlign.center,
               currentQuestion.text,
             style: GoogleFonts.lato(
                 fontSize: 24,
                 color: Colors.white,
                 fontWeight: FontWeight.bold,

             ),),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffledAnswers().map((answer){
              return Padding(
                padding: const EdgeInsets.only(bottom: 10), // Adds space below each button
                child: AnswerButton(
                  text: answer,
                  onTap: () {
                    answerQuestion(answer);
                  },
                ),);
            })
            
          ],
        ),
      ));
  }
}
