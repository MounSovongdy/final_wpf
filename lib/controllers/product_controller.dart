import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/create_product_controller.dart';

class ProductController extends GetxController {
  final con = Get.put(CreateProductController());

  var title = 'Create Product'.obs;

  var search = TextEditingController().obs;
  var filteredProduct = [].obs;

  void filterProductData() {
    String query = search.value.text.toLowerCase();

    filteredProduct.value = product.where((data) {
      return data.id.toString().contains(query) ||
          data.model.toLowerCase().contains(query) ||
          data.brand.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> editProduct(int id) async {
    await getByProductID(id);
    con.model.value.text = byProduct[0].model;
    con.brand.value = byProduct[0].brand;
  }
}
