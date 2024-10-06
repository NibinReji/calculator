import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "";
  double _firstValue = 0;
  String _operator = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "";
        _firstValue = 0;
        _operator = "";
      } else if (value == "=") {
        _calculateResult();
      } else if (value == "+" || value == "-" || value == "*" || value == "/" || value == "%") {
        if (_output.isNotEmpty) {
          _firstValue = double.parse(_output);
          _operator = value;
          _output = "";
        }
      } else {
        _output += value;
      }
    });
  }

  void _calculateResult() {
    if (_output.isNotEmpty) {
      double secondValue = double.parse(_output);
      double result;

      switch (_operator) {
        case "+":
          result = _firstValue + secondValue;
          break;
        case "-":
          result = _firstValue - secondValue;
          break;
        case "*":
          result = _firstValue * secondValue;
          break;
        case "/":
          result = _firstValue / secondValue;
          break;
        case "%":
          result = (_firstValue * secondValue) / 100;
          break;
        default:
          return;
      }

      setState(() {
        _output = result.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("7"), _buildButton("8"), _buildButton("9"), _buildButton("/")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("4"), _buildButton("5"), _buildButton("6"), _buildButton("*")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("1"), _buildButton("2"), _buildButton("3"), _buildButton("-")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("C"), _buildButton("0"), _buildButton("="), _buildButton("+")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("%"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0), // Adjust this value if needed
        child: ElevatedButton(
          onPressed: () => _buttonPressed(value),
          child: Text(value, style: TextStyle(fontSize: 24)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20), // Remove horizontal padding
          ),
        ),
      ),
    );
  }
}
