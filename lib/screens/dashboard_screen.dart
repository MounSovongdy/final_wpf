import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/screens/components/dashboard_card.dart';
import 'package:motor/screens/components/dashboard_receivable_chart.dart';
import 'package:motor/screens/components/dashboard_sale_chart.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
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
            RowCardDashboard3Row(
              spacer: spacer(context),
              widget1: DashboardCard(
                cardTitle: 'Booking',
                widgetBody: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: Row(
                        children: [
                          AppText.subTitle(
                            context,
                            txt: 'New',
                          ),
                          const Spacer(),
                          AppText.subTitleBold(
                            context,
                            txt: '16',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: const UnderLineSecond(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: Row(
                        children: [
                          AppText.subTitle(
                            context,
                            txt: 'Approved',
                          ),
                          const Spacer(),
                          AppText.subTitleBold(
                            context,
                            txt: '23',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: const UnderLineSecond(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: Row(
                        children: [
                          AppText.subTitle(
                            context,
                            txt: 'Rejected',
                          ),
                          const Spacer(),
                          AppText.subTitleBold(
                            context,
                            txt: '05',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget2: DashboardCard(
                cardTitle: 'Stock',
                widgetBody: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: Row(
                        children: [
                          AppText.subTitle(
                            context,
                            txt: 'Total Stock',
                          ),
                          const Spacer(),
                          AppText.subTitleBold(
                            context,
                            txt: '20',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: const UnderLineSecond(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: Row(
                        children: [
                          AppText.subTitle(
                            context,
                            txt: 'Used',
                          ),
                          const Spacer(),
                          AppText.subTitleBold(
                            context,
                            txt: '15',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: const UnderLineSecond(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: Row(
                        children: [
                          AppText.subTitle(
                            context,
                            txt: 'New',
                          ),
                          const Spacer(),
                          AppText.subTitleBold(
                            context,
                            txt: '05',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget3: DashboardCard(
                cardTitle: 'Management',
                widgetBody: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: Row(
                        children: [
                          AppText.subTitle(
                            context,
                            txt: 'User',
                          ),
                          const Spacer(),
                          AppText.subTitleBold(
                            context,
                            txt: '16',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: const UnderLineSecond(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: Row(
                        children: [
                          AppText.subTitle(
                            context,
                            txt: 'Salesman',
                          ),
                          const Spacer(),
                          AppText.subTitleBold(
                            context,
                            txt: '23',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: const UnderLineSecond(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defWebPad.px),
                      child: Row(
                        children: [
                          AppText.subTitle(
                            context,
                            txt: 'Micro',
                          ),
                          const Spacer(),
                          AppText.subTitleBold(
                            context,
                            txt: '05',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            spacer(context),
            RowCardDashboard2Row(
              spacer: spacer(context),
              widget1: const SaleChart(),
              widget2: const ReceivableChart(),
            ),
          ],
        ),
      ),
    );
  }
}
