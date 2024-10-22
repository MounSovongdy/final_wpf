import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/sale_man_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CreateSalesmanController extends GetxController {
  var gender = Rxn<String>();
  var position = Rxn<String>();

  var fullName = TextEditingController().obs;
  var tel = TextEditingController().obs;
  var salary = TextEditingController().obs;
  var bonus = TextEditingController().obs;
  var joinDate = TextEditingController().obs;

  void createSaleman(BuildContext context) async {
    if (fullName.value.text != '' &&
        salary.value.text != '' &&
        bonus.value.text != '' &&
        gender.value != null &&
        position.value != null) {
      await getLastSaleMan();
      var newId = 1;
      if (saleMan.isNotEmpty) newId = saleMan[0].id + 1;

      SaleManModel newSale = SaleManModel(
        id: newId,
        name: fullName.value.text,
        gender: gender.value ?? '',
        tel: tel.value.text,
        position: position.value ?? '',
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

  void updateSaleman(BuildContext context) async {
    if (fullName.value.text != '' &&
        salary.value.text != '' &&
        bonus.value.text != '' &&
        gender.value != null &&
        position.value != null) {
      SaleManModel newSale = SaleManModel(
        name: fullName.value.text,
        gender: gender.value ?? '',
        tel: tel.value.text,
        position: position.value ?? '',
        salary: salary.value.text,
        bonus: bonus.value.text,
        date: joinDate.value.text,
        id: bySaleMan[0].id,
      );
      await updateBySalenan(bySaleMan[0].id, newSale);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Salesman already updated.',
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
    gender.value = null;
    position.value = null;
    fullName.value.clear();
    tel.value.clear();
    salary.value.clear();
    bonus.value.clear();
    joinDate.value.clear();
  }
}
