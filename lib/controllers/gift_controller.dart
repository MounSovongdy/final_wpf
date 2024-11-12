import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class GiftController extends GetxController {
  var search = TextEditingController().obs;
  var filteredGift = [].obs;
  var title = 'New Gift'.obs;

  var monthList = [''].obs;
  var selectedMonth = Rxn<String>();
  var amount = TextEditingController().obs;

  void filterGiftData() {
    String query = search.value.text.toLowerCase();

    filteredGift.value = gift.where((data) {
      return data.id.toString().contains(query) ||
          '${data.year}-${data.month}'.toLowerCase().contains(query) ||
          data.item.toLowerCase().contains(query) ||
          data.amount.toLowerCase().contains(query);
    }).toList();
  }

  void calculateTotal(BuildContext context) async {
    if (selectedMonth.value != null) {
      var year = selectedMonth.split('-')?[0];
      var month = selectedMonth.split('-')?[1];
      await insertTotalExpenseGift(year: year ?? '', month: month ?? '');
      await getTotalExpense(year: year ?? '', month: month ?? '');
      amount.value.text = byTotalExpense[0].gift;
      LoadingWidget.showTextDialog(
        context,
        title: 'Successfully',
        content: 'The Gift is already updated.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please insert gift before calculate.',
        color: redColor,
      );
    }
  }
}
