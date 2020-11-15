import 'dart:convert';

import 'package:flutter/material.dart';

class SymbolInformation {
  SymbolInformation({
    @required this.date,
    @required this.open,
    @required this.high,
    @required this.low,
    @required this.close,
    @required this.volume,
  });

  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  static Future<List<SymbolInformation>> getInformationFromAsset({
    @required BuildContext context,
    @required String fileName,
  }) async {
    final String data = await DefaultAssetBundle.of(context)
        .loadString('assets/stock_data/$fileName');
    final Map<String, dynamic> decodedData = json.decode(data);

    final List<SymbolInformation> informations = <SymbolInformation>[];

    for (final MapEntry<String, dynamic> entry in decodedData.entries) {
      informations.add(
        SymbolInformation(
          date: DateTime.parse(entry.key),
          open: double.parse(entry.value['open']),
          high: double.parse(entry.value['high']),
          low: double.parse(entry.value['low']),
          close: double.parse(entry.value['close']),
          volume: int.parse(entry.value['volume']),
        ),
      );
    }

    return informations;
  }

  static int getMaxValume(List<SymbolInformation> symbolInformations) =>
      symbolInformations
          .fold(
              symbolInformations.first,
              (SymbolInformation previous, SymbolInformation current) =>
                  current.volume > previous.volume ? current : previous)
          .volume;

  static bool isGain(SymbolInformation symbolInformation) =>
      symbolInformation.close >= symbolInformation.open;
}
