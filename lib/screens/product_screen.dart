import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/product_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final con = Get.put(ProductController());
  final conMain = Get.put(MainController());
  final scroll = ScrollController();

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
            AppText.header(context, txt: 'Product List'),
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
              () => con.filteredProduct.isNotEmpty
                  ? AppDataTable(
                      column: [
                        DataTableWidget.column(context, 'ID'),
                        DataTableWidget.column(context, 'Model'),
                        DataTableWidget.column(context, 'Brand'),
                        DataTableWidget.column(context, 'Action'),
                      ],
                      source: ProductDataSource(),
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
                    startInactivityTimer();
                    conMain.index.value = 12;
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

class ProductDataSource extends DataTableSource {
  final con = Get.put(ProductController());
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
          '${con.filteredProduct[index].id}',
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredProduct[index].model,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredProduct[index].brand,
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
                  deleteProduct(con.filteredProduct[index].id);
                  await getAllProduct();
                  con.filteredProduct.value = product;
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
  int get rowCount => con.filteredProduct.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
