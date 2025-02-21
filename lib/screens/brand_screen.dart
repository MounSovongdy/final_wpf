import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/brand_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_brand_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table_second.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BrandScreen extends StatelessWidget {
  BrandScreen({super.key});

  final con = Get.put(BrandController());
  final conNB = Get.put(NewBrandController());
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
            AppText.header(context, txt: 'Brand List | បញ្ជីម៉ាក'),
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
              () => con.filteredBrand.isNotEmpty
                  ? brandDataTable(context)
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
                  txt: 'New | បង្កើត',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                    conNB.clearText();
                    con.title.value = 'Create Brand';
                    conMain.index.value = 47;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget brandDataTable(BuildContext context) {
    final con = Get.put(BrandController());
    final conNB = Get.put(NewBrandController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Obx(
          () => AppText.title(
            context,
            txt: 'Total Record: ${con.filteredBrand.length}',
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
            con.filteredBrand.length,
            (index) {
              var data = con.filteredBrand[index];

              return [
                DataTableWidget.cell(Get.context!, '${data.id}'),
                DataTableWidget.cell(Get.context!, data.brand),
                DataTableWidget.cellBtn(
                  Get.context!,
                  btnDelete: false,
                  edit: () async {
                    startInactivityTimer();
                    conNB.clearText();
                    con.title.value = 'Edit Brand';
                    await con.editBrand(data.id);

                    conMain.index.value = 47;
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
