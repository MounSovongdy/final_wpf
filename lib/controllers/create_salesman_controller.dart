import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/sale_man_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CreateSalesmanController extends GetxController {
  String? gender;
  String? position;

  var fullName = TextEditingController().obs;
  var tel = TextEditingController().obs;
  var salary = TextEditingController().obs;
  var bonus = TextEditingController().obs;
  var joinDate = TextEditingController().obs;

  void createSaleman(BuildContext context) async {
    if (fullName.value.text != '' &&
        salary.value.text != '' &&
        bonus.value.text != '' &&
        joinDate.value.text != '' &&
        gender != null &&
        position != null) {
      await getLastSaleMan();
      var newId = 1;
      if (saleMan.isNotEmpty) newId = int.parse(saleMan[0].id) + 1;

      SaleManModel newSale = SaleManModel(
        id: '$newId',
        name: fullName.value.text,
        gender: gender ?? '',
        tel: tel.value.text,
        position: position ?? '',
        salary: salary.value.text,
        bonus: bonus.value.text,
        date: joinDate.value.text,
      );
      await insertSaleMan(newSale);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Saleman already created.',
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

  void clearText() {
    fullName.value.clear();
    tel.value.clear();
    salary.value.clear();
    bonus.value.clear();
    joinDate.value.clear();
  }
}
