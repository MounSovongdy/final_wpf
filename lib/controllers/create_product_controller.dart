import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/product_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CreateProductController extends GetxController {
  var brandList = [''].obs;

  var model = TextEditingController().obs;
  var brand = Rxn<String>();

  void createProduct(BuildContext context) async {
    if (brand.value != null && model.value.text != '') {
      await getLastProduct();
      var newId = 1;
      if (product.isNotEmpty) newId = product[0].id + 1;

      ProductModel newProduct = ProductModel(
        id: newId,
        brand: brand.value ?? '',
        model: model.value.text,
      );
      await insertProduct(newProduct);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Product already created.',
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

  void updateProduct(BuildContext context) async {
    if (brand.value != null && model.value.text != '') {
      ProductModel newPro = ProductModel(
        brand: brand.value ?? '',
        model: model.value.text,
        id: byProduct[0].id,
      );
      await updateByProduct(byProduct[0].id, newPro);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Product already updated.',
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
    brand.value = null;
    model.value.clear();
  }
}
