import 'package:flutter/material.dart';

class DisplayResult extends StatelessWidget {
  const DisplayResult({
    Key key,
    @required this.mediaQuery,
    @required this.text,
    @required this.themeData,
  }) : super(key: key);

  final MediaQueryData mediaQuery;
  final text;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      height: mediaQuery.size.height * 0.15,
      width: mediaQuery.size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            child: FittedBox(
              child: Text(
                '$text',
                style: themeData.textTheme.bodyText1.copyWith(fontSize: 80),
              ),
            ),
          );
        }),
      ),
    );
  }
}
