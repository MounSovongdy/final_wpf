import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/finance_card_controller.dart';
import 'package:motor/controllers/finance_record_controller.dart';
import 'package:motor/controllers/report_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/finance_card.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FinancialRecordScreen extends StatelessWidget {
  FinancialRecordScreen({super.key});

  final con = Get.put(FinanceRecordController());
  final conFC = Get.put(FinanceCardController());
  final conReport = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: 'Financial Record'),
            spacer(context),
            RowTextField2(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Total Expense',
                con: con.totalExpense.value,
                readOnly: true,
              ),
              widget2: AppDropdownSearch(
                txt: 'Select Month',
                value: con.selectedMonth,
                list: con.monthList,
                onChanged: (v) async {
                  if (v != null) {
                    LoadingWidget.dialogLoading(duration: 1, isBack: true);
                    con.selectedMonth.value = v;
                    await getTotalExpense(
                      year: con.selectedMonth.value!.split('-')[0],
                      month: con.selectedMonth.value!.split('-')[1],
                    );
                    if (byTotalExpense.isNotEmpty) {
                      var tempA = num.parse(byTotalExpense[0].advertise);
                      var tempS = num.parse(byTotalExpense[0].salaryE);
                      var tempr = num.parse(byTotalExpense[0].rental);
                      var tempk = num.parse(byTotalExpense[0].koi);
                      var tempg = num.parse(byTotalExpense[0].gift);
                      var tempe = num.parse(byTotalExpense[0].bonusE);
                      var tempt = num.parse(byTotalExpense[0].bonusT);
                      var tempc = num.parse(byTotalExpense[0].commission);
                      var tempte = num.parse(byTotalExpense[0].totalExpense);
                      var tempNS = num.parse(byTotalExpense[0].netSale);
                      var tempSR = num.parse(byTotalExpense[0].saleRevenue);
                      var tempTS = num.parse(byTotalExpense[0].totalSale);
                      var tempASR = num.parse(byTotalExpense[0].totalProfit);
                      var tempAP = num.parse(byTotalExpense[0].avgProfit);

                      conFC.adv.value = '$tempA'.contains('.')
                          ? num.parse('$tempA').toStringAsFixed(2)
                          : num.parse('$tempA').toString();
                      conFC.salary.value = '$tempS'.contains('.')
                          ? num.parse('$tempS').toStringAsFixed(2)
                          : num.parse('$tempS').toString();
                      conFC.rent.value = '$tempr'.contains('.')
                          ? num.parse('$tempr').toStringAsFixed(2)
                          : num.parse('$tempr').toString();
                      conFC.koi.value = '$tempk'.contains('.')
                          ? num.parse('$tempk').toStringAsFixed(2)
                          : num.parse('$tempk').toString();
                      conFC.gift.value = '$tempg'.contains('.')
                          ? num.parse('$tempg').toStringAsFixed(2)
                          : num.parse('$tempg').toString();
                      conFC.bonusE.value = '$tempe'.contains('.')
                          ? num.parse('$tempe').toStringAsFixed(2)
                          : num.parse('$tempe').toString();
                      conFC.bonusT.value = '$tempt'.contains('.')
                          ? num.parse('$tempt').toStringAsFixed(2)
                          : num.parse('$tempt').toString();
                      conFC.comm.value = '$tempc'.contains('.')
                          ? num.parse('$tempc').toStringAsFixed(2)
                          : num.parse('$tempc').toString();
                      conFC.netsale.value = '$tempNS'.contains('.')
                          ? num.parse('$tempNS').toStringAsFixed(2)
                          : num.parse('$tempNS').toString();
                      conFC.saleRevenue.value = '$tempSR'.contains('.')
                          ? num.parse('$tempSR').toStringAsFixed(2)
                          : num.parse('$tempSR').toString();
                      conFC.totalUnitSale.value = '$tempTS'.contains('.')
                          ? num.parse('$tempTS').toStringAsFixed(2)
                          : num.parse('$tempTS').toString();
                      conFC.totalProfit.value = '$tempASR'.contains('.')
                          ? num.parse('$tempASR').toStringAsFixed(2)
                          : num.parse('$tempASR').toString();
                      conFC.avgProfit.value = '$tempAP'.contains('.')
                          ? num.parse('$tempAP').toStringAsFixed(2)
                          : num.parse('$tempAP').toString();

                      con.totalExpense.value.text = '$tempte'.contains('.')
                          ? '${num.parse('$tempte').toStringAsFixed(2)} \$'
                          : '${num.parse('$tempte')} \$';

                      conFC.itemValue.value = [
                        {'value': '${conFC.adv.value} \$'},
                        {'value': '${conFC.rent.value} \$'},
                        {'value': '${conFC.salary.value} \$'},
                        {'value': '${conFC.koi.value} \$'},
                        {'value': '${conFC.gift.value} \$'},
                        {'value': '${conFC.bonusE.value} \$'},
                        {'value': '${conFC.bonusT.value} \$'},
                        {'value': '${conFC.comm.value} \$'},
                      ];

                      conFC.financeValue.value = [
                        {'value': '${conFC.netsale.value} \$'},
                        {'value': '${conFC.saleRevenue.value} \$'},
                        {'value': '${conFC.totalUnitSale.value} '},
                        {'value': '${conFC.totalProfit.value} \$'},
                        {'value': '${conFC.avgProfit.value} \$'},
                      ];
                      Get.back();
                    }
                  }
                },
              ),
            ),
            spacer(context),
            spacer(context),
            FinanceCard(
              title: conFC.itemTitle,
              value: conFC.itemValue,
            ),
            spacer(context),
            FinanceCard(
              title: conFC.financeTitle,
              value: conFC.financeValue,
            ),
            spacer(context),
            spacer(context),
            const UnderLine(color: secondGreyColor),
            spacer(context),
            Obx(
              () => byTotalExpense.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButtonSubmit(
                          txt: 'Report',
                          color: greenColor,
                          tap: () async {
                            await conReport.downloadExcel(
                              fileName: 'FinancialRecord_Report.xlsx',
                              headers: [
                                'Advertising',
                                'Prepaid Rent',
                                'Payable Salary',
                                'Prepaid Expense KOL',
                                'Free Gift',
                                'Bonus E',
                                'Bonus T',
                                'Commission',
                                'Net Sale',
                                'Sale Revenue',
                                'Total Unit Sale',
                                'Total Profit',
                                'Average Profit'
                              ],
                              data: [],
                            );
                          },
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
