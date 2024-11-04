import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/gift_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_gift_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_date_text_field.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewGiftScreen extends StatelessWidget {
  NewGiftScreen({super.key});

  final con = Get.put(NewGiftController());
  final conGift = Get.put(GiftController());
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
            AppText.header(context, txt: conGift.title.value),
            spacer(context),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDateTextField(
                txt: 'Date',
                con: con.date.value,
              ),
              widget2: AppTextField(
                txt: 'Item',
                con: con.item.value,
              ),
              widget3: AppTextField(
                txt: 'Amount',
                con: con.amount.value,
                isNumber: true,
                digit: 6,
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
                AppButtonSubmit(
                  txt: 'Back',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                    LoadingWidget.dialogLoading(
                      duration: 5,
                      isBack: false,
                    );
                    await getAllGift();
                    conGift.monthList.clear();
                    if (gift.isNotEmpty) {
                      for (var data in gift) {
                        conGift.monthList.add('${data.year}-${data.month}');
                      }
                      conGift.monthList.value =
                          conGift.monthList.toSet().toList();
                      conGift.selectedMonth.value = conGift.monthList[0];
                      conGift.filteredGift.clear();
                      await getByDateGift(
                        conGift.selectedMonth.value!.split('-')[0],
                        conGift.selectedMonth.value!.split('-')[1],
                      );
                    }
                    conGift.filteredGift.value = gift;
                    conGift.search.value.addListener(conGift.filterGiftData);
                    Get.back();

                    conMain.index.value = conMain.index.value - 1;
                  },
                ),
                spacer(context),
                spacer(context),
                AppButtonSubmit(
                  txt: 'Save',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                    con.createGift(context);
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
