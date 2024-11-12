import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class AdvertisingController extends GetxController {
  var search = TextEditingController().obs;
  var filteredAdv = [].obs;
  var title = 'New Advertising'.obs;

  var selectedMonth = Rxn<String>();
  var monthList = [''].obs;
  var amount = TextEditingController().obs;

  void filterAdvData() {
    String query = search.value.text.toLowerCase();

    filteredAdv.value = advertise.where((data) {
      return data.id.toString().contains(query) ||
          '${data.year}-${data.month}'.toLowerCase().contains(query) ||
          data.detail.toLowerCase().contains(query) ||
          data.amount.toLowerCase().contains(query);
    }).toList();
  }

    void calculateTotal(BuildContext context) async {
    if (selectedMonth.value != null) {
      var year = selectedMonth.split('-')?[0];
      var month = selectedMonth.split('-')?[1];
      await insertTotalExpenseAdv(year: year ?? '', month: month ?? '');
      await getTotalExpense(year: year ?? '', month: month ?? '');
      amount.value.text = totalExpense[0].advertise;
      LoadingWidget.showTextDialog(
        context,
        title: 'Successfully',
        content: 'The Advertise is already updated.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please insert advertise before calculate.',
        color: redColor,
      );
    }
  }

}
