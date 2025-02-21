import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/booking_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_booking_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewBookingScreen extends StatelessWidget {
  NewBookingScreen({super.key});

  final con = Get.put(NewBookingController());
  final conBook = Get.put(BookingController());
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
            AppText.header(context, txt: conBook.title.value),
            spacer(context),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Booking Information | ព័ត៌មានការកក់',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Date | កាលបរិច្ឆេទ',
                con: con.date.value,
                readOnly: true,
              ),
              widget2: AppDropdownSearch(
                txt: 'Micro | ស្ថាប័ន',
                value: con.micro,
                list: con.microList,
                onChanged: (v) {
                  if (v != null) con.micro.value = v;
                },
              ),
              widget3: AppDropdownSearch(
                txt: 'Salesman | អ្នកលក់',
                value: con.salesman,
                list: con.saleManList,
                onChanged: (v) {
                  if (v != null) con.salesman.value = v;
                },
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Customer Information | ព័ត៌មានអតិថិជន',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'ID Card | អត្តសញ្ញាណប័ណ្ណ',
                con: con.idCard.value,
                isNumber: true,
                digit: 9,
              ),
              widget2: AppTextField(
                txt: 'Name | ឈ្មោះ',
                con: con.name.value,
              ),
              widget3: AppDropdownSearch(
                txt: 'Gender | ភេទ',
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
                txt: 'Age | អាយុ',
                con: con.age.value,
                isNumber: true,
                digit: 2,
              ),
              widget2: AppTextField(
                txt: 'Tel | លេខទូរស័ព្ទ',
                con: con.phoneCus.value,
                isNumber: true,
                digit: 10,
              ),
              widget3: AppDropdownSearch(
                txt: 'Address | អាសយដ្ឋាន',
                value: con.address,
                list: con.addressList,
                onChanged: (v) {
                  if (v != null) con.address.value = v;
                },
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Product Information | ព័ត៌មានផលិតផល',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Brand | ម៉ាក',
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
                txt: 'Model | ផលិតផល',
                value: con.model,
                list: con.modelList,
                onChanged: (v) {
                  if (v != null) con.model.value = v;
                },
              ),
              widget3: AppTextField(
                txt: 'Year | ឆ្នាំ',
                con: con.year.value,
                isNumber: true,
                digit: 4,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Color | ពណ៌',
                value: con.color,
                list: con.colorList,
                onChanged: (v) {
                  if (v != null) con.color.value = v;
                },
              ),
              widget2: AppTextField(
                txt: 'Power | កម្លាំង',
                con: con.power.value,
                isNumber: true,
                digit: 3,
              ),
              widget3: AppDropdownSearch(
                txt: 'Condition | ស្ថានភាព',
                value: con.condition,
                list: con.conditionList,
                onChanged: (v) {
                  if (v != null) con.condition.value = v;
                },
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Financial Information | ព័ត៌មានហិរញ្ញវត្ថុ',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Sell Price | តំលៃលក់',
                con: con.sell.value,
                isNumber: true,
                digit: 10,
                onChanged: (v) => con.calculateRemain(),
              ),
              widget2: AppTextField(
                txt: 'Discount | បញ្ចុះតំលៃ',
                con: con.discount.value,
                isNumber: true,
                digit: 10,
                onChanged: (v) => con.calculateRemain(),
              ),
              widget3: AppTextField(
                txt: 'Deposit | ប្រាក់កក់',
                con: con.deposit.value,
                isNumber: true,
                digit: 10,
                onChanged: (v) => con.calculateRemain(),
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Remain | ប្រាក់នៅសល់',
                con: con.remain.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Introduced Information | ព័ត៌មានអ្នកណែនាំ',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Come By | មកដោយ',
                value: con.comeBy,
                list: con.comeByList,
                onChanged: (v) {
                  if (v != null) {
                    con.comeBy.value = v;
                    if (con.comeBy.value == 'Friend') {
                      con.isFriend.value = true;
                    } else {
                      con.isFriend.value = false;
                      con.nameIntro.value.text = '';
                      con.phoneIntro.value.text = '';
                    }
                  }
                },
              ),
              widget2: Obx(
                () => AppTextField(
                  txt: 'Name | ឈ្មោះ',
                  con: con.nameIntro.value,
                  readOnly: !con.isFriend.value,
                ),
              ),
              widget3: Obx(
                () => AppTextField(
                  txt: 'Tel | លេខទូរស័ព្ទ',
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
                      txt: 'Remark | សំគាល់',
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
                AppButtonSubmit(
                  txt: 'Back | ត្រលប់ក្រោយ',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                    LoadingWidget.dialogLoading(duration: 1, isBack: true);
                    con.clearText();
                    await getAllBooking();
                    conBook.filteredBooking.value = booking;
                    conBook.search.value.addListener(conBook.filterBookingData);
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
                    if (conBook.title.value == 'New Booking') {
                      con.createBooking(context);
                    } else {
                      con.updateBooking(context);
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
