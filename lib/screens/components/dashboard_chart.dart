import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardChart extends StatelessWidget {
  const DashboardChart({super.key});

  @override
  Widget build(BuildContext context) {

    var total = 0.0.obs;
    var empSalary = 800.0.obs;
    var empBonus = 300.0.obs;
    var teacherBonus = 400.0.obs;
    var advertising = 100.0.obs;
    var kpiPaid = 100.0.obs;
    var sellGift = 50.0.obs;
    var commission = 80.0.obs;

    total.value = empSalary.value +
        empBonus.value +
        teacherBonus.value +
        advertising.value +
        kpiPaid.value +
        sellGift.value +
        commission.value;

    return Padding(
      padding: EdgeInsets.all(defMobPad.px),
      child: Container(
        height: 400.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(defMobPad.px * 4),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 2500,
              // Adjust maxY to make sure the bars fit well.
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: total.value,
                      color: Colors.cyan,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                  showingTooltipIndicators: [],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: empSalary.value,
                      color: Colors.cyan,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                  showingTooltipIndicators: [],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                      toY: empBonus.value,
                      color: Colors.orange,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                  showingTooltipIndicators: [],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                      toY: teacherBonus.value,
                      color: Colors.pink,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                  showingTooltipIndicators: [],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(
                      toY: advertising.value,
                      color: Colors.pink,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                  showingTooltipIndicators: [],
                ),
                BarChartGroupData(
                  x: 5,
                  barRods: [
                    BarChartRodData(
                      toY: kpiPaid.value,
                      color: Colors.pink,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                  showingTooltipIndicators: [],
                ),
                BarChartGroupData(
                  x: 6,
                  barRods: [
                    BarChartRodData(
                      toY: sellGift.value,
                      color: Colors.pink,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                  showingTooltipIndicators: [],
                ),
                BarChartGroupData(
                  x: 7,
                  barRods: [
                    BarChartRodData(
                      toY: commission.value,
                      color: Colors.pink,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                  showingTooltipIndicators: [],
                ),
              ],
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1),
                  right: BorderSide.none,
                  top: BorderSide.none,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  )
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 50,
                    showTitles: true,
                    interval: 500,
                    // Adjust the interval for better readability.
                    getTitlesWidget: (value, _) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      switch (value.toInt()) {
                        case 1:
                          return const Text('Employee Paid');
                        case 2:
                          return const Text('Employee Bonus');
                        case 3:
                          return const Text('Teacher Bonus');
                        case 4:
                          return const Text('Advertising');
                        case 5:
                          return const Text('KPI Paid');
                        case 6:
                          return const Text('Sell Gift');
                        case 7:
                          return const Text('Commission');
                        default:
                          return const Text('Total');
                      }
                    },
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }
}
