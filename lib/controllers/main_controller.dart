import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  var drawer = true.obs;
  var index = 0.obs;

  var date = TextEditingController().obs;
  var location = TextEditingController().obs;
  String? bookingStatus;
  var name = TextEditingController().obs;
  String? microStatus;
  String? maritalStatus;
  String? genderStatus;
  String? salesmanStatus;
  String? brand;
  String? model;
  String? color;
  String? condition;
  var phone1 = TextEditingController().obs;
  var age = TextEditingController().obs;
  var address = TextEditingController().obs;
  var code = TextEditingController().obs;
  var year = TextEditingController().obs;
  var sell = TextEditingController().obs;
  var dis = TextEditingController().obs;
  var nameIntro = TextEditingController().obs;
  var phoneIntro = TextEditingController().obs;
  var depo = TextEditingController().obs;
  var remain = TextEditingController().obs;
  var remark = TextEditingController().obs;

  var type = TextEditingController().obs;
  var proBrand = TextEditingController().obs;
  var proModel = TextEditingController().obs;
  var proYear = TextEditingController().obs;
  var proColor = TextEditingController().obs;
  var proCondi = TextEditingController().obs;
  var qty = TextEditingController().obs;
  var arrDate = TextEditingController().obs;
  var descr = TextEditingController().obs;
  var finanCost = TextEditingController().obs;
  var finanSell = TextEditingController().obs;
  var proSts = TextEditingController().obs;
  var proDes = TextEditingController().obs;

  void controlDrawer() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    } else {
      _scaffoldKey.currentState!.closeDrawer();
    }
  }

  void controlMenu() {
    drawer.value = !drawer.value;
  }
}
