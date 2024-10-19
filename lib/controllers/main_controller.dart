import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  var drawer = true.obs;
  var index = 0.obs;

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
