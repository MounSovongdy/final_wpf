import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar {
  static AppBar defAppBar(
    BuildContext context, {
    required String txt,
    required VoidCallback tap,
  }) {
    var size = Responsive.isDesktop(context) ? 28 : 24;

    return AppBar(
      backgroundColor: bgColor,
      leading: !Responsive.isMobile(context)
          ? IconButton(
              onPressed: tap,
              icon: Icon(Icons.menu, size: size.px, color: blackColor),
            )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/Profile.png',
            height: Responsive.isDesktop(context) ? 28.px : 28.px - 2,
          ),
          SizedBox(width: defWebPad.px / 1.5),
          AppText.header(context, txt: txt, space: 1.5),
        ],
      ),
    );
  }
}
