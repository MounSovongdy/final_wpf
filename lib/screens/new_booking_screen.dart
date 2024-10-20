import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_booking_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewBookingScreen extends StatelessWidget {
  NewBookingScreen({super.key});

  final con = Get.put(NewBookingController());
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
            AppText.header(context, txt: 'New Booking'),
            spacer(context),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Booking Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Date',
                con: con.date.value,
                readOnly: true,
              ),
              widget2: AppDropdown(
                txt: 'Micro',
                list: con.microList,
                onChanged: (v) {
                  if (v != null) con.micro = v;
                },
              ),
              widget3: AppDropdown(
                txt: 'Salesman',
                list: con.saleManList,
                onChanged: (v) {
                  if (v != null) con.salesman = v;
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
              widget3: AppDropdown(
                txt: 'Gender',
                value: con.gender,
                list: con.genderList,
                onChanged: (v) {
                  if (v != null) con.gender = v;
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
              widget3: AppTextField(
                txt: 'Address',
                con: con.address.value,
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Product Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdown(
                txt: 'Model',
                list: con.modelList,
                onChanged: (v) {
                  if (v != null) {
                    con.model = v;
                    for (var data in product) {
                      if (data.model == con.model) {
                        con.brand.value.text = data.brand;
                      }
                    }
                  }
                },
              ),
              widget2: AppTextField(
                txt: 'Brand',
                con: con.brand.value,
                readOnly: true,
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
              widget1: AppDropdown(
                txt: 'Color',
                list: con.colorList,
                onChanged: (v) {
                  if (v != null) con.color = v;
                },
              ),
              widget2: AppDropdown(
                txt: 'Condition',
                list: con.conditionList,
                onChanged: (v) {
                  if (v != null) con.condition = v;
                },
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
                txt: 'Deposit',
                con: con.depo.value,
                isNumber: true,
                digit: 5,
                onChanged: (v) => con.calculateRemain(),
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Remain',
                con: con.remain.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(
                spacer: spacer(context), txt: 'Introduced Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdown(
                txt: 'Come By',
                list: con.comeByList,
                onChanged: (v) {
                  if (v != null) {
                    con.comeBy = v;
                    if (con.comeBy == 'Friend') {
                      con.isFriend.value = true;
                    } else {
                      con.isFriend.value = false;
                    }
                  }
                },
              ),
              widget2: Obx(
                () => AppTextField(
                  txt: 'Name',
                  con: con.nameIntro.value,
                  readOnly: !con.isFriend.value,
                ),
              ),
              widget3: Obx(
                () => AppTextField(
                  txt: 'Tel',
                  con: con.phoneIntro.value,
                  readOnly: !con.isFriend.value,
                  isNumber: true,
                  digit: 10,
                ),
              ),
            ),
            spacer(context),
            spacer(context),
            Responsive.isDesktop(context)
                ? Container(
                    margin: EdgeInsets.only(left: 5.px, right: defWebPad.px),
                    child: AppTextField(
                      txt: 'Remark',
                      con: con.remark.value,
                      flex: 10,
                    ),
                  )
                : RowTextField(
                    spacer: spacer(context),
                    widget1: AppTextField(txt: 'Remark', con: con.remark.value),
                  ),
            spacer(context),
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
