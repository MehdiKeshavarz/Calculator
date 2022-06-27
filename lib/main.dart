import 'package:flutter/material.dart';
import 'package:flutter_app_calc/constants.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Appliction());
}

class Appliction extends StatefulWidget {
  Appliction({Key? key}) : super(key: key);

  @override
  State<Appliction> createState() => _ApplictionState();
}

class _ApplictionState extends State<Appliction> {
  var inputUser = '';
  var result = '';
  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              flex: 30,
              child: Container(
                color: backgroundGreyDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        inputUser,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: textGreen,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        result,
                        style: TextStyle(
                          fontSize: 63,
                          color: textGrey,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 70,
              child: Container(
                color: backgroundGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getRow('ac', 'ce', '%', '/'),
                    getRow('7', '8', '9', '*'),
                    getRow('4', '5', '6', '-'),
                    getRow('1', '2', '3', '+'),
                    getRow('00', '0', '.', '='),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgrandcolor(text1),
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text1,
              style: TextStyle(fontSize: 26, color: getTextColor(text1)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgrandcolor(text2),
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text2,
              style: TextStyle(fontSize: 26, color: getTextColor(text2)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgrandcolor(text3),
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text3,
              style: TextStyle(fontSize: 26, color: getTextColor(text3)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: getBackgrandcolor(text4),
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text4,
              style: TextStyle(fontSize: 26, color: getTextColor(text4)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  bool isOperator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '=', '+'];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackgrandcolor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getTextColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
