import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateSalesmanController extends GetxController{
  var fullName = TextEditingController().obs;
  String? gender;
  var tel = TextEditingController().obs;
  var position = TextEditingController().obs;
  var salary = TextEditingController().obs;
  var bonus = TextEditingController().obs;
  var joinDate = TextEditingController().obs;
}