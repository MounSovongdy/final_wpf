import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/new_color_controller.dart';

class ColorController extends GetxController {
  final con = Get.put(NewColorController());

  var title = 'Create Color'.obs;

  var search = TextEditingController().obs;
  var filteredColor = [].obs;

  void filterColorData() {
    String query = search.value.text.toLowerCase();

    filteredColor.value = color.where((data) {
      return data.id.toString().contains(query) ||
          data.color.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> editColor(int id) async {
    await getByColorID(id);
    con.name.value.text = byColor[0].color;
  }
}
