import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_staff_controller.dart';
import 'package:motor/controllers/staff_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_date_text_field.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewStaffScreen extends StatelessWidget {
  NewStaffScreen({super.key});

  final con = Get.put(NewStaffController());
  final conStaff = Get.put(StaffController());
  final conMain = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: conStaff.title.value),
            spacer(context),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDateTextField(
                txt: 'Date | កាលបរិច្ឆេទ',
                con: con.date.value,
              ),
              widget2: AppDropdownSearch(
                txt: 'Staff Name | ឈ្មោះបុគ្គលិក',
                value: con.saleName,
                list: con.nameList,
                onChanged: (v) {
                  if (v != null) {
                    con.saleName.value = v;
                    for (var data in saleMan) {
                      if (data.name == v) {
                        con.saleId.value = data.id;
                        con.salary.value.text = data.salary;
                        con.bonus.value.text = data.bonus;
                      }
                    }
                  }
                },
              ),
              widget3: AppTextField(
                txt: 'Salary | ប្រាក់ខែ',
                con: con.salary.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Bonus | ប្រាក់រង្វង់',
                con: con.bonus.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Unit Sale | ចំនួនលក់',
                con: con.unitSale.value,
                isNumber: true,
                digit: 3,
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
                    await getAllSaleManCommission();
                    conStaff.monthList.clear();
                    if (saleManCom.isNotEmpty) {
                      for (var data in saleManCom) {
                        conStaff.monthList.add('${data.year}-${data.month}');
                      }
                      conStaff.monthList.value =
                          conStaff.monthList.toSet().toList();
                      conStaff.selectedMonth.value = conStaff.monthList[0];
                      conStaff.filteredStaff.clear();
                      await getByDateSaleManCommission(
                        conStaff.selectedMonth.value!.split('-')[0],
                        conStaff.selectedMonth.value!.split('-')[1],
                      );
                    }
                    conStaff.filteredStaff.value = saleManCom;
                    conStaff.search.value.addListener(conStaff.filterStaffData);
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
                    con.createStaff(context);
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
