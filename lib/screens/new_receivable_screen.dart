import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_receivable_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewReceivableScreen extends StatelessWidget {
  NewReceivableScreen({super.key});

  final con = Get.put(NewReceivableController());
  final conMain = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: 'New Receivable | បង់ប្រាក់ដោយរបស់អតិថិជន'),
            spacer(context),
            TitleUnderline(
                spacer: spacer(context), txt: 'Customer Information | ព័ត៌មានអតិថិជន'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'ID Card | អត្តសញ្ញាណប័ណ្ណ',
              con: con.name.value),
              widget2: AppTextField(
                txt: 'Name | ឈ្មោះ',
                con: con.name.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Address | អាសយដ្ឋាន',
                con: con.address.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Phone 1 | លេខទូរស័ព្ទ 1',
                con: con.phoneCus1.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Phone 2 | លេខទូរស័ព្ទ 2',
                con: con.phoneCus2.value,
              ),
              widget3: AppTextField(
                txt: 'Phone 3 | លេខទូរស័ព្ទ 3',
                con: con.phoneCus3.value,
              ),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Sell Information | ព័ត៌មានលក់'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Sell Date | កាលបរិច្ឆេទលក់',
                con: con.dateBooking.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Salesman | អ្នកលក់',
                con: con.salesman.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Product Information | ព័ត៌មានផលិតផល'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Model | ផលិតផល',
                con: con.model.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Year | ឆ្នាំ',
                con: con.year.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Condition | ស្ថានភាព',
                con: con.condition.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Engine No | លេខម៉ាស៊ីន',
                con: con.engine.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Frame No | លេខកង់',
                con: con.frame.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Plate No | ស្លាបលេខ',
                con: con.plateNo.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Sell Price | តម្លៃលក់',
                con: con.sell.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Discount | បញ្ចុះតម្លៃ',
                con: con.discount.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Deposit | ប្រាក់កក់',
                con: con.deposit.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Remain | ប្រាក់នៅសល់',
                con: con.remain.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Approved | អនុម័ត',
                con: con.remain.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Total Debt | ប្រាក់ខែ',
                con: con.totalOwn.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Payment Information | ព័ត៌មានបង់ប្រាក់'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Term | រយៈពេល',
                con: con.term.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'First Payment | បង់ដំបូង',
                con: con.firstPayDate.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Rate | អត្រា',
                con: con.rate.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Type | ប្រភេទ',
                con: con.term.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Amount | ចំនួន',
                con: con.firstPayDate.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Date | កាលបរិច្ឆេទ',
                con: con.rate.value,
                readOnly: true,
              ),
            ),
            spacer(context),
            spacer(context),
            const UnderLine(color: secondGreyColor),
            spacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButtonSubmit(
                  txt: 'Cancel | បោះបង់',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () {
                    startInactivityTimer();
                    conMain.index.value = conMain.index.value - 1;
                  },
                ),
                spacer(context),
                spacer(context),
                AppButtonSubmit(
                  txt: 'Save | រក្សាទុក',
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