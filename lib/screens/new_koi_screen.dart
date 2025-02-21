import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/koi_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_koi_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_date_text_field.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewKoiScreen extends StatelessWidget {
  NewKoiScreen({super.key});

  final con = Get.put(NewKoiController());
  final conKoi = Get.put(KoiController());
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
            AppText.header(context, txt: conKoi.title.value),
            spacer(context),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDateTextField(
                txt: 'Date | កាលបរិច្ឆេទ',
                con: con.date.value,
              ),
              widget2: AppTextField(
                txt: 'Name | ឈ្មោះ',
                con: con.name.value,
              ),
              widget3: AppTextField(
                txt: 'Amount | ចំនួន',
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
                    LoadingWidget.dialogLoading(duration: 5, isBack: true);
                    await getAllKoi();
                    conKoi.monthList.clear();
                    if (koi.isNotEmpty) {
                      for (var data in koi) {
                        conKoi.monthList.add('${data.year}-${data.month}');
                      }
                      conKoi.monthList.value =
                          conKoi.monthList.toSet().toList();
                      conKoi.selectedMonth.value = conKoi.monthList[0];
                      conKoi.filteredKoi.clear();
                      await getByDateKoi(
                        conKoi.selectedMonth.value!.split('-')[0],
                        conKoi.selectedMonth.value!.split('-')[1],
                      );
                    }
                    conKoi.filteredKoi.value = koi;
                    conKoi.search.value.addListener(conKoi.filterKoiData);
                    Get.back();

                    conMain.index.value = conMain.index.value - 1;
                  },
                ),
                spacer(context),
                spacer(context),
                AppButtonSubmit(
                  txt: 'Save | រក្សាទុក',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                    con.createKoi(context);
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
