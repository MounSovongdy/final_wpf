import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/user_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CreateUserController extends GetxController {
  var role = Rxn<String>();
  var name = TextEditingController().obs;
  var userLogin = TextEditingController().obs;
  var dateNow = dateFormat.format(DateTime.now());
  var timeNow = timeFormat.format(DateTime.now());

  void createUser(BuildContext context) async {
    if (name.value.text != '' &&
        userLogin.value.text != '' &&
        role.value != null) {
      await getLastUser();
      var newId = 1;
      if (user.isNotEmpty) newId = user[0].id + 1;

      UserModel newUser = UserModel(
        id: newId,
        name: name.value.text,
        user: userLogin.value.text,
        password: '123456',
        role: role.value ?? '',
        dateCreate: '$dateNow $timeNow',
        status: 'Online',
      );
      await insertUser(newUser);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The user already created.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please input all information.',
        color: redColor,
      );
    }
  }

  void updateUser(BuildContext context) async {
    if (name.value.text != '' &&
        userLogin.value.text != '' &&
        role.value != null) {
      UserModel newUser = UserModel(
        name: name.value.text,
        user: userLogin.value.text,
        role: role.value ?? '',
        id: byUser[0].id,
        password: byUser[0].password,
        dateCreate: byUser[0].dateCreate,
        status: 'Online',
      );
      await updateByUser(byUser[0].id, newUser);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The user already updated.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please input all information.',
        color: redColor,
      );
    }
  }

  void clearText() {
    name.value.clear();
    role.value = null;
    userLogin.value.clear();
  }
}
