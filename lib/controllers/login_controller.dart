import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/screens/main_screen.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class LoginController extends GetxController {
  var email = TextEditingController().obs;
  var pass = TextEditingController().obs;

  var visible = true.obs;
  var visibleNew = true.obs;
  var visibleCon = true.obs;

  void login(BuildContext context) async {
    if (email.value.text != '' && pass.value.text != '') {
      await getByUser(email.value.text);

      if (byUser.isNotEmpty) {
        if (pass.value.text == byUser[0].password) {
          if (pass.value.text == '123456') {
            changePassword(Get.context!);
          } else {
            startInactivityTimer();
            pass.value.clear();
            Get.offAll(() => MainScreen());
          }
        } else {
          LoadingWidget.showTextDialog(
            Get.context!,
            title: 'Error',
            color: redColor,
            content: 'Your password not correct.',
          );
        }
      } else {
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Error',
          color: redColor,
          content: 'Your user login not correct.',
        );
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        color: redColor,
        content: 'User login and password can not be blank.',
      );
    }
  }

  void changePassword(BuildContext context) {
    final oldPass = TextEditingController(text: pass.value.text);
    final newPass = TextEditingController();
    final conPass = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: AppText.header(context, txt: 'Change new password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: oldPass,
                readOnly: true,
                obscureText: true,
                decoration: const InputDecoration(
                  fillColor: secondGreyColor,
                  labelText: 'Old Password',
                ),
              ),
              spacer(context),
              Obx(
                () => TextField(
                  controller: newPass,
                  obscureText: visibleNew.value,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    suffixIcon: InkWell(
                      onTap: () => visibleNew.value = !visibleNew.value,
                      child: Icon(
                        visibleNew.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
              ),
              spacer(context),
              Obx(
                () => TextField(
                  controller: conPass,
                  obscureText: visibleCon.value,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: InkWell(
                      onTap: () => visibleCon.value = !visibleCon.value,
                      child: Icon(
                        visibleCon.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText.title(context, txt: 'Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (newPass.text == conPass.text &&
                    newPass.text != '' &&
                    conPass.text != '') {
                  if (newPass.text.length > 6 && conPass.text.length > 6) {
                    Navigator.of(context).pop();
                    startInactivityTimer();
                    pass.value.clear();
                    await updateUserPassword(email.value.text, conPass.text);
                    Get.offAll(() => MainScreen());
                  } else {
                    LoadingWidget.showTextDialog(
                      Get.context!,
                      title: 'Error',
                      color: redColor,
                      content: 'Password must be bigger than 6 length.',
                    );
                  }
                } else {
                  LoadingWidget.showTextDialog(
                    Get.context!,
                    title: 'Error',
                    color: redColor,
                    content: 'Password not the same',
                  );
                }
              },
              child: AppText.title(context, txt: 'Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  void onClose() {
    email.close();
    pass.close();

    super.onClose();
  }
}
