import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CreateUserController extends GetxController {
  String? role;
  var fullName = TextEditingController().obs;
  var user = TextEditingController().obs;

  void createUser(BuildContext context) {
    if (fullName.value.text != '' && user.value.text != '' && role != '') {
      
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please input all information.',
        color: redColor,
      );
    }
  }
}
