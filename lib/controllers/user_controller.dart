import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class UserController extends GetxController {
  var search = TextEditingController().obs;
  var filteredUsers = [].obs;

  void filterUserData() {
    String query = search.value.text.toLowerCase();

    filteredUsers.value = user.where((data) {
      return data.id.toString().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.role.toLowerCase().contains(query);
    }).toList();
  }
}
