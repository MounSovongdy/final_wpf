import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/reset_password_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class ResetPasswordController extends GetxController {
  var title = 'Reset Password'.obs;

  var fullNameList = [''].obs;
  var date = TextEditingController().obs;
  var fullName = Rxn<String>();
  var loginName = TextEditingController().obs;

  void clearText() {
    date.value.text = '$dateNow $timeNow';
    fullName.value = null;
    loginName.value.text = '';
  }

  void resetPassword(BuildContext context) async {
    if (fullName.value != null && loginName.value.text != '') {
      await getLastResetPassword();
      var newId = 1;
      if (byResetPassword.isNotEmpty) newId = byResetPassword[0].id + 1;
      ResetPasswordModel newRe = ResetPasswordModel(
        id: newId,
        date: date.value.text,
        name: fullName.value ?? '',
        user: loginName.value.text,
        resetBy: userLogin.value,
      );
      await resetUserPasword(newRe);
      await updateUserPassword(loginName.value.text, '123456');
      clearText();
      LoadingWidget.showTextDialog(
        context,
        title: 'Successfully',
        content: 'The Password is already reset.',
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
