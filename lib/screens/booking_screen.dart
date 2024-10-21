import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/booking_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_booking_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  final con = Get.put(BookingController());
  final conMain = Get.put(MainController());
  final conNewBook = Get.put(NewBookingController());

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
          AppText.header(context, txt: 'Booking List'),
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
              DataTableWidget.column(context, 'Brand'),
              DataTableWidget.column(context, 'Model'),
              DataTableWidget.column(context, 'Color'),
              DataTableWidget.column(context, 'Year'),
              DataTableWidget.column(context, 'Condition'),
              DataTableWidget.column(context, 'Price'),
              DataTableWidget.column(context, 'Discount'),
              DataTableWidget.column(context, 'Deposit'),
              DataTableWidget.column(context, 'Remain'),
              DataTableWidget.column(context, 'Method'),
              DataTableWidget.column(context, 'Micro'),
              DataTableWidget.column(context, 'Salesman'),
              DataTableWidget.column(context, 'Status'),
              DataTableWidget.column(context, 'Action'),
            ],
            source: BookingDataSource(),
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
                  conNewBook.clearText();
                  conNewBook.date.value.text = '$dateNow $timeNow';
                  conNewBook.discount.value.text = '0';
                  await microName();
                  await saleManName();
                  await brandName();

                  startInactivityTimer();
                  conMain.index.value = 2;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> microName() async {
    conNewBook.microList.clear();
    await getAllMicro();
    for (var data in micro) {
      conNewBook.microList.add(data.name);
    }
  }

  Future<void> saleManName() async {
    conNewBook.saleManList.clear();
    await getAllSaleMan();
    for (var data in saleMan) {
      conNewBook.saleManList.add(data.name);
    }
  }

  Future<void> brandName() async {
    conNewBook.brandList.clear();
    await getAllBrand();
    for (var data in brand) {
      conNewBook.brandList.add(data.brand);
    }
  }
}

class BookingDataSource extends DataTableSource {
  final con = Get.put(BookingController());
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
        DataTableWidget.cellBtn(
          Get.context!,
          edit: () => debugPrint('Edit $index'),
          delete: () => debugPrint('Delete $index'),
        ),
      ],
    );
  }

  @override
  int get rowCount => con.filteredUsers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
