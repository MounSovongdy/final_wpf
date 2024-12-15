import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_staff_controller.dart';
import 'package:motor/controllers/staff_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table_second.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StaffScreen extends StatelessWidget {
  StaffScreen({super.key});

  final con = Get.put(StaffController());
  final conNewStaff = Get.put(NewStaffController());
  final conMain = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: 'Staff List'),
            spacer(context),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Select Month',
                value: con.selectedMonth,
                list: con.monthList,
                onChanged: (v) async {
                  if (v != null) {
                    LoadingWidget.dialogLoading(duration: 1, isBack: true);
                    con.selectedMonth.value = v;
                    con.filteredStaff.clear();
                    await getByDateSaleManCommission(
                      con.selectedMonth.value!.split('-')[0],
                      con.selectedMonth.value!.split('-')[1],
                    );
                    await getTotalExpense(
                      year: con.selectedMonth.value!.split('-')[0],
                      month: con.selectedMonth.value!.split('-')[1],
                    );
                    if (byTotalExpense.isNotEmpty) {
                      var temp = num.parse(byTotalExpense[0].salaryE) +
                          num.parse(byTotalExpense[0].bonusE);
                      con.amount.value.text = '$temp'.contains('.')
                          ? num.parse('$temp').toStringAsFixed(2)
                          : num.parse('$temp').toString();
                    }

                    con.filteredStaff.value = saleManCom;
                    con.search.value.addListener(con.filterStaffData);
                    Get.back();
                  }
                },
              ),
              widget2: AppTextField(
                txt: 'Total Amount',
                con: con.amount.value,
                readOnly: true,
              ),
              widget3: AppButtonCalculator(
                txt: 'Calulation',
                tap: () => con.calculateTotal(context),
              ),
            ),
            spacer(context),
            spacer(context),
            Container(
              padding: EdgeInsets.only(
                left: defWebPad.px / 2,
                right: defWebPad.px,
              ),
              child: TextField(
                controller: con.search.value,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  hintText: 'Search by any data',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            spacer(context),
            Obx(
              () => con.filteredStaff.isNotEmpty
                  ? staffDataTable(context)
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: defWebPad.px),
                      alignment: Alignment.center,
                      child: AppText.title(context, txt: 'No Data'),
                    ),
            ),
            spacer(context),
            spacer(context),
            const UnderLine(color: secondGreyColor),
            spacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButtonSubmit(
                  txt: 'New',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () async {
                    startInactivityTimer();
                    LoadingWidget.dialogLoading(duration: 1, isBack: true);
                    conNewStaff.nameList.clear();
                    conNewStaff.clearText();
                    await getAllSaleMan();
                    for (var data in saleMan) {
                      conNewStaff.nameList.add(data.name);
                    }
                    Get.back();
                    conMain.index.value = 44;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget staffDataTable(BuildContext context) {
  final con = Get.put(StaffController());
  return AppDataTableSecond(
    columnHeaders: [
      DataTableWidget.column(context, 'ID'),
      DataTableWidget.column(context, 'Date'),
      DataTableWidget.column(context, 'Name'),
      DataTableWidget.column(context, 'Salary'),
      DataTableWidget.column(context, 'Bonus'),
      DataTableWidget.column(context, 'Sale Unit'),
      DataTableWidget.column(context, 'Amount'),
    ],
    rowData: List.generate(
      con.filteredStaff.length,
      (index) {
        var data = con.filteredStaff[index];
        return [
          DataTableWidget.cell(Get.context!, '${data.id}'),
          DataTableWidget.cell(Get.context!, '${data.year}-${data.month}'),
          DataTableWidget.cell(Get.context!, data.saleManName),
          DataTableWidget.cell(Get.context!, data.saleSalary),
          DataTableWidget.cell(Get.context!, data.saleBonus),
          DataTableWidget.cell(Get.context!, data.unitSale),
          DataTableWidget.cell(Get.context!, data.totalBonus),
        ];
      },
    ),
  );
}
