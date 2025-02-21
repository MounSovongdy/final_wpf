import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/address_controller.dart';
import 'package:motor/controllers/create_address_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table_second.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});

  final con = Get.put(AddressController());
  final conCA = Get.put(CreateAddressController());
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
            AppText.header(context, txt: 'Address List | បញ្ជីអាស័យដ្ខាន'),
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
              () => con.filteredAddress.isNotEmpty
                  ? addressDataTable(context)
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
                    conCA.clearText();
                    con.title.value = 'Create Address | បង្កើតអាស័យដ្ខាន';

                    conMain.index.value = 28;
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

Widget addressDataTable(BuildContext context) {
  final con = Get.put(AddressController());
  final conA = Get.put(CreateAddressController());
  final conMain = Get.put(MainController());

  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Obx(
        () => AppText.title(
          context,
          txt: 'Total Record: ${con.filteredAddress.length}',
        ),
      ),
      SizedBox(height: 2.px),
      AppDataTableSecond(
        columnHeaders: [
          DataTableWidget.column(context, 'ID'),
          DataTableWidget.column(context, 'Address'),
          DataTableWidget.column(context, 'Action'),
        ],
        rowData: List.generate(
          con.filteredAddress.length,
          (index) {
            var data = con.filteredAddress[index];
            return [
              DataTableWidget.cell(Get.context!, '${data.id}'),
              DataTableWidget.cell(Get.context!, data.address),
              DataTableWidget.cellBtn(
                Get.context!,
                edit: () async {
                  startInactivityTimer();
                  conA.clearText();
                  con.title.value = 'Edit Address | កែប្រែអាស័យដ្ខាន';
                  await con.editAddress(data.id);

                  conMain.index.value = 28;
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
                        await deleteAddress(con.filteredAddress[index].id);
                        con.filteredAddress.clear();
                        await getAllAddress();
                        con.filteredAddress.value = address;

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
