import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/product_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CreateProductController extends GetxController {
  var proBrand = TextEditingController().obs;
  var proModel = TextEditingController().obs;
  var proYear = TextEditingController().obs;

  void createProduct(BuildContext context) async {
    if (proBrand.value.text != '' &&
        proModel.value.text != '' &&
        proYear.value.text != '') {
      await getLastProduct();
      var newId = 1;
      if (product.isNotEmpty) newId = int.parse(product[0].id) + 1;

      ProductModel newProduct = ProductModel(
        id: '$newId',
        brand: proBrand.value.text,
        model: proModel.value.text,
        year: proYear.value.text,
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

  void clearText() {
    proBrand.value.clear();
    proModel.value.clear();
    proYear.value.clear();
  }
}
