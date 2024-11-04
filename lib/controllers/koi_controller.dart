import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

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
}
