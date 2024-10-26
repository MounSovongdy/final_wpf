import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/new_leasing_controller.dart';

class LeasingController extends GetxController {
  final con = Get.put(NewLeasingController());

  var search = TextEditingController().obs;
  var filteredLeasing = [].obs;

  void filterLeasingData() {
    String query = search.value.text.toLowerCase();

    filteredLeasing.value = user.where((data) {
      return data.id.toString().contains(query);
    }).toList();
  }

  Future<void> getBookingIDandIDCard() async {
    con.bookingIdList.clear();
    con.idCardList.clear();

    await getBookingApprove();
    for (var data in booking) {
      con.bookingIdList.add('${data.id}');
      con.idCardList.add(data.idCard);
    }
  }

  Future<void> brandName() async {
    con.brandList.clear();
    await getAllBrand();
    for (var data in brand) {
      con.brandList.add(data.brand);
    }
  }
}
