import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

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
}
