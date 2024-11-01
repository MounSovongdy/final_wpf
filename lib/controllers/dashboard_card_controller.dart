import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardCardController extends GetxController{
  final itemTitle = [
    {'name': 'Booking'},
    {'name': 'Sale Record'},
    {'name': 'Receivable'},
    {'name': 'Total Stock'},
    {'name': 'Booking'},
    {'name': 'Sale Record'},
    {'name': 'Receivable'},
    {'name': 'Total Stock'},
  ];

  final icons = [
    Icon(Icons.access_alarm),
    Icon(Icons.account_balance),
    Icon(Icons.ac_unit),
    Icon(Icons.ad_units),
  ];

  final itemListBooking = [
    {'name': '2','name2':'Rejected','name3': 'Canceled','name4': 'Completed'},
    {'name': '1','name2':'8','name3': 'Canceled','name4': 'Completed'},
    {'name': '6','name2':'Rejected','name3': 'Canceled','name4': 'Completed'},
    {'name': '9','name2':'9','name3': 'Canceled','name4': '7'},
  ];

  var bookingApproved = '--'.obs;
  var bookingRejected = '--'.obs;
  var bookingCanceled = '--'.obs;
  var bookingCompleted = '--'.obs;
}