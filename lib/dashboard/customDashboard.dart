import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class customDashboardTwo extends StatefulWidget {
  const customDashboardTwo({Key? key}) : super(key: key);

  @override
  State<customDashboardTwo> createState() => _customDashboardTwoState();
}

class _customDashboardTwoState extends State<customDashboardTwo> {
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

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData = <_ChartData>[
      _ChartData(2005, 21, 28),
      _ChartData(2006, 24, 44),
      _ChartData(2007, 36, 48),
      _ChartData(2008, 38, 50),
      _ChartData(2009, 54, 66),
      _ChartData(2010, 57, 78),
      _ChartData(2011, 70, 84)
    ];
    super.initState();
  }

  List<_ChartData>? chartData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SafeArea(
          child: Row(
            children: [
              SizedBox(
                width: 400,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  title:
                      ChartTitle(text: 'Top Two Countries sales 2005 and 2011'),
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll),
                  primaryXAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 2,
                      majorGridLines: const MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(
                      labelFormat: '{value}%',
                      axisLine: const AxisLine(width: 0),
                      majorTickLines:
                          const MajorTickLines(color: Colors.transparent)),
                  series: _getDefaultLineSeries(),
                  tooltipBehavior: TooltipBehavior(enable: true),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Germany',
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'England',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true)),
      // LineSeries<_ChartData, num>(
      //     animationDuration: 2500,
      //     dataSource: chartData!,
      //     width: 2,
      //     name: 'Uzbekistan',
      //     xValueMapper: (_ChartData sales, _) => sales.x,
      //     yValueMapper: (_ChartData sales, _) => sales.y2,
      //     markerSettings: const MarkerSettings(isVisible: true)),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}
