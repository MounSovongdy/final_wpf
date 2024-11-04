import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

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
}
