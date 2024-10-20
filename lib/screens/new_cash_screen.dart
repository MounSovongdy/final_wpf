import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/new_cash_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewCashScreen extends StatelessWidget {
  NewCashScreen({super.key});

  final con = Get.put(CashController());

  final gender = ['Male', 'Female'];
  final salesman = ['Thol', 'Sora','Piseth'];
  final brand = ['Honda', 'Suzuki','Yamaha'];
  final model = ['Dream','Best','Scoopy'];
  final color = ['Red', 'Black', 'Blue'];
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
            AppText.header(context, txt: 'Cash'),
            spacer(context),
            TitleUnderline(spacer: spacer(context), txt: 'Sell Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Date', con: con.dateBooking.value),
              widget2: AppDropdown(txt: 'Salesman', list: salesman, onChanged: (v){
                if (v != null) con.salesman = v;
              },),
            ),
            TitleUnderline(
                spacer: spacer(context), txt: 'Customer Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'ID Card', con: con.name.value),
              widget2: AppTextField(txt: 'Name', con: con.name.value),
              widget3: AppDropdown(
                txt: 'Gender',
                value: con.gender,
                list: gender,
                onChanged: (v) {
                  if (v != null) con.gender = v;
                },
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Age', con: con.age.value),
              widget2: AppTextField(txt: 'Tel', con: con.phoneCus.value),
              widget3: AppTextField(txt: 'Address', con: con.address.value),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Product Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdown(
                txt: 'Brand',
                list: brand,
                onChanged: (v) {
                  if (v != null) con.brand = v;
                },
              ),
              widget2: AppDropdown(
                txt: 'Model',
                list: model,
                onChanged: (v) {
                  if (v != null) con.model = v;
                },
              ),
              widget3: AppDropdown(
                txt: 'Color',
                list: color,
                onChanged: (v) {
                  if (v != null) con.color = v;
                },
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Year', con: con.year.value),
              widget2: AppDropdown(
                txt: 'Condition',
                list: condition,
                onChanged: (v) {
                  if (v != null) con.condition = v;
                },
              ),
              widget3: AppTextField(txt: 'Engine No', con: con.engine.value),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Frame No', con: con.frame.value),
              widget2: AppTextField(txt: 'Plate No', con: con.plateNo.value),
            ),
            TitleUnderline(
                spacer: spacer(context), txt: 'Financial Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Sell Price', con: con.sell.value),
              widget2: AppTextField(txt: 'Discount', con: con.discount.value),
              widget3: AppTextField(
                txt: 'Total Price',
                con: con.totalPrice.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(
                spacer: spacer(context), txt: 'Introduced Information'),
            RowTextField(spacer: spacer(context),
              widget1: AppTextField(txt: 'Come By', con: con.comeBy.value),
              widget2: AppTextField(txt: 'Name', con: con.nameIntro.value),
              widget3: AppTextField(txt: 'Tel', con: con.phoneIntro.value),
            ),
            RowTextField(spacer: spacer(context),
              widget1: AppTextField(txt: 'Commission fee', con: con.commission.value),
            ),
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
