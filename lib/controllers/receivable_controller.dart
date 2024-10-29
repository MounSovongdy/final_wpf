import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class ReceivableController extends GetxController {
  var search = TextEditingController().obs;
  var filteredRece = [].obs;

  void filterReceivableData() {
    String query = search.value.text.toLowerCase();

    filteredRece.value = receivable.where((data) {
      return data.id.toString().contains(query) ||
          data.saleman.toLowerCase().contains(query) ||
          data.date.toLowerCase().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.tel1.toLowerCase().contains(query) ||
          data.tel2.toLowerCase().contains(query) ||
          data.tel3.toLowerCase().contains(query) ||
          data.document.toLowerCase().contains(query) ||
          data.brand.toLowerCase().contains(query) ||
          data.model.toLowerCase().contains(query) ||
          data.color.toLowerCase().contains(query) ||
          data.year.toLowerCase().contains(query) ||
          data.condition.toLowerCase().contains(query) ||
          data.total.toLowerCase().contains(query) ||
          data.receiveAmount.toLowerCase().contains(query) ||
          data.amountLeft.toLowerCase().contains(query);
    }).toList();
  }
}
