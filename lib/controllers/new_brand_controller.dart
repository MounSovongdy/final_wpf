import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/brand_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewBrandController extends GetxController {
  final name = TextEditingController().obs;

  void clearText() {
    name.value.text = '';
  }

  Future<void> createBrand(BuildContext context) async {
    if (name.value.text != '') {
      await getLastBrand();
      var newId = 1;
      if (brand.isNotEmpty) newId = brand[0].id + 1;

      BrandModel newBrand = BrandModel(
        id: newId,
        brand: name.value.text,
      );
      await insertBrand(newBrand);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Brand already created.',
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

  Future<void> updateBrand(BuildContext context) async {
    if (name.value.text != '') {
      BrandModel newBrand = BrandModel(
        brand: name.value.text,
        id: byBrand[0].id,
      );
      await updateByBrand(byBrand[0].id, newBrand);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Brand already updated.',
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
