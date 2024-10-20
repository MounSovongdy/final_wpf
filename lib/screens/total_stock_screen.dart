import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/add_stock_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/total_stock_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TotalStockScreen extends StatelessWidget {
  TotalStockScreen({super.key});

  final con = Get.put(TotalStockController());
  final con1 = Get.put(MainController());
  final con2 = Get.put(AddStockController());
  final scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
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
          AppText.header(context, txt: 'Total Stock'),
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
            () => con.filteredTotalStock.isNotEmpty
                ? AppDataTable(
                    column: [
                      DataTableWidget.column(context, 'ID'),
                      DataTableWidget.column(context, 'Date In'),
                      DataTableWidget.column(context, 'Model'),
                      DataTableWidget.column(context, 'Brand'),
                      DataTableWidget.column(context, 'Year'),
                      DataTableWidget.column(context, 'Condition'),
                      DataTableWidget.column(context, 'QTY Begin'),
                      DataTableWidget.column(context, 'QTY Today'),
                      DataTableWidget.column(context, 'Total QTY'),
                      DataTableWidget.column(context, 'Price in QTY Begin'),
                      DataTableWidget.column(context, 'Price in QTY Today'),
                      DataTableWidget.column(
                          context, 'Total Price in QTY Begin'),
                      DataTableWidget.column(
                          context, 'Total Price in QTY Today'),
                    ],
                    source: TotalStockDataSource(),
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
                txt: 'Download Report',
                width: Responsive.isDesktop(context) ? 200.px : 150.px,
                color: secondGreyColor,
                tap: () {},
              ),
              spacer(context),
              spacer(context),
              AppButton(
                txt: 'Add Stock',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () async {
                  startInactivityTimer();
                  con2.listModel.clear();
                  await getAllProduct();
                  for (var pro in product) {
                    con2.listModel.add(pro.model);
                  }
                  con1.index.value = 10;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TotalStockDataSource extends DataTableSource {
  final con = Get.put(TotalStockController());
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
          '${con.filteredTotalStock[index].id}',
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].newDateIn,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].model,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].brand,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].year,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].condition,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].oldQty,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].newQty,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].totalQty,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].oldPrice,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].newPrice,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].oldTotalPrice,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredTotalStock[index].newTotalPrice,
        ),
      ],
    );
  }

  @override
  int get rowCount => con.filteredTotalStock.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
