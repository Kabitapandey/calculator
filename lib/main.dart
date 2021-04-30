import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Calculator",
        home: SimpleCalculator());
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  String expression = '';

  buttonPressed(String btnText) {
    setState(() {
      if (btnText == 'C') {
        equation = "0";
        result = "0";
      } else if (btnText == '⌫') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (btnText == '=') {
        expression = equation;

        expression = equation.replaceAll("÷", "/");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (error) {
          result = "Syntax error";
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Simple Calculator"),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: equationFontSize),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("C", Colors.redAccent, 0.2),
                        buildButton("⌫", Colors.blue, 0.2),
                        buildButton("÷", Colors.blue, 0.2)
                      ]),
                      TableRow(children: [
                        buildButton("7", Colors.black54, 0.2),
                        buildButton("8", Colors.black54, 0.2),
                        buildButton("9", Colors.black54, 0.2)
                      ]),
                      TableRow(children: [
                        buildButton("4", Colors.black54, 0.2),
                        buildButton("5", Colors.black54, 0.2),
                        buildButton("6", Colors.black54, 0.2)
                      ]),
                      TableRow(children: [
                        buildButton("1", Colors.black54, 0.2),
                        buildButton("2", Colors.black54, 0.2),
                        buildButton("3", Colors.black54, 0.2)
                      ]),
                      TableRow(children: [
                        buildButton(".", Colors.black54, 0.2),
                        buildButton("0", Colors.black54, 0.2),
                        buildButton("00", Colors.black54, 0.2)
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("*", Colors.blue, 0.2),
                      ]),
                      TableRow(children: [
                        buildButton("-", Colors.blue, 0.2),
                      ]),
                      TableRow(children: [
                        buildButton("+", Colors.blue, 0.2),
                      ]),
                      TableRow(children: [
                        buildButton("=", Colors.redAccent, 0.4),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget buildButton(String btnText, Color btnColor, double btnHeight) {
    return Container(
      height: MediaQuery.of(context).size.width * btnHeight,
      color: btnColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        onPressed: () => buttonPressed(btnText),
        padding: EdgeInsets.all(16.0),
        child: Text(
          "$btnText",
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }
}
