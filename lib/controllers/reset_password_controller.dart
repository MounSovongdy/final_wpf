import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController{
  var date = TextEditingController().obs;
  var name = TextEditingController().obs;
  var title = 'Reset Password'.obs;

  var fullNameList = [''].obs;
  var fullName = Rxn<String>();
}