import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/leasing_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_leasing_controller.dart';
import 'package:motor/controllers/print_leasing_invoice_controller.dart';
import 'package:motor/controllers/report_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LeasingScreen extends StatelessWidget {
  LeasingScreen({super.key});

  final con = Get.put(LeasingController());
  final conNL = Get.put(NewLeasingController());
  final conMain = Get.put(MainController());
  final conReport = Get.put(ReportController());

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
          AppText.header(context, txt: 'Leasing Sale List'),
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
            () => con.filteredLeasing.isNotEmpty
                ? leasingDataTable(context)
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
              Obx(
                () => con.filteredLeasing.isNotEmpty &&
                        userRole.value == roleSuperAdmin
                    ? AppButtonSubmit(
                        txt: 'Report',
                        color: greenColor,
                        width: Responsive.isDesktop(context) ? 150.px : 100.px,
                        tap: () async {
                          await conReport.downloadExcel(
                            fileName: 'Leasing_Report.xlsx',
                            headers: [
                              'ID',
                              'Sale Date',
                              'ID Card',
                              'Name',
                              'Age',
                              'Telephone',
                              'Address',
                              'Micro',
                              'Brand',
                              'Model',
                              'Color',
                              'Year',
                              'Condition',
                              'Price',
                              'Discount',
                              'Deposit',
                              'Remain',
                              'Bank Receivable',
                              'Acc Receivable',
                              'Saleman',
                              'Come By',
                            ],
                            data: [],
                          );
                        },
                      )
                    : Container(),
              ),
              spacer(context),
              AppButtonSubmit(
                txt: 'New',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () async {
                  startInactivityTimer();
                  LoadingWidget.dialogLoading(duration: 1, isBack: true);
                  conNL.clearText();
                  await con.getBookingIDandIDCard();
                  await con.brandName();
                  await con.colorName();
                  Get.back();
                  conMain.index.value = 22;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget leasingDataTable(BuildContext context) {
  final con = Get.put(LeasingController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Obx(
        () => AppText.title(
          context,
          txt: 'Total Record: ${con.filteredLeasing.length}',
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
          DataTableWidget.column(context, 'Micro'),
          DataTableWidget.column(context, 'Brand'),
          DataTableWidget.column(context, 'Model'),
          DataTableWidget.column(context, 'Color'),
          DataTableWidget.column(context, 'Year'),
          DataTableWidget.column(context, 'Condition'),
          DataTableWidget.column(context, 'Price'),
          DataTableWidget.column(context, 'Discount'),
          DataTableWidget.column(context, 'Deposit'),
          DataTableWidget.column(context, 'Remain'),
          DataTableWidget.column(context, 'Bank Receivable'),
          DataTableWidget.column(context, 'Acc Receivable'),
          DataTableWidget.column(context, 'Saleman'),
          DataTableWidget.column(context, 'Come By'),
          DataTableWidget.column(context, 'Action'),
        ],
        rowData: List.generate(
          con.filteredLeasing.length,
          (index) {
            var data = con.filteredLeasing[index];
            return [
              DataTableWidget.cell(Get.context!, '${data.id}'),
              DataTableWidget.cell(Get.context!, data.leasingDate),
              DataTableWidget.cell(Get.context!, data.idCard),
              DataTableWidget.cell(Get.context!, data.name),
              DataTableWidget.cell(Get.context!, data.age),
              DataTableWidget.cell(Get.context!, data.tel),
              DataTableWidget.cell(Get.context!, data.address),
              DataTableWidget.cell(Get.context!, data.micro),
              DataTableWidget.cell(Get.context!, data.brand),
              DataTableWidget.cell(Get.context!, data.model),
              DataTableWidget.cell(Get.context!, data.color),
              DataTableWidget.cell(Get.context!, data.year),
              DataTableWidget.cell(Get.context!, data.condition),
              DataTableWidget.cell(Get.context!, data.price),
              DataTableWidget.cell(Get.context!, data.discount),
              DataTableWidget.cell(Get.context!, data.deposit),
              DataTableWidget.cell(Get.context!, data.remain),
              DataTableWidget.cell(Get.context!, data.approveAmount),
              DataTableWidget.cell(Get.context!, data.totalDebt),
              DataTableWidget.cell(Get.context!, data.saleman),
              DataTableWidget.cell(Get.context!, data.comeBy),
              DataTableWidget.cellBtn(
                Get.context!,
                btnEdit: false,
                btnDelete: false,
                btnPrint: true,
                edit: () => debugPrint('Edit $index'),
                delete: () => debugPrint('Delete $index'),
                print: () => printLeasingInvoice(data.id),
              ),
            ];
          },
        ),
      ),
    ],
  );
}
