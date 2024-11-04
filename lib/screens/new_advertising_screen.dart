import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/advertising_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_advertising_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_date_text_field.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewAdvertisingScreen extends StatelessWidget {
  NewAdvertisingScreen({super.key});

  final con = Get.put(NewAdvertisingController());
  final conAdv = Get.put(AdvertisingController());
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
            AppText.header(context, txt: conAdv.title.value),
            spacer(context),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDateTextField(
                txt: 'Date',
                con: con.date.value,
              ),
              widget2: AppTextField(
                txt: 'Detail',
                con: con.detail.value,
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
                    await getAllAdvertise();
                    conAdv.monthList.clear();
                    if (advertise.isNotEmpty) {
                      for (var data in advertise) {
                        conAdv.monthList.add('${data.year}-${data.month}');
                      }
                      conAdv.monthList.value =
                          conAdv.monthList.toSet().toList();
                      conAdv.selectedMonth.value = conAdv.monthList[0];
                      conAdv.filteredAdv.clear();
                      await getByDateAdvertise(
                        conAdv.selectedMonth.value!.split('-')[0],
                        conAdv.selectedMonth.value!.split('-')[1],
                      );
                    }
                    conAdv.filteredAdv.value = advertise;
                    conAdv.search.value.addListener(conAdv.filterAdvData);
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
                    con.createAdvertise(context);
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
