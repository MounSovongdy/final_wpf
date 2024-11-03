import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/staff_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StaffScreen extends StatelessWidget {
  StaffScreen({super.key});

  final con = Get.put(StaffController());
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
                onChanged: (v) {
                  if (v != null) con.selectedMonth.value = v;
                },
              ),
              widget2: AppTextField(
                txt: 'Total Amount',
                con: con.amount.value,
                readOnly: true,
              ),
              widget3: AppButtonCalulation(
                txt: 'Calulation',
                tap: () {},
              ),
            ),
            spacer(context),
            Padding(
              padding: EdgeInsets.all(defWebPad.px),
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
                  () => con.filteredUsers.isNotEmpty
                  ? AppDataTable(
                column: [
                  DataTableWidget.column(context, 'ID'),
                  DataTableWidget.column(context, 'Name'),
                  DataTableWidget.column(context, 'Salary'),
                  DataTableWidget.column(context, 'Bonus'),
                  DataTableWidget.column(context, 'Sale Unit'),
                  DataTableWidget.column(context, 'Action'),
                ],
                source: StaffDataSource(),
              )
                  : Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: defWebPad.px),
                alignment: Alignment.center,
                child: AppText.title(context, txt: 'No Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaffDataSource extends DataTableSource{
  final con = Get.put(StaffController());
  @override
  DataRow? getRow(int index){
    assert(index >= 0);
    if (index >= con.filteredUsers.length) return null;
    var data = con.filteredUsers[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataTableWidget.cell(Get.context!, '${data.id}'),
        DataTableWidget.cell(Get.context!, 'data.name'),
        DataTableWidget.cell(Get.context!, 'data.dateCreate'),
        DataTableWidget.cellBtn(
          Get.context!,
          edit: () async {
            startInactivityTimer();
          },
          delete: () {
            startInactivityTimer();
            LoadingWidget.showTextDialog(
              Get.context!,
              title: 'Warning',
              content: 'Are you sure to delete?',
              color: redColor,
              txtBack: 'Cancel',
              btnColor: secondGreyColor,
              widget: TextButton(
                onPressed: () async {
                },
                child: AppText.title(Get.context!, txt: 'Confirm'),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  int get rowCount => con.filteredUsers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
