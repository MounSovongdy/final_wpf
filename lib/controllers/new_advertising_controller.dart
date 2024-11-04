import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/advertising_controller.dart';
import 'package:motor/models/advertising_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewAdvertisingController extends GetxController {
  final con = Get.put(AdvertisingController());

  var date = TextEditingController().obs;
  var detail = TextEditingController().obs;
  var amount = TextEditingController().obs;

  void createAdvertise(BuildContext context) async {
    if (date.value.text != '' && amount.value.text != '') {
      await getLastAdvertise();
      var newId = 1;
      if (advertise.isNotEmpty) newId = advertise[0].id + 1;
      var newDate = DateTime.parse(date.value.text);
      AdvertisingModel newAdv = AdvertisingModel(
        id: newId,
        year: '${newDate.year}',
        month: '${newDate.month}',
        date: date.value.text,
        detail: detail.value.text,
        amount: amount.value.text,
      );
      await insertAdvertise(newAdv);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The advertising already created.',
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
    date.value.text = '';
    detail.value.text = '';
    amount.value.text = '';
  }
}
