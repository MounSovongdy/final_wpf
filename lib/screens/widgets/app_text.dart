import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppText {
  static Widget largeHeader(
    BuildContext context, {
    required String txt,
    double size = 26,
    double? space,
    Color color = blackColor,
    FontWeight fontWeight = FontWeight.bold,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) =>
      Text(
        txt,
        style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: Responsive.isDesktop(context) ? size.px : size.px - 2,
          fontWeight: fontWeight,
          overflow: overflow,
        ),
      );

  static Widget header(
    BuildContext context, {
    required String txt,
    double size = 18,
    double? space,
    Color color = blackColor,
    FontWeight fontWeight = FontWeight.w900,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) =>
      Text(
        txt,
        style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: Responsive.isDesktop(context) ? size.px : size.px - 2,
          fontWeight: fontWeight,
          overflow: overflow,
        ),
      );

  static Widget title(
      BuildContext context, {
        required String txt,
        double size = 16,
        double? space,
        Color color = blackColor,
        FontWeight fontWeight = FontWeight.w500,
        TextOverflow overflow = TextOverflow.ellipsis,
        TextAlign textAlign = TextAlign.left,
      }) =>
      Text(
        txt,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: Responsive.isDesktop(context) ? size.px : size.px - 2,
          fontWeight: fontWeight,
          overflow: overflow,
        ),
      );

  static Widget titleWhite(
      BuildContext context, {
        required String txt,
        double size = 16,
        double? space,
        Color color = whiteColor,
        FontWeight fontWeight = FontWeight.w500,
        TextOverflow overflow = TextOverflow.ellipsis,
        TextAlign textAlign = TextAlign.left,
      }) =>
      Text(
        txt,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: Responsive.isDesktop(context) ? size.px : size.px - 2,
          fontWeight: fontWeight,
          overflow: overflow,
        ),
      );

  static Widget subTitle(
    BuildContext context, {
    required String txt,
    double size = 14,
    double? space,
    Color color = blackColor,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) =>
      Text(
        txt,
        style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: Responsive.isDesktop(context) ? size.px : size.px - 2,
          fontWeight: fontWeight,
          overflow: overflow,
        ),
      );
}
