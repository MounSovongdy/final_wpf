import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/screens/components/DashboardChart.dart';
import 'package:motor/screens/components/dashboard_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final con = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardCard(),
            spacer(context),
            DashboardChart(),
          ],
        ),
      ),
    );
  }
}
