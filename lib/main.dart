import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

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
  //Asi se crean arreglos con un tipo de variable especifico en Dart
  List <Icon> scorekeeper = [];

  int cont = 0;

  void resetScoreKeeper(){
    scorekeeper = [];
  }
  void checkAnswer(bool userPickedAnswer){
    setState(() {
      if(cont == 15) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Fin del juego",
          desc: "Ya no hay más preguntas disponibles",
          buttons: [
            DialogButton(
              child: Text(
                "Reiniciar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        resetScoreKeeper();
        cont = 0;
      }
      else {
        if (userPickedAnswer == quizBrain.getQuestionAnswer()){
          scorekeeper.add(
            Icon(Icons.check, color: Colors.green,),
          );
        }
        else{
          scorekeeper.add(
            Icon(Icons.close, color: Colors.red,),
          );
        }
        cont++;
      }
      quizBrain.nextquestion();
    });
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
                //Asi se accede al elemento especifico del array de objetos compuestos
                quizBrain.getQuestionText(),
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
                //The user picked true.
                checkAnswer(true);
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
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

//No olvidar que para actualizar el estado de las aplicaciones, es necesario activar un setstate((){})
//Se pueden crear clases para incorporar las listas y administrar el sistema
//Cuando el import deuna libreria se vuelve gris, es porque se vuelve innecesario importarlo
//Como el questionbank se hizo un field de quiz_brain, se debe de realizar la modificacion propia al importar el objeto