import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class NewLeasingController extends GetxController {
  var bookingIdList = [''].obs;
  var idCardList = [''].obs;
  var brandList = [''].obs;
  var modelList = [''].obs;
  var colorList = ['Red', 'Black', 'Blue', 'White', 'Grey'].obs;
  var conditionList = ['New', 'Used'].obs;
  var typeList = ['Tax Papper', 'Plate Number'].obs;

  var isTax = true.obs;

  var bookingId = Rxn<String>();
  var idCard = Rxn<String>();

  var name = TextEditingController().obs;
  var gender = TextEditingController().obs;
  var age = TextEditingController().obs;
  var phoneCus = TextEditingController().obs;
  var address = TextEditingController().obs;

  var dateBooking = TextEditingController().obs;
  var micro = TextEditingController().obs;
  var salesman = TextEditingController().obs;

  var brand = Rxn<String>();
  var model = Rxn<String>();
  var color = Rxn<String>();
  var year = TextEditingController().obs;
  var condition = Rxn<String>();
  var engine = TextEditingController().obs;
  var frame = TextEditingController().obs;
  var type = Rxn<String>();
  var plateNo = TextEditingController().obs;

  var sell = TextEditingController().obs;
  var discount = TextEditingController().obs;
  var deposit = TextEditingController().obs;
  var remain = TextEditingController().obs;
  var approve = TextEditingController().obs;
  var totalOwn = TextEditingController().obs;

  var nameIntro = TextEditingController().obs;
  var phoneIntro = TextEditingController().obs;
  var comeBy = TextEditingController().obs;
  var commission = TextEditingController().obs;

  void getDataByBookingIDAndIdCard() {
    var bookId = bookingId.value ?? '0';

    if (idCard.value != null) {
      for (var data in booking) {
        if (idCard.value == data.idCard) {
          bookingId.value = '${data.id}';
          bookId = bookingId.value!;
        }
      }
    }

    for (var data in booking) {
      if (int.tryParse(bookId) == data.id) {
        idCard.value = data.idCard;
        name.value.text = data.name;
        age.value.text = data.age;
        phoneCus.value.text = data.tel;
        address.value.text = data.address;
        dateBooking.value.text = data.bookingDate;
        micro.value.text = data.micro;
        salesman.value.text = data.saleman;
        brand.value = data.brand;
        model.value = data.model;
        color.value = data.color;
        year.value.text = data.year;
        condition.value = data.condition;
        sell.value.text = data.price;
        discount.value.text = data.discount;
        deposit.value.text = data.deposit;
        remain.value.text = data.remain;
      }
    }
  }

  void calculateRemain() {
    if (sell.value.text != '' &&
        discount.value.text != '' &&
        deposit.value.text != '') {
      var p = int.parse(sell.value.text);
      var di = int.parse(discount.value.text);
      var de = int.parse(deposit.value.text);
      var re = p - (di + de);
      remain.value.text = '$re';
    } else {
      remain.value.text = '';
    }
  }

  void calculateTotalDebt() {
    if (remain.value.text != '' && approve.value.text != '') {
      var re = int.parse(remain.value.text);
      var app = int.parse(approve.value.text);
      var totDebt = re - app;
      totalOwn.value.text = '$totDebt';
    } else {
      totalOwn.value.text = '';
    }
  }
}
