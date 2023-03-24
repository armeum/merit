import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:merit_app/utils/url.dart';
import 'dart:convert' as convert;
import 'package:collection/collection.dart';

class BarChartExample extends StatefulWidget {
  @override
  _BarChartExampleState createState() => _BarChartExampleState();
}

class _BarChartExampleState extends State<BarChartExample> {
  var orderList = [];
  List<SalesData> data = [];

  void fetchData() async {
    var response =
        await http.get(Uri.parse('$platformUrl/all_orders_for_dashboard'));
    if (response.statusCode == 200) {
      var top = json.decode(response.body)['total_sold'];
      print(top);
      for (var i = 0; i < top.length; i++) {
        data.add(SalesData(top[i]['product_type'], top[i]['total_sold']));
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bar Chart Demo'),
      ),
      body: Center(
        child: SafeArea(
          child: SfCartesianChart(
            title: ChartTitle(text: 'Top Sales Chart'),
            backgroundColor: Colors.transparent,
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              color: Colors.blue,
              borderWidth: 2,
              borderColor: Colors.white,
            ),
            primaryXAxis: CategoryAxis(isVisible: false),
            primaryYAxis: NumericAxis(),
            series: <ChartSeries>[
              ColumnSeries<SalesData, String>(
                legendIconType: LegendIconType.triangle,
                legendItemText:
                    "Tap on each of the following to see the chart data",
                dataSource: data,
                xValueMapper: (SalesData sales, _) => sales.month,
                yValueMapper: (SalesData sales, _) => sales.sales,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);

  final String month;
  final int sales;
}
