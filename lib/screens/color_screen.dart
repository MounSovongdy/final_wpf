import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/color_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_color_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table_second.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ColorScreen extends StatelessWidget {
  ColorScreen({super.key});

  final con = Get.put(ColorController());
  final conNC = Get.put(NewColorController());
  final conMain = Get.put(MainController());

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
            AppText.header(context, txt: 'Color List | បញ្ជីពណ៌'),
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
              () => con.filteredColor.isNotEmpty
                  ? colorDataTable(context)
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
                    conNC.clearText();
                    con.title.value = 'Create Color | បង្កើតពណ៌ថ្មី';
                    conMain.index.value = 49;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget colorDataTable(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Obx(
          () => AppText.title(
            context,
            txt: 'Total Record: ${con.filteredColor.length}',
          ),
        ),
        SizedBox(height: 2.px),
        AppDataTableSecond(
          columnHeaders: [
            DataTableWidget.column(context, 'ID'),
            DataTableWidget.column(context, 'Color'),
            DataTableWidget.column(context, 'Action'),
          ],
          rowData: List.generate(
            con.filteredColor.length,
            (index) {
              var data = con.filteredColor[index];

              return [
                DataTableWidget.cell(Get.context!, '${data.id}'),
                DataTableWidget.cell(Get.context!, data.color),
                DataTableWidget.cellBtn(
                  Get.context!,
                  btnDelete: false,
                  edit: () async {
                    startInactivityTimer();
                    conNC.clearText();
                    con.title.value = 'Edit Color';
                    await con.editColor(data.id);

                    conMain.index.value = 49;
                  },
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}
