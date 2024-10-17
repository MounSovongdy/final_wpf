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
  String? micro;
  String? maritalStatus;
  String? gender;
  String? salesman;
  String? brand;
  String? model;
  String? color;
  String? condition;
  var phoneCus = TextEditingController().obs;
  var age = TextEditingController().obs;
  var address = TextEditingController().obs;
  var code = TextEditingController().obs;
  var year = TextEditingController().obs;
  var sell = TextEditingController().obs;
  var discount = TextEditingController().obs;
  var nameIntro = TextEditingController().obs;
  var phoneIntro = TextEditingController().obs;
  var depo = TextEditingController().obs;
  var remain = TextEditingController().obs;
  var remark = TextEditingController().obs;

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
