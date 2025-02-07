import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/components/answer_button.dart';
import 'package:quizapp/data/questions.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;
  String? feedbackMessage;
  Color? feedbackColor;

  void answerQuestion(String selectedAnswer) {
    final currentQuestion = questions[currentQuestionIndex];
    bool isCorrect = selectedAnswer == currentQuestion.answer[0];

    setState(() {
      feedbackMessage = isCorrect ? 'Correct Answer!' : 'Wrong Answer!';
      feedbackColor = isCorrect ? Colors.green : Colors.red;
      widget.onSelectAnswer(selectedAnswer);
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          feedbackMessage = null; 
          currentQuestionIndex++; 
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 182, 134),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentQuestion.text,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ...currentQuestion.getShuffledAnswers().map(
                (answer) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AnswerButton(
                      text: answer,
                      onTap: () {
                        answerQuestion(answer);
                      },
                    ),
                  );
                },
              ),
              if (feedbackMessage != null) 
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    feedbackMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: feedbackColor,
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
