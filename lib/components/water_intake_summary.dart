import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/bars/bar_graph.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:water_intake/utils/date_helper.dart';

class WaterIntakeSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const WaterIntakeSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    String sunday = convertDateTimeToString(startOfWeek.add(Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(Duration(days: 1)));
    String tuesday = convertDateTimeToString(startOfWeek.add(Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfWeek.add(Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfWeek.add(Duration(days: 6)));


    return Consumer<WaterData>(
      builder: (context, value, child) => SizedBox(
        height: 200, child: 
        BarGraph(
          maxY: calculateMaxAmount(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday), 
          sunWaterAmt: value.calculateDailyWaterSummary()[sunday] ?? 0, 
          monWaterAmt: value.calculateDailyWaterSummary()[monday] ?? 0, 
          tueWaterAmt: value.calculateDailyWaterSummary()[tuesday] ?? 0, 
          wedWaterAmt: value.calculateDailyWaterSummary()[wednesday] ?? 0, 
          thuWaterAmt: value.calculateDailyWaterSummary()[thursday] ?? 0, 
          friWaterAmt: value.calculateDailyWaterSummary()[friday] ?? 0, 
          satWaterAmt: value.calculateDailyWaterSummary()[saturday] ?? 0
        ),
      ),
    );
  }
}

double calculateMaxAmount(
  WaterData data,
  String sunday,
  String monday,
  String tuesday,
  String wednesday,
  String thursday,
  String friday,
  String saturday
) {
  double maxAmount = 100;
  Map<String, double> waterSummary = data.calculateDailyWaterSummary();
  List<double> values = [
    waterSummary[sunday] ?? 0,
    waterSummary[monday] ?? 0,
    waterSummary[tuesday] ?? 0,
    waterSummary[wednesday] ?? 0,
    waterSummary[thursday] ?? 0,
    waterSummary[friday] ?? 0,
    waterSummary[saturday] ?? 0,
  ];

  // Sort from smallest to largest
  values.sort();

  maxAmount = values.last * 1.3;
  return maxAmount == 0 ? 100 : maxAmount;
}