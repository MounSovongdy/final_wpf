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

    filteredLeasing.value = leasing.where((data) {
      return data.id.toString().contains(query) ||
          data.leasingDate.toLowerCase().contains(query) ||
          data.idCard.toLowerCase().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.age.toLowerCase().contains(query) ||
          data.tel.toLowerCase().contains(query) ||
          data.address.toLowerCase().contains(query) ||
          data.micro.toLowerCase().contains(query) ||
          data.brand.toLowerCase().contains(query) ||
          data.model.toLowerCase().contains(query) ||
          data.color.toLowerCase().contains(query) ||
          data.year.toLowerCase().contains(query) ||
          data.condition.toLowerCase().contains(query) ||
          data.price.toLowerCase().contains(query) ||
          data.remain.toLowerCase().contains(query) ||
          data.approveAmount.toLowerCase().contains(query) ||
          data.totalDebt.toLowerCase().contains(query) ||
          data.saleman.toLowerCase().contains(query) ||
          data.comeBy.toLowerCase().contains(query);
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
