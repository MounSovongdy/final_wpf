import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/new_brand_controller.dart';

class BrandController extends GetxController {
  final con = Get.put(NewBrandController());

  var title = 'Create Brand'.obs;

  var search = TextEditingController().obs;
  var filteredBrand = [].obs;

  void filterBrandData() {
    String query = search.value.text.toLowerCase();

    filteredBrand.value = brand.where((data) {
      return data.id.toString().contains(query) ||
          data.brand.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> editBrand(int id) async {
    await getByBrandID(id);
    con.name.value.text = byBrand[0].brand;
  }
}
