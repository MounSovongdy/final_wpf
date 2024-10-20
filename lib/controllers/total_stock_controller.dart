import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class TotalStockController extends GetxController {
  var search = TextEditingController().obs;
  var filteredTotalStock = [].obs;

  void filterTotalStockData() {
    String query = search.value.text.toLowerCase();

    filteredTotalStock.value = totalStock.where((data) {
      return data.id.toString().contains(query) ||
          data.model.toLowerCase().contains(query) ||
          data.brand.toLowerCase().contains(query);
    }).toList();
  }
}
