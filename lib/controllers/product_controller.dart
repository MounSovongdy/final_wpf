import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class ProductController extends GetxController {
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
}
