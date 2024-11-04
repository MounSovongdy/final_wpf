import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/gift_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewGiftController extends GetxController {
  var date = TextEditingController().obs;
  var item = TextEditingController().obs;
  var amount = TextEditingController().obs;

  void createGift(BuildContext context) async {
    if (date.value.text != '' &&
        item.value.text != '' &&
        amount.value.text != '') {
      await getLastGift();
      var newId = 1;
      if (gift.isNotEmpty) newId = gift[0].id + 1;
      var newDate = DateTime.parse(date.value.text);
      GiftModel newGift = GiftModel(
        id: newId,
        year: '${newDate.year}',
        month: '${newDate.month}',
        date: date.value.text,
        item: item.value.text,
        amount: amount.value.text,
      );
      await insertGift(newGift);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Gift already created.',
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
    item.value.text = '';
    amount.value.text = '';
  }
}
