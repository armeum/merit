import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class customDashboard extends StatefulWidget {
  const customDashboard({Key? key}) : super(key: key);

  @override
  State<customDashboard> createState() => _customDashboardState();
}

class _customDashboardState extends State<customDashboard> {
  late TooltipBehavior _tooltipBehavior;
  var data = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<ChartData> chart_data = [];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    for (String d in data) {
      chart_data.add(ChartData(d, (Random().nextInt(100) * 100).round()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              // width: chart_data.length < 6 ? 400 : 700,
              width: 420,
              // height: 600,
              // height: chart_data.length < 6 ? 400 : 500,
              child: SfCartesianChart(
                title: ChartTitle(
                    text: 'Half yearly sales analysis',
                    alignment: ChartAlignment.near),
                legend: Legend(
                  isVisible: true,
                  alignment: ChartAlignment.near,
                ),
                tooltipBehavior: _tooltipBehavior,
                palette: const <Color>[
                  Colors.blue,
                  Colors.orange,
                  Colors.brown
                ],

                // backgroundColor: Theme.of(context).primaryColor,
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  // Initialize line series
                  LineSeries<ChartData, String>(
                      legendItemText: 'Sales',
                      dataSource: chart_data,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      animationDuration: 4000)
                ],
              ),
            ),
            SizedBox(
              // width: chart_data.length < 6 ? 400 : 700,
              width: 420,
              // height: 600,
              // height: chart_data.length < 6 ? 400 : 500,
              child: SfCartesianChart(
                title: ChartTitle(
                    text: 'Half yearly sales analysis',
                    alignment: ChartAlignment.near),
                legend: Legend(
                  isVisible: true,
                  alignment: ChartAlignment.near,
                ),
                tooltipBehavior: _tooltipBehavior,
                palette: const <Color>[
                  Colors.blue,
                  Colors.orange,
                  Colors.brown
                ],

                // backgroundColor: Theme.of(context).primaryColor,
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  // Initialize line series
                  LineSeries<ChartData, String>(
                      legendItemText: 'Sales',
                      dataSource: chart_data,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      animationDuration: 4000)
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final int? y;
}
