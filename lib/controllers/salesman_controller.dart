import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class SalesmanController extends GetxController {
  var search = TextEditingController().obs;
  var filteredSale = [].obs;

  void filterSaleData() {
    String query = search.value.text.toLowerCase();

    filteredSale.value = saleMan.where((data) {
      return data.id.toString().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.gender.toLowerCase().contains(query) ||
          data.tel.toLowerCase().contains(query) ||
          data.position.toLowerCase().contains(query) ||
          data.salary.toLowerCase().contains(query) ||
          data.bonus.toLowerCase().contains(query) ||
          data.date.toLowerCase().contains(query);
    }).toList();
  }
}
