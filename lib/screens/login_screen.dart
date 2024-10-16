import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/login_controll.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final con = Get.put(LoginControll());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 650.px,
          height: 450.px,
          padding: EdgeInsets.symmetric(horizontal: defWebPad.px * 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: secondGreyColor),
            color: greyColor.withOpacity(0.2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.largeHeader(context, txt: "Motor Shop System"),
              spacer(context),
              spacer(context),
              AppTextField(flex: 4, txt: 'User Login', con: con.email.value),
              spacer(context),
              Obx(
                () => AppTextField(
                  flex: 4,
                  txt: 'Password',
                  con: con.pass.value,
                  obscureText: con.visible.value,
                  showSuffixIcon: true,
                  suffix: InkWell(
                    onTap: () => con.visible.value = !con.visible.value,
                    child: Icon(con.visible.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
              ),
              spacer(context),
              spacer(context),
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  txt: 'Login',
                  tap: () => con.login(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
