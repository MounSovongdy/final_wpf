import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';

class DashboardCardController extends GetxController{
  
  final itemTitle = [
    {'name': 'Leasing'},
    {'name': 'Cash'},
    {'name': 'Active'},
    {'name': 'Close'}
  ];

  final icons = const [
    Icon(Icons.access_alarm),
    Icon(Icons.account_balance),
    Icon(Icons.ac_unit),
    Icon(Icons.ad_units),
  ];

  final itemValue = [
    {'value': 2},
    {'value': 5},
    {'value': 12},
    {'value': 27},
  ];

  final cardColor = [
    {'color': greenColor.withOpacity(0.5)},
    {'color': updateColor.withOpacity(0.7)},
    {'color': bgColor.withOpacity(0.3)},
    {'color': redColor.withOpacity(0.8)},
  ];

  var bookingApproved = '--'.obs;
  var bookingRejected = '--'.obs;
  var bookingCanceled = '--'.obs;
  var bookingCompleted = '--'.obs;
}