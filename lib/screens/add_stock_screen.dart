import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddStockScreen extends StatelessWidget {
  AddStockScreen({super.key});

  final con = Get.put(MainController());

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
            AppText.header(context, txt: 'Add Stock'),
            spacer(context),
            TitleUnderline(spacer: spacer(context), txt: 'Product Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Type', con: con.type.value),
              widget2: AppTextField(txt: 'Brand', con: con.proBrand.value),
              widget3: AppTextField(txt: 'Model', con: con.proModel.value),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Year', con: con.proYear.value),
              widget2: AppTextField(txt: 'Color', con: con.proColor.value),
              widget3: AppTextField(txt: 'Condition', con: con.proCondi.value),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'QTY', con: con.qty.value),
              widget2: AppTextField(txt: 'Arrive Date', con: con.arrDate.value),
              widget3: AppTextField(txt: 'Description', con: con.descr.value),
            ),
            TitleUnderline(
                spacer: spacer(context), txt: 'Financial Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Cost', con: con.finanCost.value),
              widget2: AppTextField(txt: 'Sell', con: con.finanSell.value),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Product Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Status', con: con.proSts.value),
              widget2: AppTextField(txt: 'Description', con: con.proDes.value),
            ),
            spacer(context),
            spacer(context),
            spacer(context),
            const UnderLine(color: secondGreyColor),
            spacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  txt: 'Cancel',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () {},
                ),
                spacer(context),
                spacer(context),
                AppButton(
                  txt: 'Save',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
