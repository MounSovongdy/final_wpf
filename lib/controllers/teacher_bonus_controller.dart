import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

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
}
