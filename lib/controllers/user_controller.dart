import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/create_user_controller.dart';

class UserController extends GetxController {
  final con = Get.put(CreateUserController());

  var title = 'Create User'.obs;

  var search = TextEditingController().obs;
  var filteredUsers = [].obs;

  void filterUserData() {
    String query = search.value.text.toLowerCase();

    filteredUsers.value = user.where((data) {
      return data.id.toString().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.role.toLowerCase().contains(query) ||
          data.user.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> editUser(int id) async {
    await getByUserID(id);
    con.name.value.text = byUser[0].name;
    con.role.value = byUser[0].role;
    con.userLogin.value.text = byUser[0].user;
  }
}
