import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/firebase.dart';

class TotalExpenseController extends GetxController{
  var search = TextEditingController().obs;
  var filteredUsers = [].obs;

  void filterUserData() {
    String query = search.value.text.toLowerCase();

    filteredUsers.value = byUser.where((data) {
      return data.id.toString().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.role.toLowerCase().contains(query);
    }).toList();
  }

  var expense = TextEditingController().obs;
  var days = TextEditingController().obs;
  var amount = TextEditingController().obs;

  bool isVisibleEmp = false;
  bool isVisibleTech = false;
  bool isVisibleAds = false;
  bool isVisibleKPI = false;
  bool isVisibleGift = false;
  bool isVisibleCommission = false;
}