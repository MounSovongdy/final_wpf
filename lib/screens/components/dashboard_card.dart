import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/dashboard_card_controller.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardCard extends StatelessWidget {
  final String cardTitle;
  final Widget widgetBody;
  DashboardCard({super.key, required this.cardTitle, required this.widgetBody});

  final con = Get.put(DashboardCardController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: EdgeInsets.all(defMobPad.px),
        child: Container(
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
                          txt: cardTitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(flex: 4, child: widgetBody),
            ],
          ),
        ),
      ),
    );
  }
}
