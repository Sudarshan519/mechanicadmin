import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineChart extends StatefulWidget {
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  //List<charts.Series<Task, String>> _seriesPieData;
  //List<charts.Series<Pollution, String>> _seriesBarData;
  List<charts.Series<Sales, int>> _seriesLineData;

  @override
  void initState() {
    super.initState();
    // _seriesPieData = List<charts.Series<Task, String>>();
    // _seriesBarData = List<charts.Series<Pollution, String>>();
    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
  }

  void _generateData() {
    var linedata = [
      Sales(0, 20),
      Sales(1, 30),
      Sales(2, 40),
      Sales(3, 53),
      Sales(4, 60),
      // Sales(1, 20),
      // Sales(2, 22),
      // Sales(2, 30),

      // Sales(5, 0),
    ];
    var linedata1 = [
      Sales(0, 30),
      Sales(1, 35),
      Sales(2, 40),
      Sales(3, 50),
      Sales(4, 59),
      // Sales(5, 90),
    ];
    var linedata2 = [
      Sales(0, 40),
      Sales(1, 52),
      Sales(2, 59),
      Sales(3, 70),
      Sales(4, 80),
      // Sales(5, 100),
    ];
    // var data1 = [
    //   Pollution(1980, 'USA', 30),
    //   Pollution(1980, 'USA', 30),
    //   Pollution(1980, 'USA', 30),
    // ];
    // var data2 = [
    //   Pollution(1980, 'USA', 30),
    //   Pollution(1980, 'USA', 30),
    //   Pollution(1980, 'USA', 30),
    // ];
    // var data3 = [
    //   Pollution(1980, 'USA', 30),
    //   Pollution(1980, 'USA', 30),
    //   Pollution(1980, 'USA', 30),
    // ];
    // var pieData = [
    //   Task('Work', 43, Colors.blue),
    //   Task('Home', 33, Colors.green),
    //   Task('Find', 22, Colors.red),
    //   Task('School', 133, Colors.yellow),
    //   Task('Tiem', 13, Colors.orange),
    // ];
    _seriesLineData.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.blue),
          id: 'Air',
          data: linedata,
          domainFn: (Sales sales, _) => sales.yearval,
          measureFn: (Sales sales, _) => sales.salesval),
    );
    _seriesLineData.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.cyan),
          id: 'Air',
          data: linedata1,
          domainFn: (Sales sales, _) => sales.yearval,
          measureFn: (Sales sales, _) => sales.salesval),
    );
    _seriesLineData.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.red),
          id: 'Air',
          data: linedata2,
          domainFn: (Sales sales, _) => sales.yearval,
          measureFn: (Sales sales, _) => sales.salesval),
    );
    // _seriesBarData.add(charts.Series(
    //     data: data1,
    //     domainFn: (Pollution pollution, _) => pollution.place,
    //     measureFn: (Pollution pollution, _) => pollution.quantity,
    //     id: "2017",
    //     fillPatternFn: (_,__)=>charts.FillPatternType.solid,
    //     fillColorFn: (Pollution pollution,_)=>charts.ColorUtil.fromDartColor(Colors.yellow)
    //     ));
    //  _seriesBarData.add(charts.Series(
    // data: data3,
    // domainFn: (Pollution pollution, _) => pollution.place,
    // measureFn: (Pollution pollution, _) => pollution.quantity,
    // id: "2017",
    // fillPatternFn: (_,__)=>charts.FillPatternType.solid,
    // fillColorFn: (Pollution pollution,_)=>charts.ColorUtil.fromDartColor(Colors.yellow)
    // ));
    //  _seriesBarData.add(charts.Series(
    // data: data2,
    // domainFn: (Pollution pollution, _) => pollution.place,
    // measureFn: (Pollution pollution, _) => pollution.quantity,
    // id: "2017",
    // fillPatternFn: (_,__)=>charts.FillPatternType.solid,
    // fillColorFn: (Pollution pollution,_)=>charts.ColorUtil.fromDartColor(Colors.yellow)
    // ));
    // _seriesPieData.add(charts.Series(
    //     data: pieData,
    //     domainFn: (Task task, _) => task.task,
    //     measureFn: (Task task, _) => task.taskValue,
    //     colorFn: (Task task, _) =>
    //         charts.ColorUtil.fromDartColor(task.colorval),
    //     id: "Daily Task",
    //     labelAccessorFn: (Task row, _) => '${row.taskValue}'));
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // backgroundColor: Colors.blue[100],
        //appBar: AppBar(
        // bottom: TabBar(
        //   indicatorColor: Colors.cyan,
        //   tabs: <Widget>[
        //     Tab(
        //       icon: Icon(Icons.pie_chart),
        //       child: Text('Pie-Chart'),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.graphic_eq),
        //       child: Text('Bar Graph'),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.linear_scale),
        //       child: Text('Line Chart'),
        //     ),
        //   ],
        // ),
        //title: Text('Charts'),
        // //),
        // body: TabBarView(
        //   children: <Widget>[
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         child: Center(
        //           child: Column(
        //             children: <Widget>[
        //               Text('Time Spent'),
        //               Expanded(
        //                 child: charts.PieChart(
        //                   _seriesPieData,
        //                   animate: true,
        //                   animationDuration: Duration(seconds: 5),
        //                   behaviors: [
        //                     charts.DatumLegend(
        //                         outsideJustification:
        //                             charts.OutsideJustification.endDrawArea,
        //                         horizontalFirst: false,
        //                         desiredMaxRows: 2,
        //                         cellPadding: EdgeInsets.only(
        //                           right: 4,
        //                           bottom: 4,
        //                         ),
        //                         entryTextStyle: charts.TextStyleSpec(
        //                             color: charts
        //                                 .MaterialPalette.purple.shadeDefault,
        //                             fontFamily: 'Georgia',
        //                             fontSize: 11)),
        //                   ],
        //                   defaultRenderer: new charts.ArcRendererConfig(
        //                       arcWidth: 100,
        //                       arcRendererDecorators: [
        //                         charts.ArcLabelDecorator(
        //                             labelPosition:
        //                                 charts.ArcLabelPosition.inside)
        //                       ]),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         child: Center(
        //           child: Column(
        //             children: <Widget>[
        //               Text('Time Spent'),
        //               Expanded(
        //                 child: charts.BarChart(
        //                   _seriesPieData,
        //                   animate: true,
        //                   //barGroupingType: charts.BarGroupingType.grouped,
        //                   animationDuration: Duration(seconds: 5),
        //                   behaviors: [
        //                     charts.DatumLegend(
        //                         outsideJustification:
        //                             charts.OutsideJustification.endDrawArea,
        //                         horizontalFirst: false,
        //                         desiredMaxRows: 2,
        //                         cellPadding: EdgeInsets.only(
        //                           right: 4,
        //                           bottom: 4,
        //                         ),
        //                         entryTextStyle: charts.TextStyleSpec(
        //                             color: charts
        //                                 .MaterialPalette.purple.shadeDefault,
        //                             fontFamily: 'Georgia',
        //                             fontSize: 11)),
        //                   ],
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        Column(
      children: <Widget>[
        Expanded(
          child: charts.LineChart(
            _seriesLineData,
            defaultRenderer: charts.LineRendererConfig(
                // includeArea: true,
                //stacked: true,
                ),
            animate: true,
            primaryMeasureAxis: new charts.NumericAxisSpec(
                renderSpec: new charts.GridlineRendererSpec(
              // Display the measure axis labels below the gridline.
              //
              // 'Before' & 'after' follow the axis value direction.
              // Vertical axes draw 'before' below & 'after' above the tick.
              // Horizontal axes draw 'before' left & 'after' right the tick.
              labelAnchor: charts.TickLabelAnchor.before,

              labelJustification: charts.TickLabelJustification.outside,
            )),
            animationDuration: Duration(seconds: 5),
            behaviors: [
              charts.ChartTitle('Years',
                  behaviorPosition: charts.BehaviorPosition.bottom),
              charts.ChartTitle('Months',
                  behaviorPosition: charts.BehaviorPosition.end,
                  titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea),
              charts.ChartTitle('Sales',
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea)
            ],
          ),
        ),
        Text('Sales on monthly interval'),
      ],
    );
  }
}

// class Task {
//   String task;
//   double taskValue;
//   Color colorval;
//   Task(this.task, this.taskValue, this.colorval);
// }

// class Pollution {
//   String place;
//   int year;
//   int quantity;
//   Pollution(this.year, this.place, this.quantity);
// }

class Sales {
  int yearval;
  int salesval;
  Sales(this.yearval, this.salesval);
}
