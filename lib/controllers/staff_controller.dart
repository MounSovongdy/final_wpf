import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class StaffController extends GetxController {
  var search = TextEditingController().obs;
  var filteredStaff = [].obs;
  var title = 'New Staff'.obs;

  var monthList = [''].obs;
  var selectedMonth = Rxn<String>();
  var amount = TextEditingController().obs;

  void filterStaffData() {
    String query = search.value.text.toLowerCase();

    filteredStaff.value = saleManCom.where((data) {
      return data.id.toString().contains(query) ||
          data.saleManName.toLowerCase().contains(query) ||
          '${data.year}-${data.month}'.toLowerCase().contains(query) ||
          data.saleSalary.toLowerCase().contains(query) ||
          data.saleBonus.toLowerCase().contains(query) ||
          data.unitSale.toLowerCase().contains(query) ||
          data.totalBonus.toLowerCase().contains(query);
    }).toList();
  }

  void calculateTotal(BuildContext context) async {
    if (selectedMonth.value != null) {
      var year = selectedMonth.split('-')?[0];
      var month = selectedMonth.split('-')?[1];
      await insertTotalExpenseStaff(year: year ?? '', month: month ?? '');
      await getTotalExpense(year: year ?? '', month: month ?? '');
      var temp = num.parse(byTotalExpense[0].salaryE) +
          num.parse(byTotalExpense[0].bonusE);
      amount.value.text = '$temp'.contains('.')
          ? num.parse('$temp').toStringAsFixed(2)
          : num.parse('$temp').toString();

      LoadingWidget.showTextDialog(
        context,
        title: 'Successfully',
        content: 'The Staff is already updated.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please insert staff before calculate.',
        color: redColor,
      );
    }
  }
}
