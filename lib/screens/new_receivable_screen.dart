import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_receivable_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewReceivableScreen extends StatelessWidget {
  NewReceivableScreen({super.key});

  final con = Get.put(NewReceivableController());
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
            AppText.header(context, txt: 'New Receivable'),
            spacer(context),
            TitleUnderline(spacer: spacer(context), txt: 'Customer Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'ID Card', con: con.name.value),
              widget2: AppTextField(txt: 'Name', con: con.name.value,readOnly: true,),
              widget3: AppTextField(txt: 'Address', con: con.address.value,readOnly: true,),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Phone 1', con: con.phoneCus1.value,readOnly: true,),
              widget2: AppTextField(txt: 'Phone 2', con: con.phoneCus2.value,),
              widget3: AppTextField(txt: 'Phone 3', con: con.phoneCus3.value,),
            ),

            TitleUnderline(spacer: spacer(context), txt: 'Sell Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Sell Date', con: con.dateBooking.value,readOnly: true,),
              widget2: AppTextField(txt: 'Salesman', con: con.salesman.value,readOnly: true,),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Product Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Model', con: con.model.value,readOnly: true,),
              widget2: AppTextField(txt: 'Year', con: con.year.value,readOnly: true,),
              widget3: AppTextField(txt: 'Condition', con: con.condition.value,readOnly: true,),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Engine No', con: con.engine.value,readOnly: true,),
              widget2: AppTextField(txt: 'Frame No', con: con.frame.value,readOnly: true,),
              widget3: AppTextField(txt: 'Plate No', con: con.plateNo.value,readOnly: true,),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Financial Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Total Debt', con: con.totalOwn.value),
              widget2: AppTextField(txt: 'Amount Left', con: con.amountLeft.value),
              widget3: AppTextField(txt: 'Rate', con: con.rate.value),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Term', con: con.term.value),
              widget2: AppTextField(txt: 'First Payment Date', con: con.firstPayDate.value),
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
