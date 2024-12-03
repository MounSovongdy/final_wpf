import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/create_salesman_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/salesman_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_date_text_field.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateSalesmanScreen extends StatelessWidget {
  CreateSalesmanScreen({super.key});

  final con = Get.put(CreateSalesmanController());
  final conMain = Get.put(MainController());
  final conSM = Get.put(SalesmanController());

  final gender = ['Male', 'Female'];
  final position = ['Sale'];

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
            AppText.header(context, txt: conSM.title.value),
            spacer(context),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'General Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Full Name',
                con: con.fullName.value,
              ),
              widget2: AppDropdownSearch(
                txt: 'Gender',
                value: con.gender,
                list: gender,
                onChanged: (v) {
                  if (v != null) con.gender.value = v;
                },
              ),
              widget3: AppTextField(
                txt: 'Tel',
                con: con.tel.value,
                isNumber: true,
                digit: 10,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Position',
                value: con.position,
                list: position,
                onChanged: (v) {
                  if (v != null) con.position.value = v;
                },
              ),
              widget2: AppTextField(
                txt: 'Salary',
                con: con.salary.value,
                isNumber: true,
                digit: 5,
              ),
              widget3: AppTextField(
                txt: 'Bonus',
                con: con.bonus.value,
                isNumber: true,
                digit: 5,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDateTextField(
                txt: 'Join Date',
                con: con.joinDate.value,
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
                    LoadingWidget.dialogLoading(duration: 1, isBack: true);
                    con.clearText();
                    await getAllSaleMan();
                    conSM.filteredSale.value = saleMan;
                    conSM.search.value.addListener(conSM.filterSaleData);
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
                    if (conSM.title.value == 'Create Salesman') {
                      con.createSaleman(context);
                    } else {
                      con.updateSaleman(context);
                    }
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
