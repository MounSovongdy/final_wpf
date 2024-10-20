import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/salesman_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SalesmanScreen extends StatelessWidget {
  SalesmanScreen({super.key});

  final con = Get.put(SalesmanController());
  final con1 = Get.put(MainController());
  final scroll = ScrollController();

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
            AppText.header(context, txt: 'Sale Man List'),
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
              () => con.filteredSale.isNotEmpty
                  ? AppDataTable(
                      column: [
                        DataTableWidget.column(context, 'ID'),
                        DataTableWidget.column(context, 'Full Name'),
                        DataTableWidget.column(context, 'Gender'),
                        DataTableWidget.column(context, 'Tel'),
                        DataTableWidget.column(context, 'Position'),
                        DataTableWidget.column(context, 'Salary'),
                        DataTableWidget.column(context, 'Bonus'),
                        DataTableWidget.column(context, 'Join Date'),
                        DataTableWidget.column(context, 'Action'),
                      ],
                      source: SaleManDataSource(),
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
                  tap: () {
                    startInactivityTimer();
                    con1.index.value = 18;
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

class SaleManDataSource extends DataTableSource {
  final con = Get.put(SalesmanController());
  int selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= rowCount) return null;

    return DataRow.byIndex(
      index: index,
      cells: [
        DataTableWidget.cell(
          Get.context!,
          '${con.filteredSale[index].id}',
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredSale[index].name,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredSale[index].gender,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredSale[index].tel,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredSale[index].position,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredSale[index].salary,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredSale[index].bonus,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredSale[index].date,
        ),
        DataTableWidget.cellBtn(
          Get.context!,
          edit: () => debugPrint('Edit $index'),
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
                  deleteSaleMan(con.filteredSale[index].id);
                  await getAllSaleMan();
                  con.filteredSale.value = saleMan;
                  Get.back();
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
  int get rowCount => con.filteredSale.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
