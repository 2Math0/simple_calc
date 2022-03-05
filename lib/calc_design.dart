import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calc/constants.dart';
import 'model/buttons_grid.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";

  void buttonPressed(buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '';
        result = '0';
      } else if (buttonText == '<') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == "=") {
        equation = equation.replaceAll('x', '*');
        expression = equation;
        try {
          Expression exp = Parser().parse(expression);
          result = '${exp.evaluate(EvaluationType.REAL, ContextModel())}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
  GestureDetector buildButton(Size size, String buttonText,
      {Color txtColor = Colors.black,
        double buttonSize = 1.0,
        double fontSize = 24.0,
        Color bgColor = kLightGrey}) {
    return GestureDetector(
      onTap: (()=> buttonPressed(buttonText)),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8),
        height: size.height * 0.1 * buttonSize,
        child: Text(
          buttonText,
          style: TextStyle(
            color: txtColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: bgColor,
              offset: const Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: kEquationPadding,
                alignment: Alignment.centerRight,
                child: Text(
                  equation,
                  style: const TextStyle(fontSize: 36.0),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: kEquationPadding,
                alignment: Alignment.centerRight,
                child: Text(
                  double.parse(result)%1 != 0 ? result : '${double.parse(result).round()}',
                  style: const TextStyle(fontSize: 48.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.71,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            buildButton(size, 'C',
                                fontSize: 36.0,
                                bgColor: Colors.lightBlue,
                                txtColor: Colors.white),
                            buildButton(
                              size,
                              '<',
                              bgColor: Colors.yellow,
                            ),
                            buildButton(
                              size,
                              '/',
                              bgColor: Colors.yellow,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton(size, '7'),
                            buildButton(size, '8'),
                            buildButton(size, '9'),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton(size, '4'),
                            buildButton(size, '5'),
                            buildButton(size, '6'),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton(size, '1'),
                            buildButton(size, '2'),
                            buildButton(size, '3'),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton(size, '.'),
                            buildButton(size, '0'),
                            buildButton(size, '100'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.25,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            buildButton(
                              size,
                              'x',
                              bgColor: Colors.yellow,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton(
                              size,
                              '-',
                              bgColor: Colors.yellow,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton(
                              size,
                              '+',
                              bgColor: Colors.yellow,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildButton(size, '=',
                                buttonSize: 2.0,
                                fontSize: 36.0,
                                bgColor: Colors.lightBlue,
                                txtColor: Colors.white),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
