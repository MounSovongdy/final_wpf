import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fl_chart/fl_chart.dart';

class SaleChart extends StatelessWidget {
  const SaleChart({super.key});

  @override
  Widget build(BuildContext context) {
    var leasingSale = 800.0;
    var cashSale = 300.0;
    var total = leasingSale + cashSale;

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
                        txt: 'Sales',
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
                        value: leasingSale,
                        color: bgColor,
                        title:
                            'Leasing\n${((leasingSale / total) * 100).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                      PieChartSectionData(
                        value: cashSale,
                        color: Colors.green,
                        title:
                            'Cash\n${((cashSale / total) * 100).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
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
