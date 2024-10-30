import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/cash_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_cash_controller.dart';
import 'package:motor/controllers/print_cash_sale_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CashScreen extends StatelessWidget {
  CashScreen({super.key});

  final con = Get.put(CashController());
  final conNC = Get.put(NewCashController());
  final conMain = Get.put(MainController());
  final scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    var dateNow = dateFormat.format(DateTime.now());
    var timeNow = timeFormat.format(DateTime.now());

    return Container(
      margin: EdgeInsets.all(defWebPad.px),
      padding: EdgeInsets.all(defWebPad.px),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(defRadius.px),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          AppText.header(context, txt: 'Cash Sale List'),
          spacer(context),
          TextField(
            controller: con.search.value,
            decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Search by any data',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          spacer(context),
          Obx(
            () => con.filteredCash.isNotEmpty
                ? AppDataTable(
                    column: [
                      DataTableWidget.column(context, 'ID'),
                      DataTableWidget.column(context, 'Sale Date'),
                      DataTableWidget.column(context, 'ID Card'),
                      DataTableWidget.column(context, 'Name'),
                      DataTableWidget.column(context, 'Age'),
                      DataTableWidget.column(context, 'Telephone'),
                      DataTableWidget.column(context, 'Address'),
                      DataTableWidget.column(context, 'Brand'),
                      DataTableWidget.column(context, 'Model'),
                      DataTableWidget.column(context, 'Color'),
                      DataTableWidget.column(context, 'Year'),
                      DataTableWidget.column(context, 'Condition'),
                      DataTableWidget.column(context, 'Price'),
                      DataTableWidget.column(context, 'Saleman'),
                      DataTableWidget.column(context, 'Come by'),
                      DataTableWidget.column(context, 'Action'),
                    ],
                    source: CashDataSource(),
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
              AppButton(
                txt: 'New',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () async {
                  conNC.clearText();
                  conNC.dateBooking.value.text = '$dateNow $timeNow';
                  conNC.discount.value.text = '0';
                  await conNC.saleManName();
                  await conNC.brandName();

                  startInactivityTimer();
                  conMain.index.value = 24;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CashDataSource extends DataTableSource {
  final con = Get.put(CashController());

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= con.filteredCash.length) return null;

    var data = con.filteredCash[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataTableWidget.cellBtn(
          Get.context!,
          btnEdit: false,
          btnDelete: false,
          btnPrint: true,
          edit: () => debugPrint('Edit $index'),
          delete: () => debugPrint('Delete $index'),
          print: () {
            printCashInvoice();
          },
        ),
        DataTableWidget.cell(Get.context!, '${data.id}'),
        DataTableWidget.cell(Get.context!, data.date),
        DataTableWidget.cell(Get.context!, data.idCard),
        DataTableWidget.cell(Get.context!, data.name),
        DataTableWidget.cell(Get.context!, data.age),
        DataTableWidget.cell(Get.context!, data.tel),
        DataTableWidget.cell(Get.context!, data.address),
        DataTableWidget.cell(Get.context!, data.brand),
        DataTableWidget.cell(Get.context!, data.model),
        DataTableWidget.cell(Get.context!, data.color),
        DataTableWidget.cell(Get.context!, data.year),
        DataTableWidget.cell(Get.context!, data.condition),
        DataTableWidget.cell(Get.context!, data.price),
        DataTableWidget.cell(Get.context!, data.saleman),
        DataTableWidget.cell(Get.context!, data.comeBy),
      ],
    );
  }

  @override
  int get rowCount => con.filteredCash.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
