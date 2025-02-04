import 'package:flutter/material.dart';
import 'package:quizapp/data/questions.dart';
import 'package:quizapp/screens/question_screen.dart';
import 'package:quizapp/screens/result_screen.dart';
import 'package:quizapp/screens/start_screen.dart';
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer){
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length){
      setState(() {

        activeScreen = 'results-screen';

      });
    }

  }
void restartQuiz(){
    setState(() {
      selectedAnswers=[];
      activeScreen='question_screen';
    });
}

  @override
  Widget build(BuildContext context) {

    Widget screenWidget = StartScreen(switchScreen);
    if (activeScreen == 'question-screen'){
      screenWidget = QuestionScreen(onSelectAnswer: chooseAnswer);
    }

    if (activeScreen == 'results-screen'){
      screenWidget = ResultScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    //final screenWidget = activeScreen == 'start-screen'
      //  ?  StartScreen(switchScreen)
        //: const QuestionScreen();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 227, 183, 122),
                Color.fromARGB(255, 255, 245, 236),
              ],
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
