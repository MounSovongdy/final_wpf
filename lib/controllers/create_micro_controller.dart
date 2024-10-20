import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/micro_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class CreateMicroController extends GetxController {
  var nameInstitution = TextEditingController().obs;
  var tel = TextEditingController().obs;
  var email = TextEditingController().obs;
  var tBonus = TextEditingController().obs;

  var nameContact = TextEditingController().obs;
  var telContact = TextEditingController().obs;
  var emailContact = TextEditingController().obs;
  var positionContact = TextEditingController().obs;

  void createMicro(BuildContext context) async {
    if (nameInstitution.value.text != '' && tBonus.value.text != '') {
      await getLastMicro();
      var newId = 1;
      if (micro.isNotEmpty) newId = micro[0].id + 1;

      MicroModel newMicro = MicroModel(
        id: newId,
        name: nameInstitution.value.text,
        tel: tel.value.text,
        email: email.value.text,
        tBonus: tBonus.value.text,
        contactName: nameContact.value.text,
        contactTel: telContact.value.text,
        contactEmail: emailContact.value.text,
        contactPosition: positionContact.value.text,
      );
      await insertMicro(newMicro);
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Micro already created.',
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
    nameInstitution.value.clear();
    tel.value.clear();
    email.value.clear();
    tBonus.value.clear();
    nameContact.value.clear();
    telContact.value.clear();
    emailContact.value.clear();
    positionContact.value.clear();
  }
}
