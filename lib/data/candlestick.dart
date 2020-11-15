import 'package:flutter/material.dart';

class Candlestick {
  Candlestick({
    @required this.center,
    @required this.wickHigh,
    @required this.wickLow,
    @required this.candleOpen,
    @required this.candleClose,
    @required this.paint,
  });

  final double center;
  final double wickHigh;
  final double wickLow;
  final double candleOpen;
  final double candleClose;
  final Paint paint;
}
