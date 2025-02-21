import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_rental_controller.dart';
import 'package:motor/controllers/rental_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_date_text_field.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewRentalScreen extends StatelessWidget {
  NewRentalScreen({super.key});

  final con = Get.put(NewRentalController());
  final conRen = Get.put(RentalController());
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
            AppText.header(context, txt: conRen.title.value),
            spacer(context),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDateTextField(
                txt: 'Date | កាលបរិច្ឆេទ',
                con: con.date.value,
              ),
              widget2: AppTextField(
                txt: 'Detail | ពត៏មាន', 
                con: con.detail.value,
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
                  txt: 'Back | ត្រលប់ក្រោយ',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                    LoadingWidget.dialogLoading(duration: 5, isBack: true);
                    await getAllRental();
                    conRen.monthList.clear();
                    if (rental.isNotEmpty) {
                      for (var data in rental) {
                        conRen.monthList.add('${data.year}-${data.month}');
                      }
                      conRen.monthList.value =
                          conRen.monthList.toSet().toList();
                      conRen.selectedMonth.value = conRen.monthList[0];
                      conRen.filteredRental.clear();
                      await getByDateRental(
                        conRen.selectedMonth.value!.split('-')[0],
                        conRen.selectedMonth.value!.split('-')[1],
                      );
                      await getTotalExpense(
                        year: conRen.selectedMonth.value!.split('-')[0],
                        month: conRen.selectedMonth.value!.split('-')[1],
                      );
                      if (byTotalExpense.isNotEmpty)
                        conRen.amount.value.text = byTotalExpense[0].rental;
                    }
                    conRen.filteredRental.value = rental;
                    conRen.search.value.addListener(conRen.filterRentalData);
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
                    con.createRental(context);
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
