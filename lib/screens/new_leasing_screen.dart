import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_leasing_controller.dart';
import 'package:motor/controllers/open_printer_dailog_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:pdf/pdf.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewLeasingScreen extends StatelessWidget {
  NewLeasingScreen({super.key});

  final con = Get.put(NewLeasingController());
  final conMain = Get.put(MainController());
  final conPrint = Get.put(OpenPrinterDaiLogController());

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
            AppText.header(context, txt: 'New Leasing'),
            spacer(context),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Customer Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Booking ID',
                value: con.bookingId,
                list: con.bookingIdList,
                onChanged: (v) {
                  if (v != null) {
                    con.bookingId.value = v;
                    con.getDataByBookingIDAndIdCard();
                  }
                },
              ),
              widget2: AppDropdownSearch(
                txt: 'ID Card',
                value: con.idCard,
                list: con.idCardList,
                onChanged: (v) {
                  if (v != null) {
                    con.idCard.value = v;
                    con.getDataByBookingIDAndIdCard();
                  }
                },
              ),
              widget3: AppTextField(
                txt: 'Name',
                con: con.name.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Age',
                con: con.age.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Tel',
                con: con.phoneCus.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Address',
                con: con.address.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Booking Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Date',
                con: con.dateBooking.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Micro',
                con: con.micro.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Salesman',
                con: con.salesman.value,
                readOnly: true,
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
                value: con.brand,
                list: con.brandList,
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
                  if (v != null) {
                    con.model.value = v;
                  }
                },
              ),
              widget3: AppDropdownSearch(
                txt: 'Color',
                value: con.color,
                list: con.colorList,
                onChanged: (v) {
                  if (v != null) {
                    con.color.value = v;
                  }
                },
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Year',
                con: con.year.value,
                isNumber: true,
                digit: 4,
              ),
              widget2: AppDropdownSearch(
                txt: 'Color',
                value: con.color,
                list: con.colorList,
                onChanged: (v) {
                  if (v != null) con.color.value = v;
                },
              ),
              widget3: AppTextField(
                txt: 'Engine No',
                con: con.engine.value,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Frame No',
                con: con.frame.value,
              ),
              widget2: AppDropdownSearch(
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
              widget3: Obx(
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
                txt: 'Deposit',
                con: con.deposit.value,
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
                onChanged: (v) => con.calculateTotalDebt(),
              ),
              widget2: AppTextField(
                txt: 'Approved',
                con: con.approve.value,
                isNumber: true,
                digit: 5,
                onChanged: (v) => con.calculateTotalDebt(),
              ),
              widget3: AppTextField(
                txt: 'Total Debt',
                con: con.totalOwn.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Introduced Information',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Come By',
                con: con.comeBy.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Name',
                con: con.nameIntro.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Tel',
                con: con.phoneIntro.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Commission',
                con: con.commission.value,
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
                  txt: 'Cancel',
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
                  txt: 'Print Invoice',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () async {
                    startInactivityTimer();
                    final pdfData = await conPrint.generatePdf(
                      PdfPageFormat.a4,
                      'Hello World! This is a test print with a custom font.',
                    );
                    conPrint.printPdf(pdfData);
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
