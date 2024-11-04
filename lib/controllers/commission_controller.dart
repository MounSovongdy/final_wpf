import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

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
}
