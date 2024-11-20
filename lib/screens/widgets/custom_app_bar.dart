import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar {
  static AppBar defAppBar(
    BuildContext context, {
    required String txt,
    required String role,
    required VoidCallback tap,
  }) {
    var size = Responsive.isDesktop(context) ? 30 : 26;

    return AppBar(
      backgroundColor: bgColor,
      leading: !Responsive.isMobile(context)
          ? IconButton(
              onPressed: tap,
              icon: Icon(Icons.menu, size: size.px, color: whiteColor),
            )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: Responsive.isDesktop(context) ? size.px : size.px - 2,
            width: Responsive.isDesktop(context) ? size.px : size.px - 2,
            decoration: const BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/Profile.png'),
              ),
            ),
          ),
          SizedBox(width: defWebPad.px / 1.5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.header(context, txt: txt, space: 1.5, color: whiteColor),
              AppText.subTitle(context, txt: role, color: whiteColor),
            ],
          ),
        ],
      ),
    );
  }
}
