import 'package:flutter/material.dart';

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
   createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0";
  String _operation = "";
  double _num1 = 0.0;
  double _num2 = 0.0;

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _clear();
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "x") {
      _setOperation(buttonText);
    } else if (buttonText == ".") {
      _appendDecimal();
    } else if (buttonText == "=") {
      _calculateResult();
    } else {
      _appendNumber(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = "0";
      _num1 = 0.0;
      _num2 = 0.0;
      _operation = "";
    });
  }

  void _setOperation(String operation) {
    setState(() {
      _num1 = double.parse(_output);
      _operation = operation;
      _output = "0";
    });
  }

  void _appendDecimal() {
    if (!_output.contains(".")) {
      setState(() {
        _output = "$_output.";
      });
    }
  }

  void _calculateResult() {
    _num2 = double.parse(_output);
    String result;
    if (_operation == "+") {
      result = (_num1 + _num2).toString();
    } else if (_operation == "-") {
      result = (_num1 - _num2).toString();
    } else if (_operation == "x") {
      result = (_num1 * _num2).toString();
    } else if (_operation == "/") {
      result = (_num1 / _num2).toString();
    } else {
      return;
    }

    setState(() {
      _output = _formatResult(result);
      _operation = "";
      _num1 = 0.0;
      _num2 = 0.0;
    });
  }

  void _appendNumber(String number) {
    setState(() {
      if (_output == "0") {
        _output = number;
      } else {
        _output = _output + number;
      }
    });
  }

  String _formatResult(String result) {
    if (result.contains(".")) {
      result = result.replaceAll(RegExp(r"0*$"), ""); // Remove trailing zeros
      if (result.endsWith(".")) {
        result = result.substring(0, result.length - 1); // Remove trailing decimal point
      }
    }
    return result;
  }

  Widget buildButton(String buttonText, double buttonHeight) {
    return Expanded(
      child: SizedBox(
        height: buttonHeight,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(backgroundColor: Colors.yellow),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var width = mediaQuery.size.width;
    var isPortrait = mediaQuery.orientation == Orientation.portrait;

    var buttonHeight = isPortrait ? height * 0.1 : height * 0.2;
    var outputFontSize = isPortrait ? height * 0.10 : width * 0.08;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Calculator',style: TextStyle(
            fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 95,
              horizontal: 10,
            ),
            child: Text(
              _output,
              style: TextStyle(
                fontSize: outputFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7", buttonHeight),
                  buildButton("8", buttonHeight),
                  buildButton("9", buttonHeight),
                  buildButton("/", buttonHeight)
                ],
              ),
              Row(
                children: [
                  buildButton("4", buttonHeight),
                  buildButton("5", buttonHeight),
                  buildButton("6", buttonHeight),
                  buildButton("x", buttonHeight)
                ],
              ),
              Row(
                children: [
                  buildButton("1", buttonHeight),
                  buildButton("2", buttonHeight),
                  buildButton("3", buttonHeight),
                  buildButton("-", buttonHeight)
                ],
              ),
              Row(
                children: [
                  buildButton(".", buttonHeight),
                  buildButton("0", buttonHeight),
                  buildButton("00", buttonHeight),
                  buildButton("+", buttonHeight)
                ],
              ),
              Row(
                children: [
                  buildButton("CLEAR", buttonHeight),
                  buildButton("=", buttonHeight),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
