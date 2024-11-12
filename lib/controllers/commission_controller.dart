import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CommissionController extends GetxController {
  var search = TextEditingController().obs;
  var filteredCommission = [].obs;

  var monthList = [''].obs;
  var selectedMonth = Rxn<String>();
  var amount = TextEditingController().obs;

  void filterCommissionData() {
    String query = search.value.text.toLowerCase();

    filteredCommission.value = friendCom.where((data) {
      return data.id.toString().contains(query) ||
          '${data.year}-${data.month}'.toLowerCase().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.tel.toLowerCase().contains(query) ||
          data.totalCommission.toLowerCase().contains(query);
    }).toList();
  }

  void calculateTotal(BuildContext context) async {
    if (selectedMonth.value != null) {
      var year = selectedMonth.split('-')?[0];
      var month = selectedMonth.split('-')?[1];
      await insertTotalExpenseFriend(year: year ?? '', month: month ?? '');

      await getTotalExpense(year: year ?? '', month: month ?? '');
      amount.value.text = byTotalExpense[0].commission;
      LoadingWidget.showTextDialog(
        context,
        title: 'Successfully',
        content: 'The Friend is already updated.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please insert friend before calculate.',
        color: redColor,
      );
    }
  }
}
