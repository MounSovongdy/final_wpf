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

  void showDialogPayment(BuildContext context) {
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
                  con: con.totalAmount.value,
                  readOnly: true,
                ),
                widget2: AppTextField(
                  txt: 'Paid Amount',
                  con: con.paidAmount.value,
                  readOnly: true,
                ),
                widget3: AppTextField(
                  txt: 'Left Amount',
                  con: con.leftAmount.value,
                  readOnly: true,
                ),
              ),
            ],
          ),
          actions: [
            AppButton(
              txt: 'Back',
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
