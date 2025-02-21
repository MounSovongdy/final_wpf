import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/create_salesman_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/salesman_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table_second.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SalesmanScreen extends StatelessWidget {
  SalesmanScreen({super.key});

  final con = Get.put(SalesmanController());
  final conCS = Get.put(CreateSalesmanController());
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
            AppText.header(context, txt: 'Salesman List | បញ្ជីអ្នកលក់'),
            spacer(context),
            TextField(
              controller: con.search.value,
              decoration: const InputDecoration(
                labelText: 'Search | ស្វែងរក',
                hintText: 'Search by any data',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            spacer(context),
            Obx(
              () => con.filteredSale.isNotEmpty
                  ? salesmanDataTable(context)
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: defWebPad.px),
                      alignment: Alignment.center,
                      child: AppText.title(context, txt: 'No Data | គ្មានទិន្នន័យ'),
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
                  txt: 'New | បង្កើតថ្មី',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                    conCS.clearText();
                    con.title.value = 'Create Salesman';
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

Widget salesmanDataTable(BuildContext context) {
  final con = Get.put(SalesmanController());
  final conCS = Get.put(CreateSalesmanController());
  final conMain = Get.put(MainController());

  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Obx(
        () => AppText.title(
          context,
          txt: 'Total Record: ${con.filteredSale.length}',
        ),
      ),
      SizedBox(height: 2.px),
      AppDataTableSecond(
        columnHeaders: [
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
        rowData: List.generate(
          con.filteredSale.length,
          (index) {
            var data = con.filteredSale[index];
            return [
              DataTableWidget.cell(Get.context!, '${data.id}'),
              DataTableWidget.cell(Get.context!, data.name),
              DataTableWidget.cell(Get.context!, data.gender),
              DataTableWidget.cell(Get.context!, data.tel),
              DataTableWidget.cell(Get.context!, data.position),
              DataTableWidget.cell(Get.context!, data.salary),
              DataTableWidget.cell(Get.context!, data.bonus),
              DataTableWidget.cell(Get.context!, data.date),
              DataTableWidget.cellBtn(
                Get.context!,
                edit: () async {
                  startInactivityTimer();
                  conCS.clearText();
                  con.title.value = 'Edit Salesman';
                  await con.editSales(data.id);
                  conMain.index.value = 18;
                },
                delete: () {
                  startInactivityTimer();
                  LoadingWidget.showTextDialog(
                    Get.context!,
                    title: 'Warning | ការព្រមាន',
                    content: 'Are you sure to delete?',
                    color: redColor,
                    txtBack: 'Cancel | បោះបង់',
                    btnColor: secondGreyColor,
                    widget: TextButton(
                      onPressed: () async {
                        await deleteSaleMan(con.filteredSale[index].id);
                        con.filteredSale.clear();
                        await getAllSaleMan();
                        con.filteredSale.value = saleMan;
                        Get.back();
                      },
                      child: AppText.title(Get.context!, txt: 'Confirm | បញ្ជាក់'),
                    ),
                  );
                },
              ),
            ];
          },
        ),
      ),
    ],
  );
}
