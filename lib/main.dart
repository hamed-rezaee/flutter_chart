import 'package:flutter/material.dart';

import 'package:flutter_chart/data/symbol_information.dart';
import 'package:flutter_chart/stock_volume_painter.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(title: 'Flutter Chart Home Page'),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 160,
              color: Colors.black,
            ),
            const SizedBox(height: 6),
            Container(
              height: 45,
              color: Colors.black,
              child: FutureBuilder<List<SymbolInformation>>(
                future: SymbolInformation.getInformationFromAsset(
                  context: context,
                  fileName: 'query_daily.json',
                ),
                initialData: const <SymbolInformation>[],
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<SymbolInformation>> snapshot,
                ) =>
                    CustomPaint(
                  size: Size.infinite,
                  painter: StockVolumePainter(symbolInformations: snapshot.data),
                ),
              ),
            ),
          ],
        ),
      );
}
