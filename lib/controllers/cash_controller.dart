import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class CashController extends GetxController {
  var search = TextEditingController().obs;
  var filteredCash = [].obs;

  void filterCashData() {
    String query = search.value.text.toLowerCase();

    filteredCash.value = cash.where((data) {
      return data.id.toString().contains(query) ||
          data.date.toLowerCase().contains(query) ||
          data.idCard.toLowerCase().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.age.toLowerCase().contains(query) ||
          data.tel.toLowerCase().contains(query) ||
          data.address.toLowerCase().contains(query) ||
          data.brand.toLowerCase().contains(query) ||
          data.model.toLowerCase().contains(query) ||
          data.color.toLowerCase().contains(query) ||
          data.year.toLowerCase().contains(query) ||
          data.condition.toLowerCase().contains(query) ||
          data.price.toLowerCase().contains(query) ||
          data.saleman.toLowerCase().contains(query) ||
          data.comeBy.toLowerCase().contains(query);
    }).toList();
  }
}
