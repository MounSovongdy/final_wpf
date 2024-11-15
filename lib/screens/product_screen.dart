import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/create_product_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/product_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table_second.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final con = Get.put(ProductController());
  final conCP = Get.put(CreateProductController());
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
                  ? productDataTable(context)
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
                AppButtonSubmit(
                  txt: 'New',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () async {
                    con.title.value = 'Create Product';
                    conCP.clearText();
                    conCP.brandList.clear();
                    await getAllBrand();
                    for (var data in brand) {
                      conCP.brandList.add(data.brand);
                    }

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

Widget productDataTable(BuildContext context){
  final con = Get.put(ProductController());
  final conCP = Get.put(CreateProductController());
  final conMain = Get.put(MainController());

  return AppDataTableSecond(
      columnHeaders: [
        DataTableWidget.column(context, 'ID'),
        DataTableWidget.column(context, 'Brand'),
        DataTableWidget.column(context, 'Model'),
        DataTableWidget.column(context, 'Action'),
      ],
      rowData: List.generate(
        con.filteredProduct.length,
            (index) {
          var data = con.filteredProduct[index];
          return [
            DataTableWidget.cell(Get.context!, '${data.id}'),
            DataTableWidget.cell(Get.context!, data.brand),
            DataTableWidget.cell(Get.context!, data.model),
            DataTableWidget.cellBtn(
              Get.context!,
              edit: () async {
                startInactivityTimer();
                conCP.clearText();
                con.title.value = 'Edit Product';
                conCP.brandList.clear();
                await getAllBrand();
                for (var data in brand) {
                  conCP.brandList.add(data.brand);
                }
                await con.editProduct(data.id);
                conMain.index.value = 12;
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
                      await deleteProduct(con.filteredProduct[index].id);
                      con.filteredProduct.clear();
                      await getAllProduct();
                      con.filteredProduct.value = product;
                      Get.back();
                    },
                    child: AppText.title(Get.context!, txt: 'Confirm'),
                  ),
                );
              },
            ),
          ];
        },
      ),
  );
}

