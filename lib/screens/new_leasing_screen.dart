import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/leasing_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_leasing_controller.dart';
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

class NewLeasingScreen extends StatelessWidget {
  NewLeasingScreen({super.key});

  final con = Get.put(NewLeasingController());
  final conL = Get.put(LeasingController());
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
            AppText.header(context, txt: 'New Leasing Sale | លក់កិច្ចសន្យាថ្មី'),
            spacer(context),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Customer Information | ព័ត៌មានអតិថិជន',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Booking ID | លេខកក់',
                value: con.bookingId,
                list: con.bookingIdList,
                onChanged: (v) {
                  if (v != null) {
                    con.clearText();
                    con.bookingId.value = v;
                    con.getDataByBookingIDAndIdCard();
                  }
                },
              ),
              widget2: AppDropdownSearch(
                txt: 'ID Card | អត្តសញ្ញាណប័ណ្ណ',
                value: con.idCard,
                list: con.idCardList,
                onChanged: (v) {
                  if (v != null) {
                    con.clearText();
                    con.idCard.value = v;
                    con.getDataByBookingIDAndIdCard();
                  }
                },
              ),
              widget3: AppTextField(
                txt: 'Name | ឈ្មោះ',
                con: con.name.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Gender | ភេទ',
                con: con.gender.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Age | អាយុ',
                con: con.age.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Tel | លេខទូរស័ព្ទ',
                con: con.phoneCus.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Address | អាសយដ្ឋាន',
                con: con.address.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Booking Information | ព័ត៌មានកក់',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Date | កាលបរិច្ឆេទ',
                con: con.dateBooking.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Micro | សា្ថបន័',
                con: con.micro.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Salesman | អ្នកលក់',
                con: con.salesman.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Duration | រយៈពេល',
                con: con.workingHours.value,
                readOnly: true,
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
                txt: 'Model | ផលិតផល',
                value: con.model,
                list: con.modelList,
                onChanged: (v) {
                  if (v != null) {
                    con.model.value = v;
                  }
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
                txt: 'Power | សម្រាប់',
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
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Engine No | លេខម៉ាស៊ីន',
                con: con.engine.value,
              ),
              widget2: AppTextField(
                txt: 'Frame No | លេខតួរ',
                con: con.frame.value,
              ),
              widget3: AppDropdownSearch(
                txt: 'Type | ប្រភេទ',
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
                  txt: 'Plate No | លេខប្រអប់',
                  con: con.plateNo.value,
                  readOnly: con.isTax.value,
                ),
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
                onChanged: (v) {
                  con.calculateRemain();
                  con.calculateTotalDebt();
                },
              ),
              widget2: AppTextField(
                txt: 'Discount | បញ្ចុះតំលៃ',
                con: con.discount.value,
                isNumber: true,
                digit: 10,
                onChanged: (v) {
                  con.calculateRemain();
                  con.calculateTotalDebt();
                },
              ),
              widget3: AppTextField(
                txt: 'Deposit | ប្រាក់កក់',
                con: con.deposit.value,
                isNumber: true,
                digit: 10,
                onChanged: (v) {
                  con.calculateRemain();
                  con.calculateTotalDebt();
                },
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Remain | ប្រាក់នៅសល់',
                con: con.remain.value,
                readOnly: true,
                onChanged: (v) {
                  con.calculateRemain();
                  con.calculateTotalDebt();
                },
              ),
              widget2: AppTextField(
                txt: 'Approved | ប្រាក់បង់ប្រាក់',
                con: con.approve.value,
                isNumber: true,
                digit: 10,
                onChanged: (v) {
                  con.calculateRemain();
                  con.calculateTotalDebt();
                },
              ),
              widget3: AppTextField(
                txt: 'Total Debt | ប្រាក់ខែ',
                con: con.totalOwn.value,
                readOnly: true,
                onChanged: (v) => con.calculateTotal(),
              ),
            ),
            Obx(
              () => con.isReceivable.value
                  ? TitleUnderline(
                      spacer: spacer(context),
                      txt: 'Receivable Information | ព័ត៌មានអតិថិជន',
                    )
                  : Container(),
            ),
            Obx(
              () => con.isReceivable.value
                  ? RowTextField(
                      spacer: spacer(context),
                      widget1: AppTextField(
                        txt: 'Telephone 2 | លេខទូរស័ព្ទ ២',
                        con: con.phoneCus2.value,
                        isNumber: true,
                        digit: 10,
                      ),
                      widget2: AppTextField(
                        txt: 'Name 2 | ឈ្មោះ ២',
                        con: con.nameCus2.value,
                      ),
                      widget3: AppTextField(
                        txt: 'Document | ឯកសារ',
                        con: con.document.value,
                      ),
                    )
                  : Container(),
            ),
            Obx(
              () => con.isReceivable.value
                  ? RowTextField(
                      spacer: spacer(context),
                      widget1: AppTextField(
                        txt: 'Telephone 3 | លេខទូរស័ព្ទ ៣',
                        con: con.phoneCus3.value,
                        isNumber: true,
                        digit: 10,
                      ),
                      widget2: AppTextField(
                        txt: 'Name 3 | ឈ្មោះ ៣',
                        con: con.nameCus3.value,
                      ),
                      widget3: AppTextField(
                        txt: 'Penalty | ប្រាក់ពិន័យ',
                        con: con.penalty.value,
                        isNumber: true,
                        digit: 10,
                      ),
                    )
                  : Container(),
            ),
            Obx(
              () => con.isReceivable.value
                  ? RowTextField(
                      spacer: spacer(context),
                      widget1: AppDateTextField(
                        txt: 'First Payment | បង់ប្រាក់ដំបូង',
                        con: con.firstPayDate.value,
                      ),
                      widget2: AppTextField(
                        txt: 'Term | រយៈពេល',
                        con: con.term.value,
                        isNumber: true,
                        digit: 2,
                      ),
                      widget3: AppTextField(
                        txt: 'Interest % | ការប្រាក់ %',
                        con: con.interest.value,
                        isNumber: true,
                        digit: 5,
                        onChanged: (v) => con.calculateTotal(),
                      ),
                    )
                  : Container(),
            ),
            Obx(
              () => con.isReceivable.value
                  ? RowTextField(
                      spacer: spacer(context),
                      widget1: AppDropdownSearch(
                        txt: 'Plate Payment | ប្រាក់ប្រអប់',
                        value: con.platePay,
                        list: con.platePayList,
                        onChanged: (v) {
                          if (v != null) {
                            con.platePay.value = v;
                            con.plateAmount.value.text = '';
                            con.calculateTotal();
                          }
                        },
                      ),
                      widget2: Obx(
                        () => AppTextField(
                          txt: 'Plate Amount | ប្រាក់ប្រអប់',
                          con: con.plateAmount.value,
                          readOnly:
                              con.platePay.value == "Not Yet" ? false : true,
                          isNumber: true,
                          digit: 4,
                          onChanged: (v) => con.calculateTotal(),
                        ),
                      ),
                      widget3: AppTextField(
                        txt: 'Total | សរុប',
                        con: con.total.value,
                        readOnly: true,
                      ),
                    )
                  : Container(),
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
                    if (con.comeBy.value != 'Friend') {
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
                  readOnly: con.comeBy.value == 'Friend' ? false : true,
                ),
              ),
              widget3: Obx(
                () => AppTextField(
                  txt: 'Tel | លេខទូរស័ព្ទ',
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
                  txt: 'Commission | កម្រៃជើងសារ',
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
                AppButtonSubmit(
                  txt: 'Cancel | បោះបង់',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                    LoadingWidget.dialogLoading(duration: 1, isBack: true);
                    con.clearText();
                    await getAllLeasing();
                    conL.filteredLeasing.value = leasing;
                    conL.search.value.addListener(conL.filterLeasingData);
                    Get.back();
                    conMain.index.value = conMain.index.value - 1;
                  },
                ),
                spacer(context),
                spacer(context),
                AppButtonSubmit(
                  txt: 'Save | រក្សាទុក',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () async {
                    startInactivityTimer();
                    con.createLeasing(context);
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
