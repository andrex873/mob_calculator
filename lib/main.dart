import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeCalculator(),
    );
  }
}

class HomeCalculator extends StatefulWidget {
  @override
  _HomeCalculatorState createState() => _HomeCalculatorState();
}

class _HomeCalculatorState extends State<HomeCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";

  handleButtonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          equation = '0';
          result = '0';
          break;
        case 'DEL':
          if (equation.length == 1) {
            equation = '0';
          } else {
            equation = equation.substring(0, equation.length - 1);
          }
          break;
        case '=':
          expression = equation;
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (ex) {
            result = 'Error';
          }
          break;
        default:
          if (equation == '0') {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
      }
    });
  }

  Widget buildButton(String buttonText, double height, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * height,
      color: color,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => handleButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: 38.0),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: 48.0),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', 1, Colors.orangeAccent),
                        buildButton('DEL', 1, Colors.orangeAccent),
                        buildButton('/', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, Colors.black54),
                        buildButton('8', 1, Colors.black54),
                        buildButton('9', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1, Colors.black54),
                        buildButton('5', 1, Colors.black54),
                        buildButton('6', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1, Colors.black54),
                        buildButton('2', 1, Colors.black54),
                        buildButton('3', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.black54),
                        buildButton('0', 1, Colors.black54),
                        buildButton('00', 1, Colors.black54),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [buildButton('*', 1, Colors.blue)]),
                    TableRow(children: [buildButton('-', 1, Colors.blue)]),
                    TableRow(children: [buildButton('+', 1, Colors.blue)]),
                    TableRow(children: [buildButton('=', 2, Colors.purple)]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
