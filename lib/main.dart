import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'models/calc_button.dart';

StreamController<bool> setTheme = StreamController();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: null,
        stream: setTheme.stream,
        builder: (context, isLightMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Basic Calculator',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.grey.shade200,
              backgroundColor: Colors.grey[700],
              primaryColorLight: Colors.black,
              primaryColorDark: Colors.grey.withOpacity(0.1),
              accentColor: Colors.grey.withOpacity(0.7),
              splashColor: Colors.black,
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              backgroundColor: Colors.black54,
              primaryColor: Colors.grey.withOpacity(0.2),
              primaryColorLight: Colors.grey.withOpacity(0.6),
              primaryColorDark: Colors.grey.withOpacity(0.1),
              accentColor: Colors.white,
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
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
        handler: () {
          calculation('AC');
        },
      ),
      CalcButton(
        symbol: Text(
          '+/-',
          style: themeData.textTheme.bodyText1
              .copyWith(color: Colors.teal.shade200),
        ),
        handler: () {
          calculation('+/-');
        },
      ),
      CalcButton(
        symbol: Text(
          '%',
          style: themeData.textTheme.bodyText1
              .copyWith(color: Colors.teal.shade200),
        ),
        handler: () {
          calculation('%');
        },
      ),
      CalcButton(
        symbol: Text(
          '/',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        handler: () {
          calculation('/');
        },
      ),
      CalcButton(
        symbol: Text(
          '1',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('1');
        },
      ),
      CalcButton(
        symbol: Text(
          '2',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('2');
        },
      ),
      CalcButton(
        symbol: Text(
          '3',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('3');
        },
      ),
      CalcButton(
        symbol: Text(
          'x',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        handler: () {
          calculation('x');
        },
      ),
      CalcButton(
        symbol: Text(
          '4',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('4');
        },
      ),
      CalcButton(
        symbol: Text(
          '5',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('5');
        },
      ),
      CalcButton(
        symbol: Text(
          '6',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('6');
        },
      ),
      CalcButton(
        symbol: Text(
          '+',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        handler: () {
          calculation('+');
        },
      ),
      CalcButton(
        symbol: Text(
          '7',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('7');
        },
      ),
      CalcButton(
        symbol: Text(
          '8',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('8');
        },
      ),
      CalcButton(
        symbol: Text(
          '9',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('9');
        },
      ),
      CalcButton(
        symbol: Text(
          '-',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        handler: () {
          calculation('-');
        },
      ),
      // CalcButton(
      //     symbol: Icon(
      //       Icons.rotate_left,
      //       size: 32,
      //       color: themeData.textTheme.bodyText1.color,
      //     ),
      //     handler: () {}),
      CalcButton(
        symbol: Text(
          '0',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('0');
        },
      ),
      CalcButton(
        symbol: Text(
          '.',
          style: themeData.textTheme.bodyText1,
        ),
        handler: () {
          calculation('.');
        },
      ),
      CalcButton(
        symbol: Container(),
        handler: () {},
      ),
      CalcButton(
        symbol: Text(
          '=',
          style: themeData.textTheme.bodyText1.copyWith(color: Colors.red),
        ),
        handler: () {
          calculation('=');
        },
      ),
    ];

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: mediaQuery.size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: mediaQuery.size.height * 0.06,
                width: mediaQuery.size.width * 0.25,
                decoration: BoxDecoration(
                  color: themeData.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setTheme.add(true);
                        },
                        child: FittedBox(
                          child: Icon(
                            Icons.light_mode_outlined,
                            color: themeData.primaryColorLight,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setTheme.add(false);
                        },
                        child: FittedBox(
                          child: Icon(
                            Icons.dark_mode_outlined,
                            color: themeData.accentColor,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            height: mediaQuery.size.height * 0.1,
            width: mediaQuery.size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: FittedBox(
                        child: Text(
                          '$text',
                          style: themeData.textTheme.bodyText1
                              .copyWith(fontSize: 80),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: mediaQuery.size.height * 0.55,
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
                  crossAxisSpacing: constraints.maxHeight * 0.041,
                  mainAxisSpacing: constraints.maxWidth * 0.001,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: themeData.splashColor,
                    borderRadius: BorderRadius.circular(100),
                    onTap: jenisButton[index].handler,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: index == 18
                            ? themeData.primaryColorDark.withOpacity(0)
                            : themeData.primaryColorDark,
                        shape: BoxShape.circle,
                      ),
                      child: FittedBox(child: jenisButton[index].symbol),
                    ),
                  );
                },
                itemCount: jenisButton.length,
              );
            }),
          ),
        ],
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
