import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/sale_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SaleRecordScreen extends StatelessWidget {
  SaleRecordScreen({super.key});

  final con = Get.put(SaleController());

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
            AppText.header(context, txt: 'Sale Record'),
            spacer,
            TitleUnderline(spacer: spacer, txt: 'Customer Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'ID Card', con: con.name.value),
              widget2: AppTextField(txt: 'Name', con: con.name.value,readOnly: true,),
              widget3: AppTextField(txt: 'Gender', con: con.gender.value,readOnly: true,),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Age', con: con.age.value,readOnly: true,),
              widget2: AppTextField(txt: 'Tel', con: con.phoneCus.value,readOnly: true,),
              widget3: AppTextField(txt: 'Address', con: con.address.value,readOnly: true,),
            ),
            TitleUnderline(spacer: spacer, txt: 'Booking Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Date', con: con.dateBooking.value,readOnly: true,),
              widget2: AppTextField(txt: 'Method', con: con.method.value,readOnly: true,),
              widget3: AppTextField(txt: 'Micro', con: con.micro.value,readOnly: true,),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Salesman', con: con.salesman.value,readOnly: true,),
            ),
            TitleUnderline(spacer: spacer, txt: 'Product Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Brand', con: con.brand.value,readOnly: true,),
              widget2: AppTextField(txt: 'Model', con: con.model.value,readOnly: true,),
              widget3: AppTextField(txt: 'Color', con: con.color.value,readOnly: true,),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Year', con: con.year.value,readOnly: true,),
              widget2: AppTextField(txt: 'Condition', con: con.condition.value,readOnly: true,),
              widget3: AppTextField(txt: 'Engine No', con: con.engine.value),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Frame No', con: con.frame.value),
              widget2: AppTextField(txt: 'Plate No', con: con.plateNo.value),
            ),
            TitleUnderline(spacer: spacer, txt: 'Financial Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Sell Price', con: con.sell.value,readOnly: true,),
              widget2: AppTextField(txt: 'Discount', con: con.discount.value,readOnly: true,),
              widget3: AppTextField(txt: 'Deposit', con: con.deposit.value,readOnly: true,),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Remain', con: con.remain.value,readOnly: true,),
            ),
            TitleUnderline(spacer: spacer, txt: 'Introduced Information'),
            RowTextField(spacer: spacer,
              widget1: AppTextField(txt: 'Name', con: con.nameIntro.value,readOnly: true,),
              widget2: AppTextField(txt: 'Tel', con: con.phoneIntro.value,readOnly: true,),
            ),
            spacer,
            spacer,
            spacer,
            const UnderLine(color: secondGreyColor),
            spacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  txt: 'Cancel',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () {},
                ),
                spacer,
                spacer,
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
