import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/receivable_controller.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReceivableScreen extends StatelessWidget {
  ReceivableScreen({super.key});

  final con = Get.put(ReceivableController());
  final conMain = Get.put(MainController());

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
                ? AppDataTable(
                    column: [
                      DataTableWidget.column(context, 'ID'),
                      DataTableWidget.column(context, 'Saleman'),
                      DataTableWidget.column(context, 'Receivable Date'),
                      DataTableWidget.column(context, 'Name'),
                      DataTableWidget.column(context, 'Telephone 1'),
                      DataTableWidget.column(context, 'Telephone 2'),
                      DataTableWidget.column(context, 'Telephone 3'),
                      DataTableWidget.column(context, 'Document'),
                      DataTableWidget.column(context, 'Brand'),
                      DataTableWidget.column(context, 'Model'),
                      DataTableWidget.column(context, 'Color'),
                      DataTableWidget.column(context, 'Year'),
                      DataTableWidget.column(context, 'Condition'),
                      DataTableWidget.column(context, 'Total Amount'),
                      DataTableWidget.column(context, 'Receive Payment'),
                      DataTableWidget.column(context, 'Amount Left'),
                      DataTableWidget.column(context, 'Action'),
                    ],
                    source: ReceivableDataSource(),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: defWebPad.px),
                    alignment: Alignment.center,
                    child: AppText.title(context, txt: 'No Data'),
                  ),
          ),
        ],
      ),
    );
  }
}

class ReceivableDataSource extends DataTableSource {
  final con = Get.put(ReceivableController());

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= con.filteredRece.length) return null;

    var data = con.filteredRece[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataTableWidget.cell(Get.context!, '${data.id}'),
        DataTableWidget.cell(Get.context!, data.saleman),
        DataTableWidget.cell(Get.context!, data.date),
        DataTableWidget.cell(Get.context!, data.name),
        DataTableWidget.cell(Get.context!, data.tel1),
        DataTableWidget.cell(Get.context!, data.tel2),
        DataTableWidget.cell(Get.context!, data.tel3),
        DataTableWidget.cell(Get.context!, data.document),
        DataTableWidget.cell(Get.context!, data.brand),
        DataTableWidget.cell(Get.context!, data.model),
        DataTableWidget.cell(Get.context!, data.color),
        DataTableWidget.cell(Get.context!, data.year),
        DataTableWidget.cell(Get.context!, data.condition),
        DataTableWidget.cell(Get.context!, data.total),
        DataTableWidget.cell(Get.context!, data.receiveAmount),
        DataTableWidget.cell(Get.context!, data.amountLeft),
        DataTableWidget.cellBtn(
          Get.context!,
          btnEdit: false,
          btnDelete: false,
          btnAddPayment: true,
          btnViewPayment: true,
          edit: () => debugPrint('Edit $index'),
          delete: () => debugPrint('Delete $index'),
          print: () => debugPrint('Print $index'),
          addPayment: () => con.showDialogAddPayment(Get.context!),
          viewPayment: () async {
            byPaymentTable.clear();
            await getByPaymentTable(data.id);
            con.showDialogViewPayment(Get.context!);
          },
        ),
      ],
    );
  }

  @override
  int get rowCount => con.filteredRece.length;
  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
