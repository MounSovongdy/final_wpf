import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinanceRecordController extends GetxController {
  var monthList = [''].obs;

  var totalExpense = TextEditingController().obs;
  var selectedMonth = Rxn<String>();
  var amount = TextEditingController().obs;
}
