import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/add_stock_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddStockScreen extends StatelessWidget {
  AddStockScreen({super.key});

  final con = Get.put(AddStockController());

  final condition = ['New', 'Used'];

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
            TitleUnderline(spacer: spacer(context), txt: 'Stock Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdown(
                txt: 'Model',
                value: con.model,
                list: con.listModel,
                onChanged: (v) {
                  if (v != null) con.model = v;
                },
              ),
              widget2: AppTextField(
                txt: 'Brand',
                con: con.brand.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Year',
                con: con.proYear.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdown(
                txt: 'Condition',
                value: con.condition,
                list: condition,
                onChanged: (v) {
                  if (v != null) con.condition = v;
                },
              ),
              widget2: AppTextField(
                txt: 'Date In',
                con: con.dateIn.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Q Begin',
                con: con.qBegin.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Price',
                con: con.priceQBegin.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Total Price',
                con: con.totalPriceQBegin.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Add',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Date In', con: con.date.value),
              widget2: AppTextField(txt: 'Qty', con: con.qty.value),
              widget3: AppTextField(txt: 'Price', con: con.price.value),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Total Price',
                con: con.totalPrice.value,
                readOnly: true,
              ),
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
