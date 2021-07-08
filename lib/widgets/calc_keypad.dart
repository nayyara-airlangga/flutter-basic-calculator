import 'package:flutter/material.dart';

import '../models/calc_button.dart';

class CalcKeypad extends StatelessWidget {
  const CalcKeypad({
    Key key,
    @required this.mediaQuery,
    @required this.themeData,
    @required this.jenisButton,
  }) : super(key: key);

  final MediaQueryData mediaQuery;
  final ThemeData themeData;
  final List<CalcButton> jenisButton;

  @override
  Widget build(BuildContext context) {
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
              onTap: jenisButton[index].handler,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index == 18
                      ? themeData.primaryColorDark.withOpacity(0)
                      : themeData.primaryColorDark.withOpacity(0.1),
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
}
