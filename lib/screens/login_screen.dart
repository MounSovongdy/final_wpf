import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/login_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildLoginForm(context),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    var flex = !Responsive.isMobile(context) ? 4 : 2;
    return Row(
      children: [
        Responsive.isDesktop(context) ?
        Expanded(
          flex: 1,
          child: Container(
            color: whiteColor,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Loginlogo1.png'),
                  ),
                ),
              ),
            ),
          ),
        ): Container(),
        Expanded(
          flex: 1,
          child: Container(
            color: greyColor,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 650.px,
                padding: EdgeInsets.symmetric(horizontal: defWebPad.px * flex),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.px,
                      height: 150.px,
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/Systemlogo.png'),
                        ),
                      ),
                    ),
                    spacer(context),
                    AppText.largeHeader(context, txt: "Motor Shop Management System"),
                    AppText.subTitle(context, txt: "Login to continue | ចូលដើម្បីបន្តបន្ទាប់"),
                    spacer(context),
                    spacer(context),
                    spacer(context),
                    AppTextFieldLogin(
                        flex: flex, txt: 'User Login​ | អ្នកប្រើប្រាស់', con: con.email.value),
                    spacer(context),
                    Obx(
                      () => AppTextFieldLogin(
                        flex: flex,
                        txt: 'Password​ | ពាក្យសម្ងាត់',
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
                      child: AppButtonLogin(
                        txt: 'Login | ចូល',
                        tap: () => con.login(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
