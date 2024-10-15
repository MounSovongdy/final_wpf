import 'dart:async';

import 'package:flutter/material.dart';
import 'package:motor/constants/responsive.dart';
import 'package:universal_html/html.dart' as html;

const noneColor = Colors.transparent;
const bgColor = Color.fromRGBO(169, 172, 238, 1);
const greyColor = Color.fromRGBO(233, 233, 233, 1);
const secondGreyColor = Color.fromRGBO(217, 217, 217, 1);
const whiteColor = Color.fromRGBO(255, 255, 255, 1);
const blackColor = Color.fromRGBO(0, 0, 0, 1);
const redColor = Colors.red;

var defRadius = 10.0;
var defWebPad = 16.0;
var defMobPad = 8.0;

Timer? inactivityTimer;

Widget spacer(BuildContext context) {
  return SizedBox(
    height: Responsive.isDesktop(context) ? defWebPad : defMobPad,
    width: Responsive.isDesktop(context) ? defWebPad : defMobPad,
  );
}

void startInactivityTimer() {
  inactivityTimer?.cancel();
  inactivityTimer = Timer(const Duration(seconds: 10), reload);
}

void reload() {
  inactivityTimer?.cancel();
  html.window.sessionStorage.clear();
  html.window.localStorage.clear();
  html.window.location.reload();
}
