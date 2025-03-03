import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operation = "";

  void _buttonPressed(String text) {
    setState(() {
      if (text == "C") {
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _num2 = 0;
        _operation = "";
      } else if (text == "+" || text == "-" || text == "x" || text == "/") {
        _num1 = double.parse(_currentInput);
        _operation = text;
        _currentInput = "";
      } else if (text == "=") {
        _num2 = double.parse(_currentInput);
        if (_operation == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operation == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operation == "x") {
          _output = (_num1 * _num2).toString();
        } else if (_operation == "/") {
          _output = (_num1 / _num2).toString();
        }
        _currentInput = _output;
        _num1 = 0;
        _num2 = 0;
        _operation = "";
      } else {
        _currentInput += text;
        _output = _currentInput;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _output,
            style: TextStyle(fontSize: 32),
          ),
          Text(
            _currentInput,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Wrap(
            children: <Widget>[
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/"),
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("x"),
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-"),
              _buildButton("C"),
              _buildButton("0"),
              _buildButton("="),
              _buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        onPressed: () => _buttonPressed(text),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

