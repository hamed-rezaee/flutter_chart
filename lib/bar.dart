import 'package:flutter/material.dart';

class Bar {
  Bar({
    @required this.center,
    @required this.height,
    @required this.width,
    @required this.paint,
  });

  final double center;
  final double height;
  final double width;
  final Paint paint;
}
