import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class MicroController extends GetxController {
  var search = TextEditingController().obs;
  var filteredMicro = [].obs;

  void filterMicroData() {
    String query = search.value.text.toLowerCase();

    filteredMicro.value = micro.where((data) {
      return data.id.toString().contains(query) ||
          data.name.toLowerCase().contains(query);
    }).toList();
  }
}
