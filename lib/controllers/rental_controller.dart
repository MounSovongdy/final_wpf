import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class RentalController extends GetxController {
  var search = TextEditingController().obs;
  var filteredRental = [].obs;
  var title = 'New Rental'.obs;

  var monthList = [''].obs;
  var selectedMonth = Rxn<String>();
  var amount = TextEditingController().obs;

  void filterRentalData() {
    String query = search.value.text.toLowerCase();

    filteredRental.value = rental.where((data) {
      return data.id.toString().contains(query) ||
          '${data.year}-${data.month}'.toLowerCase().contains(query) ||
          data.detail.toLowerCase().contains(query) ||
          data.amount.toLowerCase().contains(query);
    }).toList();
  }
}
