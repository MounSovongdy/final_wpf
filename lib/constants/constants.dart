import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motor/constants/responsive.dart';
import 'package:pdf/pdf.dart';
import 'package:universal_html/html.dart' as html;

const noneColor = Colors.transparent;
const bgColor = Color.fromARGB(255, 13, 22, 139);
const greyColor = Color.fromRGBO(233, 233, 233, 1);
const secondGreyColor = Color.fromRGBO(217, 217, 217, 1);
const whiteColor = Color.fromRGBO(255, 255, 255, 1);
const blackColor = Color.fromRGBO(0, 0, 0, 1);
const redColor = Colors.red;
const greenColor = Colors.green;
const updateColor = Color.fromARGB(255, 0, 217, 255);

const invoiceText = PdfColor.fromInt(0xff031993);

var defRadius = 10.0;
var defWebPad = 16.0;
var defMobPad = 8.0;

var dateFormat = DateFormat('yyyy-MM-dd');
var timeFormat = DateFormat.Hm();
var dateNow = dateFormat.format(DateTime.now());
var timeNow = timeFormat.format(DateTime.now());

Timer? inactivityTimer;

SizedBox spacer(BuildContext context) {
  return SizedBox(
    height: Responsive.isDesktop(context) ? defWebPad : defMobPad,
    width: Responsive.isDesktop(context) ? defWebPad : defMobPad,
  );
}

void startInactivityTimer() {
  inactivityTimer?.cancel();
  inactivityTimer = Timer(const Duration(minutes: 45), reload);
}

void reload() {
  inactivityTimer?.cancel();
  html.window.sessionStorage.clear();
  html.window.localStorage.clear();
  html.window.location.reload();
}
