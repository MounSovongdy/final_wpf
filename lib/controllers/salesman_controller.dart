import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/create_salesman_controller.dart';

class SalesmanController extends GetxController {
  final con = Get.put(CreateSalesmanController());
  var title = 'Create Salesman'.obs;

  var search = TextEditingController().obs;
  var filteredSale = [].obs;

  void filterSaleData() {
    String query = search.value.text.toLowerCase();

    filteredSale.value = saleMan.where((data) {
      return data.id.toString().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.gender.toLowerCase().contains(query) ||
          data.tel.toLowerCase().contains(query) ||
          data.position.toLowerCase().contains(query) ||
          data.salary.toLowerCase().contains(query) ||
          data.bonus.toLowerCase().contains(query) ||
          data.date.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> editSales(int id) async {
    await getBySaleManID(id);
    con.fullName.value.text = bySaleMan[0].name;
    con.gender.value = bySaleMan[0].gender;
    con.tel.value.text = bySaleMan[0].tel;
    con.position.value = bySaleMan[0].position;
    con.salary.value.text = bySaleMan[0].salary;
    con.bonus.value.text = bySaleMan[0].bonus;
    con.joinDate.value.text = bySaleMan[0].date;
  }
}
