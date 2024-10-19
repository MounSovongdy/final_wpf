import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/user_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CreateUserController extends GetxController {
  String? role;
  var name = TextEditingController().obs;
  var userLogin = TextEditingController().obs;

  void createUser(BuildContext context) async {
    if (name.value.text != '' && userLogin.value.text != '' && role != null) {
      await getLastUser();
      var newId = 1;
      if (byUser.isNotEmpty) newId = int.parse(byUser[0].id) + 1;

      UserModel newUser = UserModel(
        id: '$newId',
        name: name.value.text,
        user: userLogin.value.text,
        password: '123456',
        role: role ?? '',
        dateCreate:
            '${dateFormat.format(DateTime.now())} ${timeFormat.format(DateTime.now())}',
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

  void clearText() {
    name.value.clear();
    userLogin.value.clear();
  }
}
