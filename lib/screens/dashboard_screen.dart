import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/dashboard_card_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/screens/components/dashboard_card.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final con = Get.put(MainController());
  final conDash = Get.put(DashboardCardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => conDash.loading.value
          ? LoadingWidget.loading
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(defWebPad.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowCardDashboard3Row(
                      spacer: spacer(context),
                      widget1: DashboardCard(
                        cardTitle: 'Booking | ការកក់',
                        widgetBody: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(defWebPad.px),
                              child: Row(
                                children: [
                                  AppText.subTitle(context, txt: 'New | ថ្មី'),
                                  const Spacer(),
                                  AppText.subTitleBold(
                                    context,
                                    txt: '${conDash.listNew.length}',
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
                                  AppText.subTitle(context, txt: 'Approved | យល់ព្រម'),
                                  const Spacer(),
                                  AppText.subTitleBold(
                                    context,
                                    txt: '${conDash.listApproved.length}',
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
                                  AppText.subTitle(context, txt: 'Rejected | បដិសេធ'),
                                  const Spacer(),
                                  AppText.subTitleBold(
                                    context,
                                    txt: '${conDash.listRejected.length}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget2: DashboardCard(
                        cardTitle: 'Stock | ស្តុក',
                        widgetBody: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(defWebPad.px),
                              child: Row(
                                children: [
                                  AppText.subTitle(context, txt: 'Total Stock | ស្តុកសរុប'),
                                  const Spacer(),
                                  AppText.subTitleBold(
                                    context,
                                    txt: '${conDash.stockTotal.value}',
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
                                  AppText.subTitle(context, txt: 'Used | បានប្រើ'),
                                  const Spacer(),
                                  AppText.subTitleBold(
                                    context,
                                    txt: '${conDash.stockUsed.value}',
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
                                  AppText.subTitle(context, txt: 'New | ថ្មី'),
                                  const Spacer(),
                                  AppText.subTitleBold(
                                    context,
                                    txt: '${conDash.stockNew.value}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget3: DashboardCard(
                        cardTitle: 'Management | គ្រប់គ្រង',
                        widgetBody: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(defWebPad.px),
                              child: Row(
                                children: [
                                  AppText.subTitle(context, txt: 'User | អ្នកប្រើប្រាស់'),
                                  const Spacer(),
                                  AppText.subTitleBold(
                                    context,
                                    txt: '${conDash.listUser.length}',
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
                                  AppText.subTitle(context, txt: 'Salesman | អ្នកលក់'),
                                  const Spacer(),
                                  AppText.subTitleBold(
                                    context,
                                    txt: '${conDash.listSale.length}',
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
                                  AppText.subTitle(context, txt: 'Microfinance | ស្ថានបណ័'),
                                  const Spacer(),
                                  AppText.subTitleBold(
                                    context,
                                    txt: '${conDash.listMicro.length}',
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
                      widget1: conDash.leasingSale.value > 0 ||
                              conDash.cashSale.value > 0
                          ? DashboardCard(
                              cardTitle: 'Sales | ការលក់',
                              widgetBody: Padding(
                                padding: EdgeInsets.all(defMobPad.px * 4),
                                child: PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        value: conDash.leasingSale.value,
                                        color: bgColor,
                                        title:
                                            'Leasing\n${conDash.leasingSale.value.toStringAsFixed(1)}%',
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                      ),
                                      PieChartSectionData(
                                        value: conDash.cashSale.value,
                                        color: Colors.green,
                                        title:
                                            'Cash\n${conDash.cashSale.value.toStringAsFixed(1)}%',
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ],
                                    sectionsSpace: 3,
                                    centerSpaceRadius: 40,
                                    borderData: FlBorderData(show: false),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      widget2: conDash.activeCon.value > 0 ||
                              conDash.closeCon.value > 0
                          ? DashboardCard(
                              cardTitle: 'Receivable | ការទូទាត់',
                              widgetBody: Padding(
                                padding: EdgeInsets.all(defMobPad.px * 4),
                                child: PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        value: conDash.activeCon.value,
                                        color: bgColor,
                                        title:
                                            'Active\n${conDash.activeCon.toStringAsFixed(1)}%',
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                      ),
                                      PieChartSectionData(
                                        value: conDash.closeCon.value,
                                        color: Colors.green,
                                        title:
                                            'Close\n${conDash.closeCon.toStringAsFixed(1)}%',
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ],
                                    sectionsSpace: 3,
                                    centerSpaceRadius: 40,
                                    borderData: FlBorderData(show: false),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
