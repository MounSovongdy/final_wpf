import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewBookingController extends GetxController {
  var microList = [''].obs;
  var saleManList = [''].obs;
  var genderList = ['Male', 'Female'].obs;
  var addressList = [''].obs;
  var brandList = [''].obs;
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
  var isChecked = false.obs;

  var micro = Rxn<String>();
  var salesman = Rxn<String>();
  var gender = Rxn<String>();
  var brand = Rxn<String>();
  var model = Rxn<String>();
  var color = Rxn<String>();
  var condition = Rxn<String>();
  var comeBy = Rxn<String>();
  var address = Rxn<String>();

  var date = TextEditingController().obs;
  var idCard = TextEditingController().obs;
  var name = TextEditingController().obs;
  var age = TextEditingController().obs;
  var phoneCus = TextEditingController().obs;
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

  void clearText() {
    micro.value = null;
    salesman.value = null;
    gender.value = null;
    brand.value = null;
    model.value = null;
    color.value = null;
    condition.value = null;
    comeBy.value = null;
    address.value = null;
    date.value.clear();
    idCard.value.clear();
    name.value.clear();
    age.value.clear();
    phoneCus.value.clear();
    year.value.clear();
    sell.value.clear();
    discount.value.clear();
    depo.value.clear();
    remain.value.clear();
    nameIntro.value.clear();
    phoneIntro.value.clear();
    remark.value.clear();
  }
}
