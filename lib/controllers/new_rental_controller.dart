import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/rental_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewRentalController extends GetxController {
  var date = TextEditingController().obs;
  var detail = TextEditingController().obs;
  var amount = TextEditingController().obs;

  void createRental(BuildContext context) async {
    if (date.value.text != '' && amount.value.text != '') {
      await getLastRental();
      var newId = 1;
      if (rental.isNotEmpty) newId = rental[0].id + 1;
      var newDate = DateTime.parse(date.value.text);
      RentalModel newRen = RentalModel(
        id: newId,
        year: '${newDate.year}',
        month: '${newDate.month}',
        date: date.value.text,
        detail: detail.value.text,
        amount: amount.value.text,
      );
      await insertRental(newRen);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Rental already created.',
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
