import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TotalStockScreen extends StatelessWidget {
  const TotalStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var spacer = SizedBox(
      height: Responsive.isDesktop(context) ? defWebPad : defMobPad,
      width: Responsive.isDesktop(context) ? defWebPad : defMobPad,
    );

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: 'Total Stock'),
            spacer,
            AppDataTable(
              column: [
                DataTableWidget.dataColumn(context, 'ID'),
                DataTableWidget.dataColumn(context, 'Full Name'),
              ],
              row: List.generate(
                user.length,
                (index) => DataRow(cells: [
                  DataTableWidget.dataRow(context, user[index].id),
                  DataTableWidget.dataRow(context, user[index].name),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
