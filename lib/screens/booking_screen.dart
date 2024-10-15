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

  final micro = ['A', 'C', 'J', 'AP'];
  final status = ['Leasing', 'Cash'];
  final marital = ['Single', 'Married'];
  final gender = ['Male', 'Female'];
  final salesman = ['Thol', 'Sora','Piseth'];
  final brand = ['Honda', 'Susaki','Yamaha'];
  final model = ['Dream','Best', 'Scooppy'];
  final color = ['Red', 'Black', 'Blue'];
  final condition = ['New', 'Used'];

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
              widget2: AppDropdown(
                txt: 'Method',
                value: con.bookingStatus,
                list: status,
                onChanged: (v) {
                  if (v != null) con.bookingStatus = v;
                },
              ),
              widget3: AppDropdown(
                txt: 'Micro',
                list: micro,
                onChanged: (v) {
                  if (v != null) con.microStatus = v;
                },
              ),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppDropdown(txt: 'Salesman', list: salesman, onChanged: (v){
                if (v != null) con.salesmanStatus = v;
              },),
            ),
            TitleUnderline(spacer: spacer, txt: 'Customer Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'ID Card', con: con.name.value),
              widget2: AppTextField(txt: 'Name', con: con.name.value),
              widget3: AppDropdown(
                txt: 'Gender',
                value: con.genderStatus,
                list: gender,
                onChanged: (v) {
                  if (v != null) con.genderStatus = v;
                },
              ),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Age', con: con.age.value),
              widget2: AppTextField(txt: 'Tel', con: con.phone1.value),
              widget3: AppTextField(txt: 'Address', con: con.address.value),
            ),
            TitleUnderline(spacer: spacer, txt: 'Product Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppDropdown(txt: 'Brand', list: brand, onChanged: (v){
                if (v != null) con.brand = v;
              },),
              widget2: AppDropdown(txt: 'Model', list: model, onChanged: (v){
                if (v != null) con.model = v;
              },),
              widget3: AppDropdown(txt: 'Color', list: color, onChanged: (v){
                if (v != null) con.color = v;
              },),
            ),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Year', con: con.year.value,readOnly: true,),
              widget2: AppDropdown(txt: 'Condition', list: condition, onChanged: (v){
                if (v != null) con.condition = v;
              },),
            ),
            TitleUnderline(spacer: spacer, txt: 'Financial Information'),
            RowTextField(
              spacer: spacer,
              widget1: AppTextField(txt: 'Sell Price', con: con.sell.value),
              widget2: AppTextField(txt: 'Discount', con: con.dis.value),
              widget3: AppTextField(txt: 'Deposit', con: con.depo.value),
            ),
            RowTextField(
              spacer: spacer,

              widget1: AppTextField(txt: 'Remain', con: con.remain.value),
            ),
            TitleUnderline(spacer: spacer, txt: 'Introduced Information'),
            RowTextField(spacer: spacer,
              widget1: AppTextField(txt: 'Name', con: con.nameIntro.value),
              widget2: AppTextField(txt: 'Tel', con: con.phoneIntro.value),
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
