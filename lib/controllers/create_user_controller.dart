import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserController extends GetxController{
  var fullName = TextEditingController().obs;
  var tel = TextEditingController().obs;
  String? role;
  var user = TextEditingController().obs;
  var password = TextEditingController().obs;
  var conPassword = TextEditingController().obs;
}