import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/add_stock_controller.dart';

class TotalStockController extends GetxController {
  final con = Get.put(AddStockController());

  var title = 'Add Stock'.obs;

  var search = TextEditingController().obs;
  var filteredTotalStock = [].obs;

  void filterTotalStockData() {
    String query = search.value.text.toLowerCase();

    filteredTotalStock.value = totalStock.where((data) {
      return data.id.toString().contains(query) ||
          data.model.toLowerCase().contains(query) ||
          data.brand.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> editTotalStock(int id) async {
    await getByTotalStockID(id);
    con.isRead.value = true;
    con.model.value = byTotalStock[0].model;
    con.brand.value.text = byTotalStock[0].brand;
    con.proYear.value.text = byTotalStock[0].year;
    con.condition.value = byTotalStock[0].condition;
    con.dateIn.value.text = byTotalStock[0].oldDateIn;
    con.qBegin.value.text = byTotalStock[0].oldQty;
    con.priceQBegin.value.text = byTotalStock[0].oldPrice;
    con.totalPriceQBegin.value.text = byTotalStock[0].oldTotalPrice;
    con.date.value.text = byTotalStock[0].newDateIn;
    con.qty.value.text = byTotalStock[0].newQty;
    con.price.value.text = byTotalStock[0].newPrice;
    con.totalPrice.value.text = byTotalStock[0].newTotalPrice;
  }
}
