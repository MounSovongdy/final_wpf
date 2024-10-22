import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/add_stock_model.dart';
import 'package:motor/models/total_stock_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class AddStockController extends GetxController {
  List<String> listModel = [];

  var isRead = false.obs;

  var model = Rxn<String>();
  var condition = Rxn<String>();

  var brand = TextEditingController().obs;
  var proYear = TextEditingController().obs;
  var qBegin = TextEditingController().obs;
  var priceQBegin = TextEditingController().obs;
  var totalPriceQBegin = TextEditingController().obs;
  var dateIn = TextEditingController().obs;

  var date = TextEditingController().obs;
  var qty = TextEditingController().obs;
  var price = TextEditingController().obs;
  var totalPrice = TextEditingController().obs;

  void createAddStock(BuildContext context) async {
    var newQty = int.tryParse(qty.value.text);

    if (model.value != null &&
        brand.value.text != '' &&
        proYear.value.text.length == 4 &&
        condition.value != null &&
        date.value.text != '' &&
        newQty! > 0 &&
        price.value.text != '' &&
        totalPrice.value.text != '') {
      await getLastAddStock();
      await getLastTotalStock();

      var newAddId = 1;
      var newTotalId = 1;
      if (addStock.isNotEmpty) newAddId = addStock[0].id + 1;
      if (totalStock.isNotEmpty) newTotalId = totalStock[0].id + 1;

      AddStockModel newAddStock = AddStockModel(
        id: newAddId,
        model: model.value ?? '',
        brand: brand.value.text,
        year: proYear.value.text,
        condition: condition.value ?? '',
        oldDateIn: dateIn.value.text,
        oldQty: qBegin.value.text,
        oldPrice: priceQBegin.value.text,
        oldTotalPrice: totalPriceQBegin.value.text,
        dateIn: date.value.text,
        qty: '$newQty',
        price: price.value.text,
        totalPrice: totalPrice.value.text,
      );
      await insertAddStock(newAddStock);

      if (stockByModel.isEmpty) {
        TotalStockModel newTotalStock = TotalStockModel(
          id: newTotalId,
          model: model.value ?? '',
          brand: brand.value.text,
          year: proYear.value.text,
          condition: condition.value ?? '',
          oldDateIn: dateIn.value.text,
          oldQty: qBegin.value.text,
          oldPrice: priceQBegin.value.text,
          oldTotalPrice: totalPriceQBegin.value.text,
          newDateIn: date.value.text,
          newQty: '$newQty',
          newPrice: price.value.text,
          newTotalPrice: totalPrice.value.text,
          totalQty: '$newQty',
        );
        await insertTotalStock(newTotalStock);
      } else {
        var tQty = int.parse(stockByModel[0].totalQty) + newQty;
        await updateTotalStock(
          model: model.value ?? '',
          brand: brand.value.text,
          year: proYear.value.text,
          condition: condition.value ?? '',
          oldPrice: priceQBegin.value.text,
          oldQty: qBegin.value.text,
          oldTotalPrice: totalPriceQBegin.value.text,
          newPrice: price.value.text,
          newQty: '$newQty',
          newtotalPrice: totalPrice.value.text,
          totalQty: '$tQty',
          oldDateIn: dateIn.value.text,
          newDateIn: date.value.text,
        );
      }

      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Stock is already added.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please input all information.',
        color: redColor,
      );
    }
  }

  void updateProduct(BuildContext context) async {
    if (model.value != null && brand.value.text != '') {
      await updateByTotalStock(
        byTotalStock[0].id,
        model: model.value ?? '',
        brand: brand.value.text,
      );
      clearText();
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Successfully',
        content: 'The Information already updated.',
        color: greenColor,
      );
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please input all information.',
        color: redColor,
      );
    }
  }

  void clearText() {
    model.value = null;
    condition.value = null;
    brand.value.clear();
    proYear.value.clear();
    qBegin.value.clear();
    priceQBegin.value.clear();
    totalPriceQBegin.value.clear();
    dateIn.value.clear();
    date.value.clear();
    qty.value.clear();
    price.value.clear();
    totalPrice.value.clear();
  }

  void getDataByModel() async {
    await getStockByModel(
      model: model.value ?? '',
      brand: brand.value.text,
      year: proYear.value.text,
      condition: condition.value ?? '',
    );

    if (stockByModel.isNotEmpty) {
      dateIn.value.text = stockByModel[0].newDateIn;
      qBegin.value.text = stockByModel[0].newQty;
      priceQBegin.value.text = stockByModel[0].newPrice;
      totalPriceQBegin.value.text = stockByModel[0].newTotalPrice;
    } else {
      dateIn.value.text = '';
      qBegin.value.text = '';
      priceQBegin.value.text = '';
      totalPriceQBegin.value.text = '';
    }
  }
}
