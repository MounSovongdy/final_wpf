import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/new_receivable_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/widgets/app_text.dart';
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

  var datePayment = TextEditingController().obs;
  var amount = TextEditingController().obs;
  var remark = TextEditingController().obs;

  void showDialogAddPayment(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: AppText.header(context, txt: 'Add Payment'),
          content: Column(
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
              RowTextField(
                spacer: spacer(context),
                widget1: AppTextField(
                  txt: 'Date',
                  con: datePayment.value,
                ),
                widget2: AppTextField(
                  txt: 'Amount',
                  con: amount.value,
                ),
                widget3: AppTextField(
                  txt: 'Remark',
                  con: remark.value,
                ),
              ),
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
                AppButton(
                  txt: 'Save',
                  width: 100.px,
                  tap: () => {},
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: AppText.header(context, txt: 'View Payment'),
          content: Column(
            children: [
              SizedBox(
                width: 800,
                child: Table(
                  border: TableBorder.all(), // Adds border around table
                  columnWidths: const {
                    0: FractionColumnWidth(0.2), // Set widths for columns
                    1: FractionColumnWidth(0.1),
                    2: FractionColumnWidth(0.1),
                    3: FractionColumnWidth(0.2),
                    4: FractionColumnWidth(0.1),
                    5: FractionColumnWidth(0.1),
                    6: FractionColumnWidth(0.2),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Total Amount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Paid Amount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Paid Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Days left',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Remark',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('2024-10-28'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('500'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('100'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('2024-10-29'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('1'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.yellow,
                            ),
                          )
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('test remark'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('2024-11-28'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('400'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('100'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 3,
                              height: 3,
                              color: noneColor,
                            )
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                      ],
                    ),
                  ],
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
