import 'dart:async';

import 'package:flutter/material.dart';

StreamController<bool> setTheme = StreamController();

class ThemeModeSwitch extends StatelessWidget {
  const ThemeModeSwitch({
    Key key,
    @required this.mediaQuery,
    @required this.themeData,
  }) : super(key: key);

  final MediaQueryData mediaQuery;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
