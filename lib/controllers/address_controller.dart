import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/create_address_controller.dart';

class AddressController extends GetxController {
  final con = Get.put(CreateAddressController());

  var title = 'Create Address'.obs;

  var search = TextEditingController().obs;
  var filteredAddress = [].obs;

  void filterAddressData() {
    String query = search.value.text.toLowerCase();

    filteredAddress.value = address.where((data) {
      return data.id.toString().contains(query) || data.address.contains(query);
    }).toList();
  }

  Future<void> editAddress(int id) async {
    await getByAddressID(id);
    con.add.value.text = byAddress[0].address;
  }
}
