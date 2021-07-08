import 'package:flutter/material.dart';

class DisplayResult extends StatelessWidget {
  const DisplayResult(
      {Key key,
      @required this.mediaQuery,
      @required this.text,
      @required this.themeData,
      @required this.heightConstant,
      @required this.widthConstant,
      this.padding})
      : super(key: key);

  final MediaQueryData mediaQuery;
  final double heightConstant;
  final double widthConstant;
  final text;
  final double padding;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      height: mediaQuery.size.height * heightConstant,
      width: mediaQuery.size.width * widthConstant,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
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
