import 'package:calculator/buttons.dart';
// import 'package:calculator/homepage.dart';
import 'package:flutter/material.dart';
import "package:math_expressions/math_expressions.dart";
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = "";
  var userAnswer = "";

  List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    ",",
    "0",
    "√",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.5, // Set height of the container to half of the screen height
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(13),
                    child: Text(
                      userQuestion,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(13),
                    child: Text(
                      userAnswer,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                child: Center(
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return MyButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                buttonText: "C",
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion = "";
                                    userAnswer="";
                                  });
                                });
                          } else if (index == 1) {
                            return MyButton(
                                color: Colors.red,
                                textColor: Colors.white,
                                buttonText: "DEL",
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion = userQuestion.substring(
                                        0, userQuestion.length - 1);
                                  });
                                });
                          } else if(index==buttons.length-1){
                            return MyButton(
                                color: Colors.deepPurple,
                                textColor: Colors.white,
                                buttonText: "=",
                                buttonTapped: () {
                                  setState(() {
                                    calculate();
                                    userQuestion="";
                                  });
                                });
                          }
                          
                          return MyButton(
                              color: isOperator(buttons[index])
                                  ? Colors.deepPurple
                                  : Colors.white,
                              textColor: !isOperator(buttons[index])
                                  ? Colors.deepPurple
                                  : Colors.white,
                              buttonText: buttons[index],
                              buttonTapped: () {
                                setState(() {
                                  userQuestion += buttons[index];
                                });
                              });
                        }))),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "x" ||
        x == "%" ||
        x == "+" ||
        x == "-" ||
        x == "/" ||
        x == "=" ||
        x == "√") {
      return true;
    }
    return false;
  }
  void calculate() {
  String calculation = userQuestion;
  calculation =calculation.replaceAll("x","*");
  calculation =calculation.replaceAll("√","sqrt");
  Parser p = Parser();
  Expression exp = p.parse(calculation);

  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);

  userAnswer = eval.toString();
}

}
