import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/finance_record_controller.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/finance_card.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FinancialRecordScreen extends StatelessWidget {
  FinancialRecordScreen({super.key});

  final con = Get.put(FinanceRecordController());

  @override
  Widget build(BuildContext context) {
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
            AppText.header(context, txt: 'Financial Record'),
            RowTextField(
              spacer: spacer(context),
              widget3: AppDropdownSearch(
                txt: 'Select Month',
                value: con.selectedMonth,
                list: con.monthList,
                onChanged: (v) {},
              ),
            ),
            spacer(context),
            spacer(context),
            FinanceCard(),
          ],
        ),
      ),
    );
  }
}
