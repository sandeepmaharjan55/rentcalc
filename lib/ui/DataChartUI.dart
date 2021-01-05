import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// !!Step1: prepare the data to plot.
final _data1 = <double, double>{
  1: 9,
  2: 12,
  3: 10,
  4: 20,
  5: 14,
  6: 18,
  7: 9,
  8: 12,
  9: 10,
  10: 20,
  11: 14,
  12: 18
};
// final _data2 = <double, double>{1: 8, 2: 15, 3: 17, 4: 11, 5: 13, 6: 20};

class DataChartUI extends StatefulWidget {
  const DataChartUI({Key key}) : super(key: key);

  @override
  _DataChartUIState createState() => _DataChartUIState();
}

class _DataChartUIState extends State<DataChartUI> {
  bool _showBorder = true;
  bool _showGrid = false;

  @override
  Widget build(BuildContext context) {
    /// !!Step2: convert data into barGroups.
    final barGroups = <BarChartGroupData>[
      for (final entry in _data1.entries)
        BarChartGroupData(
          x: entry.key.toInt(),
          barRods: [
            BarChartRodData(y: entry.value, colors: [Colors.blue]),
            // BarChartRodData(y: _data2[entry.key], colors: [Colors.red]),
          ],
        ),
    ];

    /// !!Step3: prepare barChartData
    final barChartData = BarChartData(
      maxY: 20,
      // ! The data to show
      barGroups: barGroups,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
        ),
      ),
      // ! Borders:
      borderData: FlBorderData(show: _showBorder),
      // ! Grid behavior:
      gridData: FlGridData(show: _showGrid),
      // ! Axis title
      axisTitleData: FlAxisTitleData(
        show: true,
        bottomTitle: AxisTitle(titleText: 'Month', showTitle: true),
        leftTitle: AxisTitle(titleText: 'Expenditure', showTitle: true),
      ),
      // ! Ticks in the axis
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true, // this is false by-default.
          // ! Decides how to show bottom titles,
          // here we convert double to month names
          getTitles: (double val) =>
              DateFormat.MMM().format(DateTime(2020, val.toInt())),
        ),
        leftTitles: SideTitles(
          showTitles: true,
          // ! Decides how to show left titles,
          // here we skip some values by returning ''.
          getTitles: (double val) {
            if (val.toInt() % 5 != 0) return '';
            return '${val.toInt()}';
          },
        ),
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Rent Management:Input"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(height: 200.0),
          child: BarChart(barChartData),
        ),
      ),
      bottomNavigationBar: _buildControlWidgets(),
    );
  }

  Widget _buildControlWidgets() {
    return Container(
      height: 200,
      // width: 500,
      color: Colors.grey[200],
      child: ListView(
        children: [
          SwitchListTile(
            title: const Text('ShowBorder'),
            onChanged: (bool val) => setState(() => this._showBorder = val),
            value: this._showBorder,
          ),
          SwitchListTile(
            title: const Text('ShowGrid'),
            onChanged: (bool val) => setState(() => this._showGrid = val),
            value: this._showGrid,
          ),
        ],
      ),
    );
  }
}
