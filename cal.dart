class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String result = "";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        result = "";
      } else if (value == "=") {
        try {
          result = _evaluateExpression(input);
        } catch (e) {
          result = "Error";
        }
      } else {
        input += value;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      return (double.parse(expression).toString());
    } catch (e) {
      return "Error";
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
            result,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Wrap(
            children: [
              "7", "8", "9", "/",
              "4", "5", "6", "*",
              "1", "2", "3", "-",
              "C", "0", "=", "+"
            ].map((text) {
              return SizedBox(
                width: 75,
                height: 75,
                child: ElevatedButton(
                  onPressed: () => onButtonPressed(text),
                  child: Text(text, style: TextStyle(fontSize: 24)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
