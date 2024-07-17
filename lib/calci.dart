import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calci extends StatefulWidget {
  const Calci({super.key});

  @override
  State<Calci> createState() => _CalciState();
}

class _CalciState extends State<Calci> {
  String output = "";
  String expression = "";

  void _show(String val) {
    setState(() {
      if (val == "AC") {
        output = "";
        expression = "";
      } else if (val == "Del") {
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
      } else if (val == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression.replaceAll('X', '*'));
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          output = eval.toString();
        } catch (e) {
          output = "Error";
        }
      } else {
        expression += val;
      }
    });
  }

  Widget numButton(String val, {Color color = Colors.black}) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _show(val),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        child: Text(
          val,
          style: TextStyle(fontSize: 24, color: color),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(expression, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(output, style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      numButton("AC", color: Colors.orange),
                      numButton("(", color: Colors.orange),
                      numButton(")", color: Colors.orange),
                      numButton("%", color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      numButton("7"),
                      numButton("8"),
                      numButton("9"),
                      numButton("/", color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      numButton("4"),
                      numButton("5"),
                      numButton("6"),
                      numButton("X", color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      numButton("1"),
                      numButton("2"),
                      numButton("3"),
                      numButton("-", color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      numButton("0"),
                      numButton("."),
                      numButton("00"),
                      numButton("+", color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      numButton("Del", color: Colors.red),
                      numButton("=", color: Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


