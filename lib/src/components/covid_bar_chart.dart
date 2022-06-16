import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/covid_model.dart';
import '../utils/data_utils.dart';

class CovidBarChart extends StatelessWidget {
  final List<Covid19Model?> covidDatas;
  final double maxY;
  CovidBarChart({Key? key, required this.covidDatas, required this.maxY}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups:  covidDatas.map<BarChartGroupData>((covidData) {
          return BarChartGroupData(
            x: x++,
            barRods: [
              BarChartRodData(
                toY: covidData!.calcdecideCnt,
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          );
        }).toList(),
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY * 1.5,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: const EdgeInsets.all(0),
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff687c92),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    DateTime? time = covidDatas[value.toInt()]!.stateDt;
    var text = DataUtils.simpleDateFormat(time!);
    return Center(child: Text(text, style: style));
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  final _barsGradient = const LinearGradient(
    colors: [
      Colors.lightBlueAccent,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

}