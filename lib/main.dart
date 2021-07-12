import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

import 'models/calc_button.dart';
import 'widgets/theme_mode_switch.dart';
import 'widgets/display_result.dart';
import 'themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: null,
        stream: setTheme.stream,
        builder: (context, isLightMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Basic Calculator',
            theme: lightThemeData,
            darkTheme: darkThemeData,
            home: CalculatorScreen(),
            themeMode: isLightMode.data == null
                ? ThemeMode.system
                : isLightMode.data
                    ? ThemeMode.light
                    : ThemeMode.dark,
          );
        });
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({
    Key key,
  }) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var answer = '0';
  var userInput = '0';

  // Builder for Calculator Keypad
  Container buildCalcKeypad({
    MediaQueryData mediaQuery,
    ThemeData themeData,
    List<CalcButton> jenisButton,
  }) {
    return Container(
      alignment: Alignment.center,
      height: mediaQuery.size.height * 0.62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: themeData.primaryColor,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return GridView.builder(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: constraints.maxHeight * 0.05,
            mainAxisSpacing: constraints.maxWidth * 0.05,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: themeData.primaryColor,
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                if (index == 0) {
                  setState(() {
                    userInput = '0';
                    answer = '0';
                  });
                } else if (index == 2) {
                  setState(() {
                    if (userInput != '0') {
                      answer = (double.parse(userInput) / 100).toString();
                      userInput += jenisButton[index].textSymbol;
                      userInput = answer;
                    }
                  });
                } else if (index == 16) {
                  setState(() {
                    if (userInput.length != 1)
                      userInput = userInput.substring(0, userInput.length - 1);
                  });
                } else if (index == 19) {
                  setState(() {
                    equalPressed();
                    if (double.parse(answer) % 1 == 0) {
                      answer = double.parse(answer).toStringAsFixed(0);
                    }
                    userInput = answer;
                  });
                } else {
                  if (index == 1) {
                    setState(() {
                      if (userInput == '0') {
                      } else if (userInput != '0' &&
                          !userInput.startsWith('-')) {
                        List placeHolder = userInput.split('');
                        placeHolder.insert(0, '-');
                        userInput = placeHolder.join('');
                      } else if (userInput.length != 1 &&
                          userInput.startsWith('-')) {
                        List placeHolder = userInput.split('');
                        placeHolder.remove('-');
                        userInput = placeHolder.join('');
                      }
                    });
                  } else {
                    setState(() {
                      if (userInput == '0')
                        userInput = jenisButton[index].textSymbol;
                      else
                        userInput += jenisButton[index].textSymbol;
                    });
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: themeData.primaryColorDark.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: FittedBox(child: jenisButton[index].symbol),
              ),
            );
          },
          itemCount: jenisButton.length,
        );
      }),
    );
  }

  // Method for checking if the userInput is an operator
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  // Method for checking if the user pressed the = button
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final List<CalcButton> jenisButton = [
      CalcButton(
        symbol: Text(
          'AC',
          style: themeData.textTheme.bodyText1
              .copyWith(color: Colors.teal.shade200),
        ),
        textSymbol: 'AC',
      ),
      CalcButton(
        symbol: Text(
          '+/-',
          style: themeData.textTheme.bodyText1
              .copyWith(color: Colors.teal.shade200),
        ),
        textSymbol: '+/-',
      ),
      CalcButton(
        symbol: Text(
          '%',
          style: themeData.textTheme.bodyText1
              .copyWith(color: Colors.teal.shade200),
        ),
        textSymbol: '%',
      ),
      CalcButton(
        symbol: Text(
          '/',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: '/',
      ),
      CalcButton(
        symbol: Text(
          '7',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '7',
      ),
      CalcButton(
        symbol: Text(
          '8',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '8',
      ),
      CalcButton(
        symbol: Text(
          '9',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '9',
      ),
      CalcButton(
        symbol: Text(
          'x',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: 'x',
      ),
      CalcButton(
        symbol: Text(
          '4',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '4',
      ),
      CalcButton(
        symbol: Text(
          '5',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '5',
      ),
      CalcButton(
        symbol: Text(
          '6',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '6',
      ),
      CalcButton(
        symbol: Text(
          '+',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: '+',
      ),
      CalcButton(
        symbol: Text(
          '1',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '1',
      ),
      CalcButton(
        symbol: Text(
          '2',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '2',
      ),
      CalcButton(
        symbol: Text(
          '3',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '3',
      ),
      CalcButton(
        symbol: Text(
          '-',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: '-',
      ),
      CalcButton(
        symbol: Icon(
          Icons.rotate_left,
          size: 32,
          color: themeData.textTheme.bodyText1.color,
        ),
      ),
      CalcButton(
        symbol: Text(
          '0',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '0',
      ),
      CalcButton(
        symbol: Text(
          '.',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '.',
      ),
      CalcButton(
        symbol: Text(
          '=',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: '=',
      ),
    ];

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: mediaQuery.size.height * 0.01),
          ThemeModeSwitch(
            mediaQuery: mediaQuery,
            themeData: themeData,
          ),
          Spacer(),

          //Displays equations
          DisplayResult(
            mediaQuery: mediaQuery,
            text: userInput,
            themeData: themeData,
            heightConstant: 0.05,
            padding: 30,
          ),

          //Displays Result
          DisplayResult(
            mediaQuery: mediaQuery,
            text: answer,
            themeData: themeData,
            heightConstant: 0.15,
            padding: 20,
          ),

          SizedBox(height: mediaQuery.size.height * 0.01),

          //Calculator Keypad
          buildCalcKeypad(
            mediaQuery: mediaQuery,
            themeData: themeData,
            jenisButton: jenisButton,
          ),
        ],
      ),
    );
  }
}
