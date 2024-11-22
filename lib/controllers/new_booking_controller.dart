import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/booking_micro_model.dart';
import 'package:motor/models/booking_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewBookingController extends GetxController {
  var microList = [''].obs;
  var saleManList = [''].obs;
  var genderList = ['ប្រុស', 'ស្រី'].obs;
  var addressList = [''].obs;
  var brandList = [''].obs;
  var modelList = [''].obs;
  var colorList = [''].obs;
  var conditionList = ['New', 'Used'].obs;
  var comeByList = [
    'Walk In',
    'Friend',
    'Facebook',
    'Tik Tok',
    'Instagram',
  ].obs;

  var isFriend = false.obs;
  var isRead = false.obs;

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
  var power = TextEditingController().obs;
  var sell = TextEditingController().obs;
  var discount = TextEditingController().obs;
  var deposit = TextEditingController().obs;
  var remain = TextEditingController().obs;
  var nameIntro = TextEditingController().obs;
  var phoneIntro = TextEditingController().obs;
  var remark = TextEditingController().obs;

  void createBooking(BuildContext context) async {
    var newRemain = int.tryParse(remain.value.text) ?? -1;

    if (micro.value != null &&
        salesman.value != null &&
        gender.value != null &&
        brand.value != null &&
        model.value != null &&
        color.value != null &&
        power.value.text != '' &&
        condition.value != null &&
        comeBy.value != null &&
        address.value != null &&
        date.value.text != '' &&
        idCard.value.text != '' &&
        name.value.text != '' &&
        age.value.text != '' &&
        phoneCus.value.text != '' &&
        year.value.text.length == 4 &&
        sell.value.text != '' &&
        discount.value.text != '' &&
        deposit.value.text != '' &&
        newRemain >= 0) {
      LoadingWidget.dialogLoading(duration: 5, isBack: true);

      await getLastBooking();
      var id = DateFormat('yyMMddkkmmss').format(DateTime.now());
      int newBookID = int.parse(id);

      var newBookMicroID = 1;
      if (bookingMicro.isNotEmpty) newBookMicroID = bookingMicro[0].id + 1;

      BookingModel newBook = BookingModel(
        id: newBookID,
        bookingDate: date.value.text,
        micro: micro.value ?? '',
        saleman: salesman.value ?? '',
        idCard: idCard.value.text,
        name: name.value.text,
        gender: gender.value ?? '',
        age: age.value.text,
        tel: phoneCus.value.text,
        address: address.value ?? '',
        brand: brand.value ?? '',
        model: model.value ?? '',
        year: year.value.text,
        color: color.value ?? '',
        power: power.value.text,
        condition: condition.value ?? '',
        price: sell.value.text,
        discount: discount.value.text,
        deposit: deposit.value.text,
        remain: remain.value.text,
        comeBy: comeBy.value ?? '',
        comeByName: nameIntro.value.text,
        comeByTel: phoneIntro.value.text,
        remark: remark.value.text,
        statusBooking: 'New',
        statusDate: '',
        statusDone: '',
        workingHours: '',
      );
      BookingMicroModel newBookMicro = BookingMicroModel(
        id: newBookMicroID,
        bookingID: newBookID,
        bookingDate: date.value.text,
        name: name.value.text,
        idCard: idCard.value.text,
        tel: phoneCus.value.text,
        micro1: micro.value ?? '',
        statusBooking1: 'New',
        statusDate1: '',
        workingHours1: '',
        micro2: '',
        statusBooking2: '',
        statusDate2: '',
        workingHours2: '',
      );

      await insertBooking(newBook, newBookMicro);
      clearText();
      Navigator.of(context).pop();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Booking already created.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please input all information.',
        color: redColor,
      );
    }
  }

  void updateBooking(BuildContext context) async {
    var newRemain = int.tryParse(remain.value.text) ?? -1;

    if (micro.value != null &&
        salesman.value != null &&
        gender.value != null &&
        brand.value != null &&
        model.value != null &&
        color.value != null &&
        condition.value != null &&
        comeBy.value != null &&
        address.value != null &&
        date.value.text != '' &&
        idCard.value.text != '' &&
        name.value.text != '' &&
        age.value.text != '' &&
        phoneCus.value.text != '' &&
        year.value.text.length == 4 &&
        sell.value.text != '' &&
        discount.value.text != '' &&
        deposit.value.text != '' &&
        newRemain >= 0) {
      BookingModel newBook = BookingModel(
        bookingDate: date.value.text,
        micro: micro.value ?? '',
        saleman: salesman.value ?? '',
        idCard: idCard.value.text,
        name: name.value.text,
        gender: gender.value ?? '',
        age: age.value.text,
        tel: phoneCus.value.text,
        address: address.value ?? '',
        brand: brand.value ?? '',
        model: model.value ?? '',
        year: year.value.text,
        color: color.value ?? '',
        power: power.value.text,
        condition: condition.value ?? '',
        price: sell.value.text,
        discount: discount.value.text,
        deposit: deposit.value.text,
        remain: remain.value.text,
        comeBy: comeBy.value ?? '',
        comeByName: nameIntro.value.text,
        comeByTel: phoneIntro.value.text,
        remark: remark.value.text,
        id: byBooking[0].id,
        statusBooking: byBooking[0].statusBooking,
        statusDate: byBooking[0].statusDate,
        statusDone: byBooking[0].statusDone,
        workingHours: byBooking[0].workingHours,
      );
      BookingMicroModel newBookMicro = BookingMicroModel(
        bookingDate: date.value.text,
        name: name.value.text,
        idCard: idCard.value.text,
        tel: phoneCus.value.text,
        micro1: micro.value ?? '',
        id: byBookingMicro[0].id,
        bookingID: byBookingMicro[0].bookingID,
        statusBooking1: byBookingMicro[0].statusBooking1,
        statusDate1: byBookingMicro[0].statusDate1,
        workingHours1: byBookingMicro[0].workingHours1,
        micro2: byBookingMicro[0].micro2,
        statusBooking2: byBookingMicro[0].statusBooking2,
        statusDate2: byBookingMicro[0].statusDate2,
        workingHours2: byBookingMicro[0].workingHours2,
      );

      LoadingWidget.dialogLoading(duration: 5, isBack: true);
      await updateByBooking(byBooking[0].id, newBook, newBookMicro);
      Get.back();
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The booking already updated.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please input all information.',
        color: redColor,
      );
    }
  }

  void calculateRemain() {
    if (sell.value.text != '' &&
        discount.value.text != '' &&
        deposit.value.text != '') {
      var p = num.parse(sell.value.text);
      var di = num.parse(discount.value.text);
      var de = num.parse(deposit.value.text);
      var re = p - (di + de);
      var newRe = num.parse('$re').toString();
      remain.value.text = newRe.contains('.')
          ? num.parse(newRe).toStringAsFixed(2)
          : num.parse(newRe).toString();
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
    date.value.text = '$dateNow $timeNow';
    idCard.value.clear();
    name.value.clear();
    age.value.clear();
    phoneCus.value.clear();
    year.value.clear();
    power.value.clear();
    sell.value.clear();
    discount.value.clear();
    deposit.value.clear();
    remain.value.clear();
    nameIntro.value.clear();
    phoneIntro.value.clear();
    remark.value.clear();
  }
}
