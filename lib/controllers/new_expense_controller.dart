import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewExpenseController extends GetxController {
  var type = TextEditingController().obs;
  var date = TextEditingController().obs;
  var name = TextEditingController().obs;
  var amount = TextEditingController().obs;
  var remark = TextEditingController().obs;
}