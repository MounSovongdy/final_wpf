import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class KoiController extends GetxController {
  var search = TextEditingController().obs;
  var filteredKoi = [].obs;
  var title = 'New KOI'.obs;

  var monthList = [''].obs;
  var selectedMonth = Rxn<String>();
  var amount = TextEditingController().obs;

  void filterKoiData() {
    String query = search.value.text.toLowerCase();

    filteredKoi.value = koi.where((data) {
      return data.id.toString().contains(query) ||
          '${data.year}-${data.month}'.toLowerCase().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.amount.toLowerCase().contains(query);
    }).toList();
  }

  void calculateTotal(BuildContext context) async {
    if (selectedMonth.value != null) {
      var year = selectedMonth.split('-')?[0];
      var month = selectedMonth.split('-')?[1];
      await insertTotalExpenseKoi(year: year ?? '', month: month ?? '');
      await getTotalExpense(year: year ?? '', month: month ?? '');
      amount.value.text = totalExpense[0].koi;
      LoadingWidget.showTextDialog(
        context,
        title: 'Successfully',
        content: 'The Koi is already updated.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please insert koi before calculate.',
        color: redColor,
      );
    }
  }
}
