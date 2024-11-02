import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/new_receivable_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_date_text_field.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReceivableController extends GetxController {
  final con = Get.put(NewReceivableController());

  var search = TextEditingController().obs;
  var filteredRece = [].obs;

  void filterReceivableData() {
    String query = search.value.text.toLowerCase();

    filteredRece.value = receivable.where((data) {
      return data.id.toString().contains(query) ||
          data.saleman.toLowerCase().contains(query) ||
          data.date.toLowerCase().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.tel1.toLowerCase().contains(query) ||
          data.tel2.toLowerCase().contains(query) ||
          data.tel3.toLowerCase().contains(query) ||
          data.document.toLowerCase().contains(query) ||
          data.brand.toLowerCase().contains(query) ||
          data.model.toLowerCase().contains(query) ||
          data.color.toLowerCase().contains(query) ||
          data.year.toLowerCase().contains(query) ||
          data.condition.toLowerCase().contains(query) ||
          data.total.toLowerCase().contains(query) ||
          data.receiveAmount.toLowerCase().contains(query) ||
          data.amountLeft.toLowerCase().contains(query);
    }).toList();
  }

  var totalAmount = TextEditingController().obs;
  var paidAmount = TextEditingController().obs;
  var leftAmount = TextEditingController().obs;
  var scheduleList = [''].obs;
  var no = ''.obs;
  var schedule = Rxn<String>();
  var scheduleAmount = TextEditingController().obs;
  var datePayment = TextEditingController().obs;
  var amount = TextEditingController().obs;
  var remark = TextEditingController().obs;

  void clearText() {
    totalAmount.value.text = '';
    paidAmount.value.text = '';
    leftAmount.value.text = '';
    schedule.value = null;
    scheduleAmount.value.text = '';
    datePayment.value.text = '';
    amount.value.text = '';
    remark.value.text = '';
  }

  void showDialogAddPayment(BuildContext context, int id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: AppText.header(context, txt: 'Add Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RowTextField(
                spacer: spacer(context),
                widget1: AppTextField(
                  txt: 'Total Amount',
                  con: totalAmount.value,
                  readOnly: true,
                ),
                widget2: AppTextField(
                  txt: 'Paid Amount',
                  con: paidAmount.value,
                  readOnly: true,
                ),
                widget3: AppTextField(
                  txt: 'Left Amount',
                  con: leftAmount.value,
                  readOnly: true,
                ),
              ),
              spacer(context),
              TitleUnderline(
                spacer: spacer(context),
                txt: 'Payment Schedule',
              ),
              RowTextField(
                spacer: spacer(context),
                widget1: Obx(
                  () => scheduleList.isNotEmpty
                      ? AppDropdownSearch(
                          txt: 'Date',
                          value: schedule,
                          list: scheduleList,
                          onChanged: (v) {
                            if (v != null) {
                              schedule.value = v;
                              for (var data in byPaymentTable) {
                                if (v == data.date) {
                                  scheduleAmount.value.text = data.amount;
                                  no.value = '${data.no}';
                                }
                              }
                            }
                          },
                        )
                      : AppDropdownSearch(
                          txt: 'Date',
                          value: schedule,
                          list: const [''],
                          onChanged: (v) {},
                        ),
                ),
                widget2: AppTextField(
                  txt: 'Amount',
                  con: scheduleAmount.value,
                  readOnly: true,
                ),
              ),
              spacer(context),
              TitleUnderline(
                spacer: spacer(context),
                txt: 'Customer Paid',
              ),
              RowTextField(
                spacer: spacer(context),
                widget1: AppDateTextField(
                  txt: 'Date',
                  con: datePayment.value,
                ),
                widget2: AppTextField(
                  txt: 'Amount',
                  con: amount.value,
                  isNumber: true,
                  digit: 7,
                ),
                widget3: AppTextField(
                  txt: 'Remark',
                  con: remark.value,
                ),
              ),
              spacer(context),
              spacer(context),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  txt: 'Back',
                  width: 100.px,
                  color: secondGreyColor,
                  tap: () => Navigator.of(context).pop(),
                ),
                spacer(context),
                spacer(context),
                AppButton(
                  txt: 'Save',
                  width: 100.px,
                  tap: () async {
                    if (scheduleList.isNotEmpty) {
                      if (schedule.value != null &&
                          amount.value.text != '' &&
                          datePayment.value.text != '') {
                        var dayLate = 0;
                        if (schedule.value != "P") {
                          var paidDate = DateTime.parse(datePayment.value.text);
                          var scheDate = DateTime.parse(schedule.value ?? '');
                          var date1 = DateTime(
                            paidDate.year,
                            paidDate.month,
                            paidDate.day,
                          );
                          var date2 = DateTime(
                            scheDate.year,
                            scheDate.month,
                            scheDate.day,
                          );
                          Duration diff = date1.difference(date2);
                          dayLate = diff.inDays;
                        } else {
                          dayLate = -1;
                        }

                        LoadingWidget.dialogLoading(duration: 5, isBack: false);
                        await insertPayment(
                          id: id,
                          no: int.parse(no.value),
                          date: schedule.value ?? '',
                          paid: amount.value.text,
                          paidDate: datePayment.value.text,
                          note: remark.value.text,
                          late: dayLate <= 0
                              ? '0'
                              : dayLate == -1
                                  ? ''
                                  : '$dayLate',
                        );
                        clearText();
                        await getAllReceivable();
                        filteredRece.value = receivable;
                        search.value.addListener(filterReceivableData);
                        Get.back();

                        LoadingWidget.showTextDialog(
                          Get.context!,
                          title: 'Successfully',
                          content: 'The Payment is success added.',
                          color: greenColor,
                        );
                      } else {
                        LoadingWidget.showTextDialog(
                          context,
                          title: 'Error',
                          content: 'Please input all information.',
                          color: redColor,
                        );
                      }
                    } else {
                      if (amount.value.text != '' &&
                          datePayment.value.text != '') {
                        LoadingWidget.dialogLoading(duration: 5, isBack: false);
                        await addMorePayment(
                          id: id,
                          paid: amount.value.text,
                          paidDate: datePayment.value.text,
                          note: remark.value.text,
                        );
                        clearText();
                        await getAllReceivable();
                        filteredRece.value = receivable;
                        search.value.addListener(filterReceivableData);
                        scheduleList.clear();
                        await getByPaymentTable(id);
                        for (var data in byPaymentTable) {
                          if (data.date != '' && data.paid == '') {
                            scheduleList.add(data.date);
                          }
                        }

                        Get.back();

                        LoadingWidget.showTextDialog(
                          Get.context!,
                          title: 'Successfully',
                          content: 'The Payment is success added.',
                          color: greenColor,
                        );
                      } else {
                        LoadingWidget.showTextDialog(
                          context,
                          title: 'Error',
                          content: 'Please input all information.',
                          color: redColor,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showDialogViewPayment(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: AppText.header(context, txt: 'View Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: SingleChildScrollView(
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      0: FractionColumnWidth(0.1),
                      1: FractionColumnWidth(0.2),
                      2: FractionColumnWidth(0.15),
                      3: FractionColumnWidth(0.15),
                      4: FractionColumnWidth(0.2),
                      5: FractionColumnWidth(0.2),
                    },
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: secondGreyColor),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText.title(
                              context,
                              txt: 'No',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText.title(
                              context,
                              txt: 'Date',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText.title(
                              context,
                              txt: 'Amount',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText.title(
                              context,
                              txt: 'Paid',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText.title(
                              context,
                              txt: 'Paid Date',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText.title(
                              context,
                              txt: 'Day Late',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ...byPaymentTable.map((data) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText.title(
                                context,
                                txt: '${data.no}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText.title(
                                context,
                                txt: data.date,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText.title(
                                context,
                                txt: data.amount,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText.title(
                                context,
                                txt: data.paid,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText.title(
                                context,
                                txt: data.paidDate,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText.title(
                                context,
                                txt: data.lateDate,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            AppButton(
              txt: 'Close',
              width: 100.px,
              color: secondGreyColor,
              tap: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
