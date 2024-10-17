import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStockController extends GetxController {
  List<String> listModel = [];

  String? model;
  String? condition;
  var brand = TextEditingController().obs;
  var proYear = TextEditingController().obs;
  var qBegin = TextEditingController().obs;
  var priceQBegin = TextEditingController().obs;
  var totalPriceQBegin = TextEditingController().obs;
  var dateIn = TextEditingController().obs;

  var date = TextEditingController().obs;
  var qty = TextEditingController().obs;
  var price = TextEditingController().obs;
  var totalPrice = TextEditingController().obs;
}
