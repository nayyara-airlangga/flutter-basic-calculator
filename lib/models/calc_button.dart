import 'package:flutter/material.dart';

class CalcButton {
  Widget symbol;
  String textSymbol;
  Function handler;

  CalcButton({
    this.symbol,
    this.handler,
    this.textSymbol,
  });
}
