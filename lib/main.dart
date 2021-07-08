import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/calc_button.dart';
import 'widgets/theme_mode_switch.dart';
import 'widgets/display_result.dart';
import 'widgets/calc_keypad.dart';
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
          ThemeModeSwitch(
            mediaQuery: mediaQuery,
            themeData: themeData,
          ),
          Spacer(),
          DisplayResult(
            mediaQuery: mediaQuery,
            text: text,
            themeData: themeData,
          ),
          SizedBox(height: mediaQuery.size.height * 0.01),
          CalcKeypad(
            mediaQuery: mediaQuery,
            themeData: themeData,
            jenisButton: jenisButton,
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
