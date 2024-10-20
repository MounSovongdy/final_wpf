import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/micro_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MicroScreen extends StatelessWidget {
  MicroScreen({super.key});

  final con = Get.put(MicroController());
  final con1 = Get.put(MainController());
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
          AppText.header(context, txt: 'Micro List'),
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
            () => con.filteredMicro.isNotEmpty
                ? AppDataTable(
                    column: [
                      DataTableWidget.column(context, 'ID'),
                      DataTableWidget.column(context, 'Micro Name'),
                      DataTableWidget.column(context, 'Tel'),
                      DataTableWidget.column(context, 'Email'),
                      DataTableWidget.column(context, 'Teacher Name'),
                      DataTableWidget.column(context, 'Teacher Tel'),
                      DataTableWidget.column(context, 'Teacher Email'),
                      DataTableWidget.column(context, 'Position'),
                      DataTableWidget.column(context, 'Bonus'),
                      DataTableWidget.column(context, 'Actions'),
                    ],
                    source: MicroDataSource(),
                  )
                : Container(
                    width: 100.px,
                    alignment: Alignment.center,
                    child: AppText.title(context, txt: "No Date"),
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
                  con1.index.value = 20;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MicroDataSource extends DataTableSource {
  final con = Get.put(MicroController());
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
          '${con.filteredMicro[index].id}',
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredMicro[index].name,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredMicro[index].tel,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredMicro[index].email,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredMicro[index].contactName,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredMicro[index].contactTel,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredMicro[index].contactEmail,
        ),
             DataTableWidget.cell(
          Get.context!,
          con.filteredMicro[index].contactPosition,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredMicro[index].tBonus,
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
                  deleteMicro(con.filteredMicro[index].id);
                  con.filteredMicro.clear();
                  await getAllMicro();
                  con.filteredMicro.value = micro;
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
  int get rowCount => con.filteredMicro.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
