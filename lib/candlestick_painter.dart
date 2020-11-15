import 'package:flutter/material.dart';

import 'package:flutter_chart/data/candlestick.dart';
import 'package:flutter_chart/data/symbol_information.dart';

class CandlestickPainter extends CustomPainter {
  CandlestickPainter({
    @required this.symbolInformations,
    this.wickColor = Colors.grey,
    this.gainColor = Colors.green,
    this.lossColor = Colors.red,
  })  : _wickPaint = Paint()..color = wickColor,
        _gainPaint = Paint()..color = gainColor,
        _lossPaint = Paint()..color = lossColor;
  static const double _wickWidth = 1;
  static const double _candleWidth = 3;

  final List<SymbolInformation> symbolInformations;
  final Color wickColor;
  final Color gainColor;
  final Color lossColor;
  final Paint _wickPaint;
  final Paint _gainPaint;
  final Paint _lossPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (symbolInformations == null || symbolInformations.isEmpty) {
      return;
    }

    final List<Candlestick> candlesticks = _generateCandlesticks(
      data: symbolInformations,
      availableSpace: size,
    );

    for (final Candlestick candlestick in candlesticks) {
      canvas
        ..drawRect(
          Rect.fromLTRB(
            candlestick.center - _wickWidth / 2,
            size.height - candlestick.wickHigh,
            candlestick.center + _wickWidth / 2,
            size.height - candlestick.wickLow,
          ),
          _wickPaint,
        )
        ..drawRect(
          Rect.fromLTRB(
            candlestick.center - _candleWidth / 2,
            size.height - candlestick.candleOpen,
            candlestick.center + _candleWidth / 2,
            size.height - candlestick.candleClose,
          ),
          candlestick.paint,
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  List<Candlestick> _generateCandlesticks({
    @required List<SymbolInformation> data,
    @required Size availableSpace,
  }) {
    final double lowestValue = SymbolInformation.getLowestValue(data);
    final double highestValue = SymbolInformation.getHighestValue(data);
    final double pixelsPerTimeWindow = availableSpace.width / (data.length + 1);
    final double pixelsPerValue =
        availableSpace.height / (highestValue - lowestValue);

    final List<Candlestick> candlesticks = <Candlestick>[];

    for (int i = 0; i < data.length; i++) {
      candlesticks.add(
        Candlestick(
          center: (i + 1) * pixelsPerTimeWindow,
          wickHigh: (data[i].high - lowestValue) * pixelsPerValue,
          wickLow: (data[i].low - lowestValue) * pixelsPerValue,
          candleOpen: (data[i].open - lowestValue) * pixelsPerValue,
          candleClose: (data[i].close - lowestValue) * pixelsPerValue,
          paint: SymbolInformation.isGain(data[i]) ? _gainPaint : _lossPaint,
        ),
      );
    }

    return candlesticks;
  }
}
