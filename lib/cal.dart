import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String output = '';

  void onButtonClick(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        output = '';
      } else if (value == '=') {
        try {
          output = evaluateExpression(input).toString();
        } catch (e) {
          output = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  double evaluateExpression(String expression) {
    // Basic expression evaluation (use a proper parser for complex cases)
    try {
      return double.parse(expression);
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            input,
            style: TextStyle(fontSize: 32),
          ),
          Text(
            output,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              '7', '8', '9', 'C',
              '4', '5', '6', '/',
              '1', '2', '3', '*',
              '0', '.', '=', '+',
            ].map((value) {
              return ElevatedButton(
                onPressed: () => onButtonClick(value),
                child: Text(value, style: TextStyle(fontSize: 24)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

