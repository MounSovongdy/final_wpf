import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  final con = Get.put(MainController());

  final status = ['Online', 'Offline'];
  final marital = ['Single', 'Married'];

  @override
  Widget build(BuildContext context) {
    var spacer = SizedBox(
      height: Responsive.isDesktop(context) ? defWebPad : defMobPad,
      width: Responsive.isDesktop(context) ? defWebPad : defMobPad,
    );

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
            spacer,
            TitleUnderline(spacer: spacer, txt: 'Booking Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Date', con: con.date.value),
              widget2: AppTextField(txt: 'Location', con: con.location.value),
              widget3: AppDropdown(
                txt: 'Status',
                value: con.bookingStatus,
                list: status,
                onChanged: (v) {
                  if (v != null) con.bookingStatus = v;
                },
              ),
            ),
            TitleUnderline(spacer: spacer, txt: 'Customer Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'ID Card', con: con.name.value),
              widget2: AppTextField(txt: 'Name', con: con.name.value),
              widget3: AppTextField(txt: 'Gender', con: con.gender.value),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppDropdown(
                txt: 'Marital',
                value: con.maritalStatus,
                list: marital,
                onChanged: (v) {
                  if (v != null) con.maritalStatus = v;
                },
              ),
              widget2: AppTextField(txt: 'Phone', con: con.phone2.value),
              widget3: AppTextField(txt: 'Address', con: con.address.value),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Type', con: con.cusType.value),
              widget2: AppTextField(txt: 'Re Code', con: con.code.value),
            ),
            TitleUnderline(spacer: spacer, txt: 'Product Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Type', con: con.proType.value),
              widget2: AppTextField(txt: 'Brand', con: con.brand.value),
              widget3: AppTextField(txt: 'Model', con: con.model.value),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Year', con: con.year.value),
              widget2: AppTextField(txt: 'Condition', con: con.condi.value),
              widget3: AppTextField(txt: 'Description', con: con.des.value),
            ),
            TitleUnderline(spacer: spacer, txt: 'Financial Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Sell Price', con: con.sell.value),
              widget2: AppTextField(txt: 'Discount', con: con.dis.value),
              widget3: AppTextField(txt: 'Coupons', con: con.cou.value),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Deposit', con: con.depo.value),
              widget2: AppTextField(txt: 'Remain', con: con.remain.value),
            ),
            spacer,
            spacer,
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
                    spacer: spacer,
                    widget1: AppTextField(txt: 'Remark', con: con.remark.value),
                  ),
            spacer,
            spacer,
            spacer,
            const UnderLine(color: secondGreyColor),
            spacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  txt: 'Cancel',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () {},
                ),
                spacer,
                spacer,
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
