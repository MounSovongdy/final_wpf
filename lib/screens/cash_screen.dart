import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/cash_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_cash_controller.dart';
import 'package:motor/controllers/print_cash_sale_controller.dart';
import 'package:motor/controllers/report_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CashScreen extends StatelessWidget {
  CashScreen({super.key});

  final con = Get.put(CashController());
  final conNC = Get.put(NewCashController());
  final conMain = Get.put(MainController());
  final conReport = Get.put(ReportController());
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
          AppText.header(context, txt: 'Cash Sale List | បញ្ជីលក់ជាសាច់ប្រាក់'),
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
            () => con.filteredCash.isNotEmpty
                ? cashDataTable(context)
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
              Obx(
                () => con.filteredCash.isNotEmpty &&
                        userRole.value == roleSuperAdmin
                    ? AppButtonSubmit(
                        txt: 'Report | របាយការណ៍',
                        color: greenColor,
                        width: Responsive.isDesktop(context) ? 150.px : 100.px,
                        tap: () async {
                          LoadingWidget.dialogLoading(
                              duration: 1, isBack: true);
                          con.filteredCash.sort((a, b) => a.id.compareTo(b.id));
                          await conReport.downloadExcel(
                            fileName: 'Cash_Report.xlsx',
                            headers: [
                              'ID',
                              'Sale Date',
                              'ID Card',
                              'Name',
                              'Gender',
                              'Age',
                              'Telephone',
                              'Address',
                              'Brand',
                              'Model',
                              'Color',
                              'Year',
                              'Power',
                              'Condition',
                              'Engine No',
                              'Frame No',
                              'Type',
                              'Plate Number',
                              'Price',
                              'Discount',
                              'Saleman',
                              'Come By',
                              'Come By Name',
                              'Come By Telephone',
                              'Commission',
                            ],
                            data: List.generate(
                              con.filteredCash.length,
                              (index) => [
                                '${con.filteredCash[index].id}',
                                con.filteredCash[index].date,
                                con.filteredCash[index].idCard,
                                con.filteredCash[index].name,
                                con.filteredCash[index].gender,
                                con.filteredCash[index].age,
                                con.filteredCash[index].tel,
                                con.filteredCash[index].address,
                                con.filteredCash[index].brand,
                                con.filteredCash[index].model,
                                con.filteredCash[index].year,
                                con.filteredCash[index].color,
                                con.filteredCash[index].power,
                                con.filteredCash[index].condition,
                                con.filteredCash[index].engineNo,
                                con.filteredCash[index].frameNo,
                                con.filteredCash[index].type,
                                con.filteredCash[index].plateNo,
                                con.filteredCash[index].price,
                                con.filteredCash[index].discount,
                                con.filteredCash[index].saleman,
                                con.filteredCash[index].comeBy,
                                con.filteredCash[index].comeByName,
                                con.filteredCash[index].comeByTel,
                                con.filteredCash[index].commission,
                              ],
                            ),
                          );
                          Get.back();
                        },
                      )
                    : Container(),
              ),
              spacer(context),
              AppButtonSubmit(
                txt: 'New | បង្កើតថ្មី',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () async {
                  LoadingWidget.dialogLoading(duration: 1, isBack: true);
                  conNC.clearText();
                  conNC.dateBooking.value.text = '$dateNow $timeNow';
                  conNC.discount.value.text = '0';
                  await conNC.saleManName();
                  await conNC.brandName();
                  await conNC.addressName();
                  await conNC.colorName();

                  startInactivityTimer();
                  Get.back();
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

Widget cashDataTable(BuildContext context) {
  final con = Get.put(CashController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Obx(
        () => AppText.title(
          context,
          txt: 'Total Record: ${con.filteredCash.length}',
        ),
      ),
      SizedBox(height: 2.px),
      AppDataTable(
        columnHeaders: [
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
          DataTableWidget.column(context, 'Discount'),
          DataTableWidget.column(context, 'Saleman'),
          DataTableWidget.column(context, 'Come by'),
          DataTableWidget.column(context, 'Action'),
        ],
        rowData: List.generate(
          con.filteredCash.length,
          (index) {
            var data = con.filteredCash[index];

            return [
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
              DataTableWidget.cell(Get.context!, data.discount),
              DataTableWidget.cell(Get.context!, data.saleman),
              DataTableWidget.cell(Get.context!, data.comeBy),
              DataTableWidget.cellBtn(
                Get.context!,
                btnEdit: false,
                btnDelete: false,
                btnPrint: true,
                edit: () => debugPrint('Edit $index'),
                delete: () => debugPrint('Delete $index'),
                print: () => printCashInvoice(data.id),
              ),
            ];
          },
        ),
      ),
    ],
  );
}
