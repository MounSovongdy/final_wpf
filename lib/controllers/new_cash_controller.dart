import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCashController extends GetxController {

  var idCard = TextEditingController().obs;
  var name = TextEditingController().obs;
  var gender = Rxn<String>();
  var age = TextEditingController().obs;
  var phoneCus = TextEditingController().obs;
  var address = TextEditingController().obs;

  var dateBooking = TextEditingController().obs;
  var salesman = Rxn<String>();

  var brand = Rxn<String>();
  var model = Rxn<String>();
  var color = Rxn<String>();
  var year = TextEditingController().obs;
  var condition = Rxn<String>();
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