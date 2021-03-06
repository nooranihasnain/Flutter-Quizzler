import 'package:flutter/material.dart';
import 'package:quizzler/quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Widget> ScoreKeeper = [];

  void CheckAnswer(bool UserPickedAnswer)
  {
    if(quizBrain.IsFinished())
      {
        Alert
        (
          context: context,
          type: AlertType.success,
          title: 'Quiz Completed!',
          desc: 'The Quiz has been finished',
          buttons: 
          [
            DialogButton
            (
              child: Text('OK'),
              onPressed: ()=>
              {
                setState(()
                {
                  quizBrain.Reset();
                  ScoreKeeper.clear();
                  Navigator.pop(context);
                })
              },
              width: 120,
            )
          ]
        ).show();
      }
      else
      {
        setState(() {
          bool CorrectAns = quizBrain.GetQuestionAnswer();
          if(UserPickedAnswer == CorrectAns)
          {
            ScoreKeeper.add(Icon(Icons.check, color: Colors.green));
          }
          else
          {
            ScoreKeeper.add(Icon(Icons.close, color: Colors.red));
          }
          quizBrain.NextQuestion();
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.GetQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true
                CheckAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                CheckAnswer(false);
              },
            ),
          ),
        ),
        Row
        (
          children: ScoreKeeper
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
