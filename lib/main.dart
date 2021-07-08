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
  var answer = '';
  var userInput = '';

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
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '+/-',
          style: themeData.textTheme.bodyText1
              .copyWith(color: Colors.teal.shade200),
        ),
        textSymbol: '+/-',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '%',
          style: themeData.textTheme.bodyText1
              .copyWith(color: Colors.teal.shade200),
        ),
        textSymbol: '%',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '/',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: '/',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '7',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '7',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '8',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '8',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '9',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '9',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          'x',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: 'x',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '4',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '4',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '5',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '5',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '6',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '6',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '+',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: '+',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '1',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '1',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '2',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '2',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '3',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '3',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '-',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: '-',
        handler: () {},
      ),
      CalcButton(
          symbol: Icon(
            Icons.rotate_left,
            size: 32,
            color: themeData.textTheme.bodyText1.color,
          ),
          handler: () {}),
      CalcButton(
        symbol: Text(
          '0',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '0',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '.',
          style: themeData.textTheme.bodyText1,
        ),
        textSymbol: '.',
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '=',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        textSymbol: '=',
        handler: () {},
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
            widthConstant: 1,
            padding: 40,
          ),

          //Displays Result
          DisplayResult(
            mediaQuery: mediaQuery,
            text: answer,
            themeData: themeData,
            heightConstant: 0.15,
            widthConstant: 1,
            padding: 20,
          ),

          SizedBox(height: mediaQuery.size.height * 0.01),

          //Calculator Keypad
          Container(
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
                          userInput = '';
                          answer = '0';
                        });
                      } else if (index == 2) {
                        setState(() {
                          answer = (double.parse(userInput) / 100).toString();
                          userInput += jenisButton[index].textSymbol;
                          userInput = answer;
                        });
                      } else if (index == 16) {
                        setState(() {
                          if (userInput.isNotEmpty)
                            userInput =
                                userInput.substring(0, userInput.length - 1);
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
                            userInput += '-';
                          });
                        } else {
                          setState(() {
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
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');
    // finaluserinput = userInput.replaceAll('+/-', '-');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
