import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class GiftController extends GetxController {
  var search = TextEditingController().obs;
  var filteredGift = [].obs;
  var title = 'New Gift'.obs;

  var monthList = [''].obs;
  var selectedMonth = Rxn<String>();
  var amount = TextEditingController().obs;

  void filterGiftData() {
    String query = search.value.text.toLowerCase();

    filteredGift.value = gift.where((data) {
      return data.id.toString().contains(query) ||
          '${data.year}-${data.month}'.toLowerCase().contains(query) ||
          data.item.toLowerCase().contains(query) ||
          data.amount.toLowerCase().contains(query);
    }).toList();
  }
}
