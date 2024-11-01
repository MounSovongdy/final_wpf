import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/address_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CreateAddressController extends GetxController {
  final add = TextEditingController().obs;

  Future<void> createAddress(BuildContext context) async {
    if (add.value.text != '') {
      await getLastAddress();
      var newId = 1;
      if (byAddress.isNotEmpty) newId = byAddress[0].id + 1;

      AddressModel newAddress = AddressModel(
        id: newId,
        address: add.value.text,
      );
      await insertAddress(newAddress);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Address already created.',
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

  Future<void> updateAddress(BuildContext context) async {
    if (add.value.text != '') {
      AddressModel newAddress = AddressModel(
        address: add.value.text,
        id: byAddress[0].id,
      );
      await updateByAddress(byAddress[0].id, newAddress);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Address already updated.',
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
    add.value.text = '';
  }
}
