import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/print_payment_table_controller.dart';
import 'package:motor/controllers/receivable_controller.dart';
import 'package:motor/controllers/report_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table_receivable.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReceivableScreen extends StatelessWidget {
  ReceivableScreen({super.key});

  final con = Get.put(ReceivableController());
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
          AppText.header(context, txt: 'Receivable List'),
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
            () => con.filteredRece.isNotEmpty
                ? receivableDataTable(context)
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
                () => con.filteredRece.isNotEmpty &&
                        userRole.value == roleSuperAdmin
                    ? AppButtonSubmit(
                        txt: 'Report',
                        color: greenColor,
                        tap: () async {
                          await conReport.downloadExcel(
                            fileName: 'Receivable_Report.xlsx',
                            headers: [
                              'ID',
                              'Saleman',
                              'Date',
                              'Name',
                              'Telephone 1',
                              'Telephone 2',
                              'Telephone 3',
                              'Next Payment',
                              'Document',
                              'Brand',
                              'Model',
                              'Color',
                              'Year',
                              'Condition',
                              'Total Amount',
                              'Payment',
                              'Amount Left',
                              'Color Payment'
                            ],
                            data: [],
                          );
                        },
                      )
                    : Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget receivableDataTable(BuildContext context) {
  final con = Get.put(ReceivableController());

  Color getRowColor(String colorPayment) {
    if (colorPayment == "Black") {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Obx(
        () => AppText.title(
          context,
          txt: 'Total Record: ${con.filteredRece.length}',
        ),
      ),
      SizedBox(height: 2.px),
      AppDataTableReceivable(
        source: con.filteredRece,
        columnHeaders: [
          DataTableWidget.column(context, 'ID'),
          DataTableWidget.column(context, 'Saleman'),
          DataTableWidget.column(context, 'Date'),
          DataTableWidget.column(context, 'Name'),
          DataTableWidget.column(context, 'Telephone 1'),
          DataTableWidget.column(context, 'Telephone 2'),
          DataTableWidget.column(context, 'Telephone 3'),
          DataTableWidget.column(context, 'Next Payment'),
          DataTableWidget.column(context, 'Document'),
          DataTableWidget.column(context, 'Brand'),
          DataTableWidget.column(context, 'Model'),
          DataTableWidget.column(context, 'Color'),
          DataTableWidget.column(context, 'Year'),
          DataTableWidget.column(context, 'Condition'),
          DataTableWidget.column(context, 'Total Amount'),
          DataTableWidget.column(context, 'Receive Payment'),
          DataTableWidget.column(context, 'Amount Left'),
          DataTableWidget.column(context, 'Color Payment'),
          DataTableWidget.column(context, 'Action'),
        ],
        rowData: List.generate(
          con.filteredRece.length,
          (index) {
            var data = con.filteredRece[index];
            return [
              DataTableWidget.cell(
                Get.context!,
                '${data['id']}',
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['saleman'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['date'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['name'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['tel1'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['tel2'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['tel3'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['nextPayment'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['document'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['brand'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['model'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['color'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['year'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['condition'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['total'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['receiveAmount'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['amountLeft'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cell(
                Get.context!,
                data['colorPayment'],
                color: getRowColor(data['colorPayment']),
              ),
              DataTableWidget.cellBtn(
                Get.context!,
                btnEdit: false,
                btnDelete: false,
                btnPrint: true,
                //btnAddPayment: conToNum(data['amountLeft']) > 0 ? true : false,
                btnAddPayment: true,
                btnViewPayment: true,
                edit: () => debugPrint('Edit $index'),
                delete: () => debugPrint('Delete $index'),
                print: () => printPaymentTable(data['id']),
                addPayment: () async {
                  byPaymentTable.clear();
                  con.scheduleList.clear();
                  con.clearText();
                  con.totalAmount.value.text = data['total'];
                  con.paidAmount.value.text = data['receiveAmount'];
                  con.leftAmount.value.text = data['amountLeft'];

                  await getByPaymentTable(data['id']);
                  for (var data in byPaymentTable) {
                    if (data.date != '' && data.paid == '') {
                      con.scheduleList.add(data.date);
                    }
                  }
                  con.showDialogAddPayment(Get.context!, data['id']);
                },
                viewPayment: () async {
                  byPaymentTable.clear();
                  con.clearText();
                  await getByPaymentTable(data['id']);
                  con.showDialogViewPayment(Get.context!);
                },
              ),
            ];
          },
        ),
      ),
    ],
  );
}
