import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/advertising_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_advertising_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdvertisingScreen extends StatelessWidget {
  AdvertisingScreen({super.key});

  final con = Get.put(AdvertisingController());
  final conNew = Get.put(NewAdvertisingController());
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
            AppText.header(context, txt: 'Advertising List'),
            spacer(context),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Select Month',
                value: con.selectedMonth,
                list: con.monthList,
                onChanged: (v) async {
                  if (v != null) {
                    con.selectedMonth.value = v;
                    con.filteredAdv.clear();
                    await getByDateAdvertise(
                      con.selectedMonth.value!.split('-')[0],
                      con.selectedMonth.value!.split('-')[1],
                    );
                    await getTotalExpense(
                      year: con.selectedMonth.value!.split('-')[0],
                      month: con.selectedMonth.value!.split('-')[1],
                    );
                    if (byTotalExpense.isNotEmpty)
                      con.amount.value.text = byTotalExpense[0].advertise;
                    con.filteredAdv.value = advertise;
                    con.search.value.addListener(con.filterAdvData);
                  }
                },
              ),
              widget2: AppTextField(
                txt: 'Total Amount',
                con: con.amount.value,
                readOnly: true,
              ),
              widget3: AppButtonCalulation(
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
              () => con.filteredAdv.isNotEmpty
                  ? AppDataTableOld(
                      column: [
                        DataTableWidget.column(context, 'ID'),
                        DataTableWidget.column(context, 'Date'),
                        DataTableWidget.column(context, 'Detail'),
                        DataTableWidget.column(context, 'Amount'),
                      ],
                      source: AdvertisingDataSource(),
                    )
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
                  tap: () {
                    startInactivityTimer();
                    conNew.clearText();

                    conMain.index.value = 34;
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

class AdvertisingDataSource extends DataTableSource {
  final con = Get.put(AdvertisingController());

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= con.filteredAdv.length) return null;
    var data = con.filteredAdv[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataTableWidget.cell(Get.context!, '${data.id}'),
        DataTableWidget.cell(Get.context!, '${data.year}-${data.month}'),
        DataTableWidget.cell(Get.context!, data.detail),
        DataTableWidget.cell(Get.context!, data.amount),
      ],
    );
  }

  @override
  int get rowCount => con.filteredAdv.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
