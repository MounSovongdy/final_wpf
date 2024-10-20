import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewBookingController extends GetxController {
  var microList = [''].obs;
  var saleManList = [''].obs;
  var genderList = ['Male', 'Female'].obs;
  var modelList = [''].obs;
  var colorList = ['Red', 'Black', 'Blue', 'White', 'Grey'].obs;
  var conditionList = ['New', 'Used'].obs;
  var comeByList = [
    'Walk In',
    'Friend',
    'Facebook',
    'Tik Tok',
    'Instagram',
  ].obs;

  var isFriend = false.obs;

  String? micro;
  String? salesman;
  String? gender;
  String? model;
  String? color;
  String? condition;
  String? comeBy;

  var date = TextEditingController().obs;
  var idCard = TextEditingController().obs;
  var name = TextEditingController().obs;
  var age = TextEditingController().obs;
  var phoneCus = TextEditingController().obs;
  var address = TextEditingController().obs;
  var brand = TextEditingController().obs;
  var year = TextEditingController().obs;
  var sell = TextEditingController().obs;
  var discount = TextEditingController().obs;
  var depo = TextEditingController().obs;
  var remain = TextEditingController().obs;
  var nameIntro = TextEditingController().obs;
  var phoneIntro = TextEditingController().obs;
  var remark = TextEditingController().obs;

  void calculateRemain() {
    if (sell.value.text != '' &&
        discount.value.text != '' &&
        depo.value.text != '') {
      var p = int.parse(sell.value.text);
      var di = int.parse(discount.value.text);
      var de = int.parse(depo.value.text);
      var re = p - (di + de);
      remain.value.text = '$re';
    } else {
      remain.value.text = '';
    }
  }
}
