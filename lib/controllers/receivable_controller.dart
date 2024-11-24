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
  var filterPay = [].obs;

  void filterReceivableData() {
    String query = search.value.text.toLowerCase();

    filteredRece.value = receivablewithpayment.where((data) {
      return data['id'].toString().contains(query) ||
          data['saleman'].toLowerCase().contains(query) ||
          data['date'].toLowerCase().contains(query) ||
          data['name'].toLowerCase().contains(query) ||
          data['tel1'].toLowerCase().contains(query) ||
          data['tel2'].toLowerCase().contains(query) ||
          data['tel3'].toLowerCase().contains(query) ||
          data['nextPayment'].toLowerCase().contains(query) ||
          data['document'].toLowerCase().contains(query) ||
          data['brand'].toLowerCase().contains(query) ||
          data['model'].toLowerCase().contains(query) ||
          data['color'].toLowerCase().contains(query) ||
          data['year'].toLowerCase().contains(query) ||
          data['condition'].toLowerCase().contains(query) ||
          data['total'].toLowerCase().contains(query) ||
          data['receiveAmount'].toLowerCase().contains(query) ||
          data['amountLeft'].toLowerCase().contains(query) ||
          data['colorPayment'].toLowerCase().contains(query);
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
                AppButtonSubmit(
                  txt: 'Back',
                  width: 100.px,
                  color: secondGreyColor,
                  tap: () => Navigator.of(context).pop(),
                ),
                spacer(context),
                spacer(context),
                AppButtonSubmit(
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

                        LoadingWidget.dialogLoading(duration: 5, isBack: true);
                        await insertPayment(
                          id: id,
                          no: int.parse(no.value),
                          date: schedule.value ?? '',
                          paid: amount.value.text,
                          paidDate: datePayment.value.text,
                          note: remark.value.text,
                          late: schedule.value == "P"
                              ? ''
                              : dayLate <= 0
                                  ? '0'
                                  : '$dayLate',
                        );
                        clearText();
                        await getAllReceivable();
                        filteredRece.clear();
                        for (var data in receivable) {
                          var id = data.id;
                          var saleman = data.saleman;
                          var date = data.date;
                          var name = data.name;
                          var tel1 = data.tel1;
                          var tel2 = data.tel2;
                          var tel3 = data.tel3;
                          var document = data.document;
                          var brand = data.brand;
                          var model = data.model;
                          var color = data.color;
                          var year = data.year;
                          var condition = data.condition;
                          var total = data.total;
                          var receiveAmount = data.receiveAmount;
                          var amountLeft = data.amountLeft;
                          var nextPayment = '';
                          var colorPayment = '';

                          await getByPaymentTable(id);
                          var listPaid = [];
                          for (var data in byPaymentTable) {
                            if (data.type == 'Table' && data.paid == '')
                              listPaid.add(data.date);
                          }

                          if (listPaid.isNotEmpty) {
                            nextPayment = listPaid[0];
                            var today = DateTime.now();
                            var input = DateTime.parse(nextPayment);

                            var todayDate =
                                DateTime(today.year, today.month, today.day);
                            var inputDate =
                                DateTime(input.year, input.month, input.day);

                            var day = todayDate.difference(inputDate).inDays;

                            if (day > 60)
                              colorPayment = "Black";
                            else if (day > 30)
                              colorPayment = "Red";
                            else if (day > 7)
                              colorPayment = "Yellow";
                            else if (day == 0)
                              colorPayment = "Silver";
                            else if (day > 0 && day <= 7)
                              colorPayment = "Green";
                            else
                              colorPayment = "Not Yet Due";
                          } else {
                            if (num.parse(amountLeft) > 0) {
                              colorPayment = 'Out of Schedule';
                            } else if (num.parse(amountLeft) == 0) {
                              colorPayment = 'Paid Off';
                            }
                          }

                          receivablewithpayment.add({
                            'id': id,
                            'saleman': saleman,
                            'date': date,
                            'name': name,
                            'tel1': tel1,
                            'tel2': tel2,
                            'tel3': tel3,
                            'document': document,
                            'brand': brand,
                            'model': model,
                            'color': color,
                            'year': year,
                            'condition': condition,
                            'total': total,
                            'receiveAmount': receiveAmount,
                            'amountLeft': amountLeft,
                            'nextPayment': nextPayment,
                            'colorPayment': colorPayment,
                          });
                        }
                        filteredRece.value = receivablewithpayment;
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
                        LoadingWidget.dialogLoading(duration: 5, isBack: true);
                        await addMorePayment(
                          id: id,
                          paid: amount.value.text,
                          paidDate: datePayment.value.text,
                          note: remark.value.text,
                        );
                        clearText();
                        await getAllReceivable();
                        filteredRece.clear();
                        for (var data in receivable) {
                          var id = data.id;
                          var saleman = data.saleman;
                          var date = data.date;
                          var name = data.name;
                          var tel1 = data.tel1;
                          var tel2 = data.tel2;
                          var tel3 = data.tel3;
                          var document = data.document;
                          var brand = data.brand;
                          var model = data.model;
                          var color = data.color;
                          var year = data.year;
                          var condition = data.condition;
                          var total = data.total;
                          var receiveAmount = data.receiveAmount;
                          var amountLeft = data.amountLeft;
                          var nextPayment = '';
                          var colorPayment = '';

                          await getByPaymentTable(id);
                          var listPaid = [];
                          for (var data in byPaymentTable) {
                            if (data.type == 'Table' && data.paid == '')
                              listPaid.add(data.date);
                          }

                          if (listPaid.isNotEmpty) {
                            nextPayment = listPaid[0];
                            var today = DateTime.now();
                            var input = DateTime.parse(nextPayment);

                            var todayDate =
                                DateTime(today.year, today.month, today.day);
                            var inputDate =
                                DateTime(input.year, input.month, input.day);

                            var day = todayDate.difference(inputDate).inDays;

                            if (day > 60)
                              colorPayment = "Black";
                            else if (day > 30)
                              colorPayment = "Red";
                            else if (day > 7)
                              colorPayment = "Yellow";
                            else if (day == 0)
                              colorPayment = "Silver";
                            else if (day > 0 && day <= 7)
                              colorPayment = "Green";
                            else
                              colorPayment = "Not Yet Due";
                          } else {
                            if (num.parse(amountLeft) > 0) {
                              colorPayment = 'Out of Schedule';
                            } else if (num.parse(amountLeft) == 0) {
                              colorPayment = 'Paid Off';
                            }
                          }

                          receivablewithpayment.add({
                            'id': id,
                            'saleman': saleman,
                            'date': date,
                            'name': name,
                            'tel1': tel1,
                            'tel2': tel2,
                            'tel3': tel3,
                            'document': document,
                            'brand': brand,
                            'model': model,
                            'color': color,
                            'year': year,
                            'condition': condition,
                            'total': total,
                            'receiveAmount': receiveAmount,
                            'amountLeft': amountLeft,
                            'nextPayment': nextPayment,
                            'colorPayment': colorPayment,
                          });
                        }
                        filteredRece.value = receivablewithpayment;
                        search.value.addListener(filterReceivableData);
                        scheduleList.clear();
                        await getByPaymentTable(id);
                        scheduleList.clear();
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
          content: SingleChildScrollView(
            child: Column(
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
                          decoration:
                              const BoxDecoration(color: secondGreyColor),
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
                        ...byPaymentTable.map(
                          (data) {
                            return TableRow(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  color: getRowColor(data.lateDate),
                                  child: AppText.title(
                                    context,
                                    txt: '${data.no}',
                                    color: getTextRowColor(data.lateDate),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  color: getRowColor(data.lateDate),
                                  child: AppText.title(
                                    context,
                                    txt: data.date,
                                    color: getTextRowColor(data.lateDate),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  color: getRowColor(data.lateDate),
                                  child: AppText.title(
                                    context,
                                    txt: data.amount,
                                    color: getTextRowColor(data.lateDate),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  color: getRowColor(data.lateDate),
                                  child: AppText.title(
                                    context,
                                    txt: data.paid,
                                    color: getTextRowColor(data.lateDate),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  color: getRowColor(data.lateDate),
                                  child: AppText.title(
                                    context,
                                    txt: data.paidDate,
                                    color: getTextRowColor(data.lateDate),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  color: getRowColor(data.lateDate),
                                  child: AppText.title(
                                    context,
                                    txt: data.lateDate,
                                    color: getTextRowColor(data.lateDate),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            AppButtonSubmit(
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

  Color getTextRowColor(String day) {
    if (day != '') {
      var newDay = int.parse(day);
      var color = Colors.transparent;
      if (newDay > 60)
        color = Colors.white;
      else
        color = Colors.black;

      return color;
    } else {
      return Colors.black;
    }
  }

  Color getRowColor(String day) {
    if (day != '') {
      var newDay = int.parse(day);
      var color = Colors.transparent;
      if (newDay > 60)
        color = Colors.black.withOpacity(0.7);
      else if (newDay > 30)
        color = Colors.red.withOpacity(0.7);
      else if (newDay > 7)
        color = Colors.yellow.withOpacity(0.7);
      else if (newDay < 7 && newDay >= 0)
        color = Colors.green.withOpacity(0.7);
      else
        color = Colors.transparent;
      return color;
    } else {
      return Colors.transparent;
    }
  }
}
