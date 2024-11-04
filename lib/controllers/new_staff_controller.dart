import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/sale_man_commission_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewStaffController extends GetxController {
  var nameList = [''].obs;

  var date = TextEditingController().obs;
  var saleId = 0.obs;
  var saleName = Rxn<String>();
  var salary = TextEditingController().obs;
  var bonus = TextEditingController().obs;
  var unitSale = TextEditingController(text: '0').obs;

  Future<void> createStaff(BuildContext context) async {
    if (date.value.text != '' &&
        saleName.value != null &&
        salary.value.text != '' &&
        bonus.value.text != '' &&
        unitSale.value.text != '') {
      var newDate = DateTime.parse(date.value.text);
      await getBySaleManNameCom(
        year: '${newDate.year}',
        month: '${newDate.month}',
        name: saleName.value ?? '',
      );
      var newSaleComId = 1;
      if (bySaleManCom.isEmpty) {
        await getLastSaleManCommission();
        if (saleManCom.isNotEmpty) newSaleComId = saleManCom[0].id + 1;

        SaleManCommissionModel newSale = SaleManCommissionModel(
          id: newSaleComId,
          year: '${newDate.year}',
          month: '${newDate.month}',
          saleManId: saleId.value,
          saleManName: saleName.value ?? '',
          saleBonus: bonus.value.text,
          saleSalary: salary.value.text,
          unitSale: unitSale.value.text,
          totalBonus:
              '${int.parse(salary.value.text) + (int.parse(bonus.value.text) * int.parse(unitSale.value.text))}',
        );
        await insertSaleManCommission(
          year: '${newDate.year}',
          month: '${newDate.month}',
          name: saleName.value ?? '',
          saleCom: newSale,
        );
        clearText();
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Successfully',
          content: 'The Staff already created.',
          color: greenColor,
        );
      } else {
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Warnning',
          content: 'The staff is already create.',
          color: redColor,
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
    date.value.text = '';
    saleId.value = 0;
    saleName.value = null;
    salary.value.text = '';
    bonus.value.text = '';
    unitSale.value.text = '0';
  }
}
