import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/receivable_controller.dart';
import 'package:motor/screens/booking_screen.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
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
          AppDataTable(
            column: [
              DataTableWidget.column(context, 'No'),
              DataTableWidget.column(context, 'Receivable  Date'),
              DataTableWidget.column(context, 'ID Card'),
              DataTableWidget.column(context, 'Customer Name'),
              DataTableWidget.column(context, 'Address'),
              DataTableWidget.column(context, 'Telephone 1'),
              DataTableWidget.column(context, 'Telephone 2'),
              DataTableWidget.column(context, 'Telephone 3'),
              DataTableWidget.column(context, 'Model'),
              DataTableWidget.column(context, 'Year'),
              DataTableWidget.column(context, 'Engine No'),
              DataTableWidget.column(context, 'Frame No'),
              DataTableWidget.column(context, 'Plate No'),
              DataTableWidget.column(context, 'Total Debt'),
              DataTableWidget.column(context, 'Amount Left'),
              DataTableWidget.column(context, 'Rate'),
              DataTableWidget.column(context, 'Term'),
              DataTableWidget.column(context, 'First Payment'),
              DataTableWidget.column(context, 'Salesman'),

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
                  startInactivityTimer();
                  conMain.index.value = 7;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
