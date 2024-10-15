import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar {
  static AppBar appBar(
    BuildContext context, {
    required String txt,
    required VoidCallback tap,
  }) =>
      AppBar(
        backgroundColor: bgColor,
        leading: !Responsive.isMobile(context)
            ? IconButton(onPressed: tap, icon: Icon(Icons.menu, size: 28.px))
            : null,
        title: Container(
          alignment: Alignment.centerRight,
          child: AppText.header(context, txt: txt),
        ),
      );
}
