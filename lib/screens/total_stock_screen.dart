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
                ? totalStockDataTable(context)
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
              userRole.value == roleSuperAdmin
                  ? AppButtonSubmit(
                      txt: 'Download Report',
                      width: Responsive.isDesktop(context) ? 200.px : 150.px,
                      color: secondGreyColor,
                      tap: () {},
                    )
                  : Container(),
              userRole.value == roleSuperAdmin ? spacer(context) : Container(),
              userRole.value == roleSuperAdmin ? spacer(context) : Container(),
              userRole.value == roleSuperAdmin
                  ? AppButtonSubmit(
                      txt: 'Add Stock',
                      width: Responsive.isDesktop(context) ? 150.px : 100.px,
                      tap: () async {
                        startInactivityTimer();
                        con.title.value = 'Add Stock';
                        con2.isRead.value = false;
                        con2.clearText();
                        con2.listModel.clear();
                        await getAllProduct();
                        for (var pro in product) {
                          con2.listModel.add(pro.model);
                        }
                        con1.index.value = 10;
                      },
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

Widget totalStockDataTable(BuildContext context) {
  final con = Get.put(TotalStockController());
  final conAS = Get.put(AddStockController());
  final conMain = Get.put(MainController());

  return AppDataTable(
    columnHeaders: [
      DataTableWidget.column(context, 'ID'),
      DataTableWidget.column(context, 'Date In'),
      DataTableWidget.column(context, 'Model'),
      DataTableWidget.column(context, 'Brand'),
      DataTableWidget.column(context, 'Year'),
      DataTableWidget.column(context, 'Condition'),
      DataTableWidget.column(context, 'QTY Begin'),
      DataTableWidget.column(context, 'QTY Today'),
      DataTableWidget.column(context, 'Total QTY'),
      if (userRole.value == roleSuperAdmin)
        DataTableWidget.column(context, 'Price in QTY Begin'),
      if (userRole.value == roleSuperAdmin)
        DataTableWidget.column(context, 'Price in QTY Today'),
      if (userRole.value == roleSuperAdmin)
        DataTableWidget.column(context, 'Total Price in QTY Begin'),
      if (userRole.value == roleSuperAdmin)
        DataTableWidget.column(context, 'Total Price in QTY Today'),
      if (userRole.value == roleSuperAdmin)
        DataTableWidget.column(context, 'Actions'),
    ],
    rowData: List.generate(
      con.filteredTotalStock.length,
      (index) {
        var data = con.filteredTotalStock[index];
        return [
          DataTableWidget.cell(Get.context!, '${data.id}'),
          DataTableWidget.cell(Get.context!, data.newDateIn),
          DataTableWidget.cell(Get.context!, data.model),
          DataTableWidget.cell(Get.context!, data.brand),
          DataTableWidget.cell(Get.context!, data.year),
          DataTableWidget.cell(Get.context!, data.condition),
          DataTableWidget.cell(Get.context!, data.oldQty),
          DataTableWidget.cell(Get.context!, data.newQty),
          DataTableWidget.cell(Get.context!, data.totalQty),
          if (userRole.value == roleSuperAdmin)
            DataTableWidget.cell(Get.context!, data.oldPrice),
          if (userRole.value == roleSuperAdmin)
            DataTableWidget.cell(Get.context!, data.newPrice),
          if (userRole.value == roleSuperAdmin)
            DataTableWidget.cell(Get.context!, data.oldTotalPrice),
          if (userRole.value == roleSuperAdmin)
            DataTableWidget.cell(Get.context!, data.newTotalPrice),
          if (userRole.value == roleSuperAdmin)
            DataTableWidget.cellBtn(
              Get.context!,
              btnDelete: false,
              edit: () async {
                startInactivityTimer();
                con.title.value = 'Edit Stock';
                conAS.clearText();
                conAS.listModel.clear();
                await getAllProduct();
                for (var pro in product) {
                  conAS.listModel.add(pro.model);
                }
                await con.editTotalStock(data.id);
                conMain.index.value = 10;
              },
            ),
        ];
      },
    ),
  );
}
