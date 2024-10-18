import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/sale_report_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SaleReportScreen extends StatelessWidget {
  SaleReportScreen({super.key});

  final con = Get.put(SaleReportController());
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
          AppText.header(context, txt: 'Sales Report'),
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
          Scrollbar(
            controller: scroll,
            interactive: true,
            child: SingleChildScrollView(
              controller: scroll,
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => AppDataTable(
                  column: [
                    DataTableWidget.dataColumn(context, 'No'),
                    DataTableWidget.dataColumn(context, 'Booking Date'),
                    DataTableWidget.dataColumn(context, 'Sold Date'),
                    DataTableWidget.dataColumn(context, 'Working Period'),
                    DataTableWidget.dataColumn(context, 'ID Card'),
                    DataTableWidget.dataColumn(context, 'Customer Name'),
                    DataTableWidget.dataColumn(context, 'Telephone'),
                    DataTableWidget.dataColumn(context, 'Gender'),
                    DataTableWidget.dataColumn(context, 'Age'),
                    DataTableWidget.dataColumn(context, 'Address'),
                    DataTableWidget.dataColumn(context, 'Micro'),
                    DataTableWidget.dataColumn(context, 'Model'),
                    DataTableWidget.dataColumn(context, 'Price'),
                    DataTableWidget.dataColumn(context, 'Account Revivable'),
                    DataTableWidget.dataColumn(context, 'Cost Price'),
                    DataTableWidget.dataColumn(context, 'Gain'),
                    DataTableWidget.dataColumn(context, 'Bank Revivable'),
                    DataTableWidget.dataColumn(context, 'Method'),
                    DataTableWidget.dataColumn(context, 'Salesman'),
                    DataTableWidget.dataColumn(context, 'Introduced by'),
                    DataTableWidget.dataColumn(context, 'Commission fee'),
                    DataTableWidget.dataColumn(context, 'Contact'),
                  ],
                  row: List.generate(
                    con.filteredUsers.length,
                    (index) => DataRow(
                      cells: [
                        DataTableWidget.dataRowTxt(
                          context,
                          con.filteredUsers[index].id,
                        ),
                        DataTableWidget.dataRowTxt(
                          context,
                          con.filteredUsers[index].name,
                        ),
                        DataTableWidget.dataRowTxt(
                          context,
                          con.filteredUsers[index].role,
                        ),
                        DataTableWidget.dataRowBtn(
                          context,
                          edit: () => debugPrint('Edit $index'),
                          delete: () => debugPrint('Delete $index'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                txt: 'Print Report',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
