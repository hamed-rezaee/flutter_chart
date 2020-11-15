import 'package:flutter/material.dart';

import 'package:flutter_chart/bar.dart';
import 'package:flutter_chart/data/symbol_information.dart';

class StockVolumePainter extends CustomPainter {
  StockVolumePainter({
    @required this.symbolInformations,
    this.gainColor = Colors.green,
    this.lossColor = Colors.red,
  })  : _gainPaint = Paint()..color = gainColor,
        _lossPaint = Paint()..color = lossColor;

  final List<SymbolInformation> symbolInformations;
  final Color gainColor;
  final Color lossColor;
  final Paint _gainPaint;
  final Paint _lossPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (symbolInformations == null || symbolInformations.isEmpty) {
      return;
    }

    final List<Bar> bars = _generateBars(
      data: symbolInformations,
      availableSpace: size,
    );

    for (final Bar bar in bars) {
      canvas.drawRect(
        Rect.fromLTWH(
          bar.center - bar.width / 2,
          size.height - bar.height,
          bar.width,
          bar.height,
        ),
        bar.paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  List<Bar> _generateBars({
    @required List<SymbolInformation> data,
    @required Size availableSpace,
  }) {
    final double pixelsPerTimeWindow = availableSpace.width / (data.length + 1);
    final double pixelsPerStockOrder =
        availableSpace.height / SymbolInformation.getMaxValume(data);

    final List<Bar> bars = <Bar>[];

    for (int i = 0; i < data.length; i++) {
      bars.add(
        Bar(
          center: (i + 1) * pixelsPerTimeWindow,
          height: data[i].volume * pixelsPerStockOrder,
          width: 2,
          paint: SymbolInformation.isGain(data[i]) ? _gainPaint : _lossPaint,
        ),
      );
    }

    return bars;
  }
}
