import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashController extends GetxController {

  var idCard = TextEditingController().obs;
  var name = TextEditingController().obs;
  String? gender;
  var age = TextEditingController().obs;
  var phoneCus = TextEditingController().obs;
  var address = TextEditingController().obs;

  var dateBooking = TextEditingController().obs;
  String? salesman;

  String? brand;
  String? model;
  String? color;
  var year = TextEditingController().obs;
  String? condition;
  var engine = TextEditingController().obs;
  var frame = TextEditingController().obs;
  var plateNo = TextEditingController().obs;

  var sell = TextEditingController().obs;
  var discount = TextEditingController().obs;
  var totalPrice = TextEditingController().obs;

  var nameIntro = TextEditingController().obs;
  var phoneIntro = TextEditingController().obs;
  var comeBy = TextEditingController().obs;
  var commission = TextEditingController().obs;
}