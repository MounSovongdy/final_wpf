import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginControll extends GetxController {
  var email = TextEditingController().obs;
  var pass = TextEditingController().obs;

  var visible = true.obs;
}
