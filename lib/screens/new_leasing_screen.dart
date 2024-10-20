import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_leasing_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewLeasingScreen extends StatelessWidget {
  NewLeasingScreen({super.key});

  final con = Get.put(NewLeasingController());
  final conMain = Get.put(MainController());

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
            AppText.header(context, txt: 'New Leasing'),
            spacer(context),
            TitleUnderline(spacer: spacer(context), txt: 'Customer Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'ID Card', con: con.name.value),
              widget2: AppTextField(txt: 'Name', con: con.name.value,readOnly: true,),
              widget3: AppTextField(txt: 'Gender', con: con.gender.value,readOnly: true,),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Age', con: con.age.value,readOnly: true,),
              widget2: AppTextField(txt: 'Tel', con: con.phoneCus.value,readOnly: true,),
              widget3: AppTextField(txt: 'Address', con: con.address.value,readOnly: true,),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Booking Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Date', con: con.dateBooking.value,readOnly: true,),
              widget2: AppTextField(txt: 'Micro', con: con.micro.value,readOnly: true,),
              widget3: AppTextField(txt: 'Salesman', con: con.salesman.value,readOnly: true,),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Product Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Model', con: con.model.value,readOnly: true,),
              widget2: AppTextField(txt: 'Brand', con: con.brand.value,readOnly: true,),
              widget3: AppTextField(txt: 'Color', con: con.color.value,readOnly: true,),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Year', con: con.year.value,readOnly: true,),
              widget2: AppTextField(txt: 'Condition', con: con.condition.value,readOnly: true,),
              widget3: AppTextField(txt: 'Engine No', con: con.engine.value),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Frame No', con: con.frame.value),
              widget2: AppTextField(txt: 'Plate No', con: con.plateNo.value),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Financial Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Sell Price', con: con.sell.value,readOnly: true,),
              widget2: AppTextField(txt: 'Discount', con: con.discount.value,readOnly: true,),
              widget3: AppTextField(txt: 'Deposit', con: con.deposit.value,readOnly: true,),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Remain', con: con.remain.value,readOnly: true,),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Introduced Information'),
            RowTextField(spacer: spacer(context),
              widget1: AppTextField(txt: 'Come By', con: con.comeBy.value,readOnly: true,),
              widget2: AppTextField(txt: 'Name', con: con.nameIntro.value,readOnly: true,),
              widget3: AppTextField(txt: 'Tel', con: con.phoneIntro.value,readOnly: true,),
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
                  tap: () {
                    startInactivityTimer();
                    conMain.index.value = conMain.index.value - 1;
                  },
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
