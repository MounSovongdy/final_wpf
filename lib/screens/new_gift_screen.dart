import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/gift_controller.dart';
import 'package:motor/controllers/new_gift_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewGiftScreen extends StatelessWidget {
  NewGiftScreen({super.key});

  final con = Get.put(NewGiftController());
  final conGift = Get.put(GiftController());

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
            AppText.header(context, txt: conGift.title.value),
            spacer(context),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Date', con: con.date.value),
              widget2: AppTextField(txt: 'Title', con: con.name.value),
              widget3: AppTextField(txt: 'Amount', con: con.amount.value),
            ),
            spacer(context),
            spacer(context),
            spacer(context),
            const UnderLine(color: secondGreyColor),
            spacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButtonSubmit(
                  txt: 'Back',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                  },
                ),
                spacer(context),
                spacer(context),
                AppButtonSubmit(
                  txt: 'Save',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
