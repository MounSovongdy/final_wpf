import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/create_micro_controller.dart';
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
  final conCM = Get.put(CreateMicroController());
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
          AppText.header(context, txt: 'Micro List | បញ្ជីស្ថាប័ន'),
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
            () => con.filteredMicro.isNotEmpty
                ? microDataTable(context)
                : Container(
                    width: 100.px,
                    alignment: Alignment.center,
                    child: AppText.title(context, txt: "No Date | គ្មានទិន្នន័យ"),
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
                  conCM.clearText();
                  con.title.value = 'Create Micro';
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

Widget microDataTable(BuildContext context) {
  final con = Get.put(MicroController());
  final conCM = Get.put(CreateMicroController());
  final conMain = Get.put(MainController());

  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Obx(
        () => AppText.title(
          context,
          txt: 'Total Record: ${con.filteredMicro.length}',
        ),
      ),
      SizedBox(height: 2.px),
      AppDataTable(
        columnHeaders: [
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
        rowData: List.generate(
          con.filteredMicro.length,
          (index) {
            var data = con.filteredMicro[index];
            return [
              DataTableWidget.cell(Get.context!, '${data.id}'),
              DataTableWidget.cell(Get.context!, data.name),
              DataTableWidget.cell(Get.context!, data.tel),
              DataTableWidget.cell(Get.context!, data.email),
              DataTableWidget.cell(Get.context!, data.contactName),
              DataTableWidget.cell(Get.context!, data.contactTel),
              DataTableWidget.cell(Get.context!, data.contactEmail),
              DataTableWidget.cell(Get.context!, data.contactPosition),
              DataTableWidget.cell(Get.context!, data.tBonus),
              DataTableWidget.cellBtn(
                Get.context!,
                edit: () async {
                  startInactivityTimer();
                  conCM.clearText();
                  con.title.value = 'Edit Micro';
                  await con.editMicro(data.id);
                  conMain.index.value = 20;
                },
                delete: () {
                  startInactivityTimer();
                  LoadingWidget.showTextDialog(
                    Get.context!,
                    title: 'Warning | ការព្រមាន',
                    content: 'Are you sure to delete?',
                    color: redColor,
                    txtBack: 'Cancel',
                    btnColor: secondGreyColor,
                    widget: TextButton(
                      onPressed: () async {
                        await deleteMicro(con.filteredMicro[index].id);
                        con.filteredMicro.clear();
                        await getAllMicro();
                        con.filteredMicro.value = micro;
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
