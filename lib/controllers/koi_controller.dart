import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KoiController extends GetxController{
  var search = TextEditingController().obs;
  var filteredUsers = [].obs;
  var title = 'New KOI'.obs;
  var selectedMonth = Rxn<String>();
  var monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ].obs;

  var amount = TextEditingController().obs;
}