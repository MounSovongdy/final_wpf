import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/cash_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_cash_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewCashScreen extends StatelessWidget {
  NewCashScreen({super.key});

  final con = Get.put(NewCashController());
  final conC = Get.put(CashController());
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
            AppText.header(context, txt: 'New Cash Sale'),
            spacer(context),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Sell Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Date',
                con: con.dateBooking.value,
              ),
              widget2: AppDropdownSearch(
                txt: 'Salesman',
                value: con.salesman,
                list: con.saleManList,
                onChanged: (v) {
                  if (v != null) con.salesman.value = v;
                },
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Customer Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'ID Card',
                con: con.idCard.value,
                isNumber: true,
                digit: 9,
              ),
              widget2: AppTextField(
                txt: 'Name',
                con: con.name.value,
              ),
              widget3: AppDropdownSearch(
                txt: 'Gender',
                value: con.gender,
                list: con.genderList,
                onChanged: (v) {
                  if (v != null) con.gender.value = v;
                },
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Age',
                con: con.age.value,
                isNumber: true,
                digit: 2,
              ),
              widget2: AppTextField(
                txt: 'Tel',
                con: con.phoneCus.value,
                isNumber: true,
                digit: 10,
              ),
              widget3: AppDropdownSearch(
                txt: 'Address',
                value: con.cusAddress,
                list: con.addressList,
                onChanged: (v) {
                  if (v != null) con.cusAddress.value = v;
                },
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Product Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Brand',
                value: con.proBrand,
                list: con.brandList,
                onChanged: (v) async {
                  if (v != null) {
                    con.modelList.clear();
                    con.model.value = null;
                    await getByProduct(v);
                    for (var data in byProduct) {
                      con.modelList.add(data.model);
                    }
                    con.proBrand.value = v;
                  }
                },
              ),
              widget2: AppDropdownSearch(
                txt: 'Model',
                value: con.model,
                list: con.modelList,
                onChanged: (v) {
                  if (v != null) con.model.value = v;
                },
              ),
              widget3: AppTextField(
                txt: 'Year',
                con: con.year.value,
                isNumber: true,
                digit: 4,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Color',
                value: con.proColor,
                list: con.colorList,
                onChanged: (v) {
                  if (v != null) con.proColor.value = v;
                },
              ),
              widget2: AppTextField(
                txt: 'Power',
                con: con.power.value,
                isNumber: true,
                digit: 3,
              ),
              widget3: AppDropdownSearch(
                txt: 'Condition',
                value: con.condition,
                list: con.conditionList,
                onChanged: (v) {
                  if (v != null) con.condition.value = v;
                },
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Engine No',
                con: con.engine.value,
              ),
              widget2: AppTextField(
                txt: 'Frame No',
                con: con.frame.value,
              ),
              widget3: AppDropdownSearch(
                txt: 'Type',
                value: con.type,
                list: con.typeList,
                onChanged: (v) {
                  if (v != null) {
                    con.type.value = v;
                    if (v == 'Plate Number') {
                      con.isTax.value = false;
                    } else {
                      con.isTax.value = true;
                    }
                  }
                },
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: Obx(
                () => AppTextField(
                  txt: 'Plate No',
                  con: con.plateNo.value,
                  readOnly: con.isTax.value,
                ),
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Financial Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Sell Price',
                con: con.sell.value,
                isNumber: true,
                digit: 5,
                onChanged: (v) => con.calculateRemain(),
              ),
              widget2: AppTextField(
                txt: 'Discount',
                con: con.discount.value,
                isNumber: true,
                digit: 5,
                onChanged: (v) => con.calculateRemain(),
              ),
              widget3: AppTextField(
                txt: 'Total Price',
                con: con.totalPrice.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Introduced Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Come By',
                value: con.comeBy,
                list: con.comeByList,
                onChanged: (v) {
                  if (v != null) {
                    con.comeBy.value = v;
                    if (con.comeBy.value != 'Friend') {
                      con.nameIntro.value.text = '';
                      con.phoneIntro.value.text = '';
                      con.commission.value.text = '';
                    }
                  }
                },
              ),
              widget2: Obx(
                () => AppTextField(
                  txt: 'Name',
                  con: con.nameIntro.value,
                  readOnly: con.comeBy.value == 'Friend' ? false : true,
                ),
              ),
              widget3: Obx(
                () => AppTextField(
                  txt: 'Tel',
                  con: con.phoneIntro.value,
                  readOnly: con.comeBy.value == 'Friend' ? false : true,
                  isNumber: true,
                  digit: 10,
                ),
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: Obx(
                () => AppTextField(
                  txt: 'Commission',
                  con: con.commission.value,
                  readOnly: con.comeBy.value == 'Friend' ? false : true,
                  isNumber: true,
                  digit: 3,
                ),
              ),
            ),
            spacer(context),
            spacer(context),
            const UnderLine(color: secondGreyColor),
            spacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  txt: 'Back',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                    con.clearText();
                    await getAllCash();
                    conC.filteredCash.value = cash;
                    conC.search.value.addListener(conC.filterCashData);

                    conMain.index.value = conMain.index.value - 1;
                  },
                ),
                spacer(context),
                spacer(context),
                AppButton(
                  txt: 'Save',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () async {
                    startInactivityTimer();
                    con.createCash(context);
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
