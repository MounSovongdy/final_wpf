import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/cash_model.dart';
import 'package:motor/models/friend_commission_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewCashController extends GetxController {
  var saleManList = [''].obs;
  var genderList = ['ប្រុស', 'ស្រី'].obs;
  var addressList = [''].obs;
  var brandList = [''].obs;
  var modelList = [''].obs;
  var colorList = [''].obs;
  var conditionList = ['New', 'Used'].obs;
  var typeList = ['Tax Paper', 'Plate Number'].obs;
  var comeByList = [
    'Walk In',
    'Friend',
    'Facebook',
    'Tik Tok',
    'Instagram',
  ].obs;

  var isTax = true.obs;

  var dateBooking = TextEditingController().obs;
  var salesman = Rxn<String>();

  var idCard = TextEditingController().obs;
  var name = TextEditingController().obs;
  var gender = Rxn<String>();
  var age = TextEditingController().obs;
  var phoneCus = TextEditingController().obs;
  var cusAddress = Rxn<String>();

  var proBrand = Rxn<String>();
  var model = Rxn<String>();
  var year = TextEditingController().obs;
  var proColor = Rxn<String>();
  var power = TextEditingController().obs;
  var condition = Rxn<String>();
  var engine = TextEditingController().obs;
  var frame = TextEditingController().obs;
  var type = Rxn<String>();
  var plateNo = TextEditingController().obs;

  var sell = TextEditingController().obs;
  var discount = TextEditingController().obs;
  var totalPrice = TextEditingController().obs;

  var comeBy = Rxn<String>();
  var nameIntro = TextEditingController().obs;
  var phoneIntro = TextEditingController().obs;
  var commission = TextEditingController().obs;

  void createCash(BuildContext context) async {
    if (dateBooking.value.text != '' &&
        salesman.value != null &&
        idCard.value.text != '' &&
        name.value.text != '' &&
        gender.value != null &&
        age.value.text != '' &&
        phoneCus.value.text != '' &&
        cusAddress.value != null &&
        proBrand.value != null &&
        model.value != null &&
        year.value.text.length == 4 &&
        proColor.value != null &&
        power.value.text != '' &&
        condition.value != null &&
        engine.value.text != '' &&
        frame.value.text != '' &&
        type.value != null &&
        sell.value.text != '' &&
        discount.value.text != '' &&
        totalPrice.value.text != '' &&
        comeBy.value != null) {
      var id = DateFormat('yyMMddkkmmss').format(DateTime.now());
      var cashID = int.parse(id);

      await getLastFriendCommission();
      var newFriendComId = 1;
      if (friendCom.isNotEmpty) newFriendComId = friendCom[0].id + 1;

      CashModel newCash = CashModel(
        id: cashID,
        date: dateBooking.value.text,
        saleman: salesman.value ?? '',
        idCard: idCard.value.text,
        name: name.value.text,
        gender: gender.value ?? '',
        age: age.value.text,
        tel: phoneCus.value.text,
        address: cusAddress.value ?? '',
        brand: proBrand.value ?? '',
        model: model.value ?? '',
        year: year.value.text,
        color: proColor.value ?? '',
        power: power.value.text,
        condition: condition.value ?? '',
        engineNo: engine.value.text,
        frameNo: frame.value.text,
        type: type.value ?? '',
        plateNo: plateNo.value.text,
        price: sell.value.text,
        discount: discount.value.text,
        totalPrice: totalPrice.value.text,
        comeBy: comeBy.value ?? '',
        comeByName: nameIntro.value.text,
        comeByTel: phoneIntro.value.text,
        commission: commission.value.text,
      );
      FriendCommissionModel newFriCom = FriendCommissionModel(
        id: newFriendComId,
        year: '${DateTime.now().year}',
        month: '${DateTime.now().month}',
        name: nameIntro.value.text,
        tel: phoneIntro.value.text,
        commission: commission.value.text,
        unitSale: '1',
        totalCommission: commission.value.text,
      );

      if (comeBy.value == 'Friend') {
        if (nameIntro.value.text != '' &&
            phoneIntro.value.text != '' &&
            commission.value.text != '') {
          await insertFriendCommission(newFriCom);
          await insertCash(
            newCash,
            brand: proBrand.value ?? '',
            model: model.value ?? '',
            year: year.value.text,
            condition: condition.value ?? '',
            clear: clearText,
          );
        } else {
          LoadingWidget.showTextDialog(
            Get.context!,
            title: 'Error',
            content: 'Please input Friend information.',
            color: redColor,
          );
        }
      } else {
        await insertCash(
          newCash,
          brand: proBrand.value ?? '',
          model: model.value ?? '',
          year: year.value.text,
          condition: condition.value ?? '',
          clear: clearText,
        );
      }
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please input all information.',
        color: redColor,
      );
    }
  }

  void clearText() {
    dateBooking.value.text = '';
    salesman.value = null;
    idCard.value.text = '';
    name.value.text = '';
    gender.value = null;
    age.value.text = '';
    phoneCus.value.text = '';
    cusAddress.value = null;
    proBrand.value = null;
    model.value = null;
    year.value.text = '';
    proColor.value = null;
    power.value.text = '';
    condition.value = null;
    engine.value.text = '';
    frame.value.text = '';
    type.value = null;
    plateNo.value.text = '';
    sell.value.text = '';
    discount.value.text = '';
    totalPrice.value.text = '';
    comeBy.value = null;
    nameIntro.value.text = '';
    phoneIntro.value.text = '';
    commission.value.text = '';
  }

  void calculateRemain() {
    if (sell.value.text != '' && discount.value.text != '') {
      var p = num.parse(sell.value.text);
      var di = num.parse(discount.value.text);
      var re = p - di;
      var newRe = num.parse('$re').toString();
      totalPrice.value.text = newRe.contains('.')
          ? num.parse(newRe).toStringAsFixed(2)
          : num.parse(newRe).toString();
    } else {
      totalPrice.value.text = '';
    }
  }

  Future<void> saleManName() async {
    saleManList.clear();
    await getAllSaleMan();
    for (var data in saleMan) {
      saleManList.add(data.name);
    }
  }

  Future<void> brandName() async {
    brandList.clear();
    await getAllBrand();
    for (var data in brand) {
      brandList.add(data.brand);
    }
  }

  Future<void> addressName() async {
    addressList.clear();
    await getAllAddress();
    for (var data in address) {
      addressList.add(data.address);
    }
  }

  Future<void> colorName() async {
    colorList.clear();
    await getAllColor();
    for (var data in color) {
      colorList.add(data.color);
    }
  }
}
