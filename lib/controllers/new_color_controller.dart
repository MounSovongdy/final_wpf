import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/color_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewColorController extends GetxController {
  final name = TextEditingController().obs;

  void clearText() {
    name.value.text = '';
  }

  Future<void> createColor(BuildContext context) async {
    if (name.value.text != '') {
      await getLastColor();
      var newId = 1;
      if (color.isNotEmpty) newId = color[0].id + 1;

      ColorModel newColor = ColorModel(
        id: newId,
        color: name.value.text,
      );
      await insertColor(newColor);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Color already created.',
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

  Future<void> updateColor(BuildContext context) async {
    if (name.value.text != '') {
      ColorModel newColor = ColorModel(
        color: name.value.text,
        id: byColor[0].id,
      );
      await updateByColor(byColor[0].id, newColor);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Color already updated.',
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
}
