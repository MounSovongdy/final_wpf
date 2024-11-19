import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fl_chart/fl_chart.dart';

class ReceivableChart extends StatelessWidget {
  const ReceivableChart({super.key});

  @override
  Widget build(BuildContext context) {
    var activeCon = 600.0;
    var closeCon = 800.0;
    var total = activeCon + closeCon;

    return Padding(
      padding: EdgeInsets.all(defMobPad.px),
      child: Container(
        height: 300.px,
        color: whiteColor,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: secondGreyColor,
                child: Padding(
                  padding: EdgeInsets.all(defWebPad.px),
                  child: Row(
                    children: [
                      AppText.title(
                        context,
                        txt: 'Receivable',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(defMobPad.px * 4),
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: activeCon,
                        color: bgColor,
                        title: 'Active\n${((activeCon / total) * 100).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: whiteColor),
                      ),
                      PieChartSectionData(
                        value: closeCon,
                        color: Colors.green,
                        title: 'Close\n${((closeCon / total) * 100).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: whiteColor),
                      ),
                    ],
                    sectionsSpace: 3,
                    centerSpaceRadius: 40,
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}