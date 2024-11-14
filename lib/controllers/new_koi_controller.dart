import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/koi_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewKoiController extends GetxController {
  var date = TextEditingController().obs;
  var name = TextEditingController().obs;
  var amount = TextEditingController().obs;

  void createKoi(BuildContext context) async {
    if (date.value.text != '' &&
        name.value.text != '' &&
        amount.value.text != '') {
      await getLastKoi();
      var newId = 1;
      if (koi.isNotEmpty) newId = koi[0].id + 1;
      var newDate = DateTime.parse(date.value.text);
      KoiModel newKoi = KoiModel(
        id: newId,
        year: '${newDate.year}',
        month: '${newDate.month}',
        date: date.value.text,
        name: name.value.text,
        amount: amount.value.text,
      );
      await insertKoi(newKoi);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The KoL already created.',
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
    name.value.text = '';
    amount.value.text = '';
  }
}
