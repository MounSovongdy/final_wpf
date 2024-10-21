import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_booking_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
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
              ),
              widget2: AppDropdownSearch(
                txt: 'Micro',
                value: con.micro,
                list: con.microList,
                onChanged: (v) {
                  if (v != null) con.micro.value = v;
                },
              ),
              widget3: AppDropdownSearch(
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
                value: con.address,
                list: con.addressList,
                onChanged: (v) {
                  if (v != null) con.address.value = v;
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
                list: con.brandList,
                value: con.brand,
                onChanged: (v) async {
                  if (v != null) {
                    con.modelList.clear();
                    con.model.value = null;
                    await getByProduct(v);
                    for (var data in byProduct) {
                      con.modelList.add(data.model);
                    }
                    con.brand.value = v;
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
                value: con.color,
                list: con.colorList,
                onChanged: (v) {
                  if (v != null) con.color.value = v;
                },
              ),
              widget2: AppDropdownSearch(
                txt: 'Condition',
                value: con.condition,
                list: con.conditionList,
                onChanged: (v) {
                  if (v != null) con.condition.value = v;
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
              widget1: AppDropdownSearch(
                txt: 'Come By',
                value: con.comeBy,
                list: con.comeByList,
                onChanged: (v) {
                  if (v != null) {
                    con.comeBy.value = v;
                    if (con.comeBy.value == 'Friend') {
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
            TitleUnderline(
                spacer: spacer(context), txt: 'Document Support'),
            
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
