import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/leasing_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_leasing_controller.dart';
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
          AppText.header(context, txt: 'Leasing List'),
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
          AppDataTable(
            column: [
              DataTableWidget.column(context, 'No'),
              DataTableWidget.column(context, 'Booking Date'),
              DataTableWidget.column(context, 'ID Card'),
              DataTableWidget.column(context, 'Customer Name'),
              DataTableWidget.column(context, 'Gender'),
              DataTableWidget.column(context, 'Age'),
              DataTableWidget.column(context, 'Telephone'),
              DataTableWidget.column(context, 'Address'),
              DataTableWidget.column(context, 'Model'),
              DataTableWidget.column(context, 'Brand'),
              DataTableWidget.column(context, 'Color'),
              DataTableWidget.column(context, 'Year'),
              DataTableWidget.column(context, 'Condition'),
              DataTableWidget.column(context, 'Engine No'),
              DataTableWidget.column(context, 'Frame No'),
              DataTableWidget.column(context, 'Plate No'),
              DataTableWidget.column(context, 'Price'),
              DataTableWidget.column(context, 'Discount'),
              DataTableWidget.column(context, 'Deposit'),
              DataTableWidget.column(context, 'Remain'),
              DataTableWidget.column(context, 'Method'),
              DataTableWidget.column(context, 'Micro'),
              DataTableWidget.column(context, 'Salesman'),
              DataTableWidget.column(context, 'Come by'),
              DataTableWidget.column(context, 'Introduced Name'),
              DataTableWidget.column(context, 'Introduced Tel'),
              DataTableWidget.column(context, 'Commission fee'),
              DataTableWidget.column(context, 'Action'),
            ],
            source: LeasingDataSource(),
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
                tap: () async {
                  startInactivityTimer();
                  conNL.clearText();
                  await con.getBookingIDandIDCard();
                  await brandName();

                  conMain.index.value = 22;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> brandName() async {
    conNL.brandList.clear();
    await getAllBrand();
    for (var data in brand) {
      conNL.brandList.add(data.brand);
    }
  }
}

class LeasingDataSource extends DataTableSource {
  final con = Get.put(LeasingController());

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= rowCount) return null;

    return DataRow.byIndex(
      index: index,
      cells: [
        DataTableWidget.cell(
          Get.context!,
          '${con.filteredUsers[index].id}',
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredUsers[index].name,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredUsers[index].role,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredUsers[index].user,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredUsers[index].dateCreate,
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
                onPressed: () {},
                child: AppText.title(Get.context!, txt: 'Confirm'),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  int get rowCount => con.filteredUsers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
