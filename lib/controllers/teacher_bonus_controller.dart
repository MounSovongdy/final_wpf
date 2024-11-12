import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class MicroExpenseController extends GetxController {
  var search = TextEditingController().obs;
  var filteredMicro = [].obs;

  var monthList = [''].obs;
  var selectedMonth = Rxn<String>();
  var amount = TextEditingController().obs;

  void filterMicroData() {
    String query = search.value.text.toLowerCase();

    filteredMicro.value = microCom.where((data) {
      return data.id.toString().contains(query) ||
          '${data.year}-${data.month}'.toLowerCase().contains(query) ||
          data.microName.toLowerCase().contains(query) ||
          data.tBonus.toLowerCase().contains(query) ||
          data.unitSale.toLowerCase().contains(query) ||
          data.totalBonus.toLowerCase().contains(query);
    }).toList();
  }

  void calculateTotal(BuildContext context) async {
    if (selectedMonth.value != null) {
      var year = selectedMonth.split('-')?[0];
      var month = selectedMonth.split('-')?[1];
      await insertTotalExpenseBonusT(year: year ?? '', month: month ?? '');
      await getTotalExpense(year: year ?? '', month: month ?? '');
      amount.value.text = byTotalExpense[0].bonusT;
      LoadingWidget.showTextDialog(
        context,
        title: 'Successfully',
        content: 'The Bonus Teacher is already updated.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please insert bonus teacher before calculate.',
        color: redColor,
      );
    }
  }
}
