import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/add_stock_model.dart';
import 'package:motor/models/stock_detail_model.dart';
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
      LoadingWidget.dialogLoading(duration: 5, isBack: true);
      await getLastAddStock();
      await getLastTotalStock();
      await getLasttockDetail();
      var newAddId = 1;
      var newTotalId = 1;
      var newStockDetailId = 1;
      if (addStock.isNotEmpty) newAddId = addStock[0].id + 1;
      if (totalStock.isNotEmpty) newTotalId = totalStock[0].id + 1;
      if (stockDetail.isNotEmpty) newStockDetailId = stockDetail[0].id + 1;

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

      StockDetailModel newStockDetail = StockDetailModel(
        id: newStockDetailId,
        model: model.value ?? '',
        brand: brand.value.text,
        year: proYear.value.text,
        condition: condition.value ?? '',
        price: price.value.text,
        totalQty: '$newQty',
        leftQty: '$newQty',
      );
      await insertStockDetail(newStockDetail);

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
      Get.back();
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

  void updateStock(BuildContext context) async {
    var newQty = int.tryParse(qty.value.text) ?? 0;

    if (model.value != null &&
        brand.value.text != '' &&
        proYear.value.text.length == 4 &&
        condition.value != null &&
        date.value.text != '' &&
        newQty > 0 &&
        price.value.text != '' &&
        totalPrice.value.text != '') {
      LoadingWidget.dialogLoading(duration: 5, isBack: true);
      await editTotalStock(context, newQty);
      Get.back();
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

  Future<void> editTotalStock(BuildContext context, int newQty) async {
    await getStockByModel(
      model: byTotalStock[0].model,
      brand: byTotalStock[0].brand,
      year: byTotalStock[0].year,
      condition: byTotalStock[0].condition,
    );
    if (stockByModel.isEmpty) {
      debugPrint('1');
      var totalStockId = byTotalStock[0].id;
      var newTotalQty = int.parse(byTotalStock[0].totalQty) -
          int.parse(byTotalStock[0].newQty) +
          newQty;
      TotalStockModel newTotalStock = TotalStockModel(
        id: totalStockId,
        brand: brand.value.text,
        model: model.value ?? '',
        condition: condition.value ?? '',
        year: proYear.value.text,
        oldDateIn: dateIn.value.text,
        oldPrice: priceQBegin.value.text,
        oldQty: qBegin.value.text,
        oldTotalPrice: totalPriceQBegin.value.text,
        newDateIn: date.value.text,
        newPrice: price.value.text,
        newQty: '$newQty',
        newTotalPrice: totalPrice.value.text,
        totalQty: '$newTotalQty',
      );
      await updateByTotalStock(totalStockId, totalStock: newTotalStock);
    } else {
      if (byAddStock.length > 1) {
        debugPrint('2');
        var tQty =
            int.parse(byTotalStock[0].totalQty) - int.parse(byAddStock[0].qty);
        await totalStockCol.doc('${byTotalStock[0].id}').update({
          'new_date_in': byAddStock[1].dateIn,
          'new_price': byAddStock[1].price,
          'new_qty': byAddStock[1].qty,
          'new_total_price': byAddStock[1].totalPrice,
          'old_date_in': byAddStock[1].oldDateIn,
          'old_price': byAddStock[1].oldPrice,
          'old_qty': byAddStock[1].oldQty,
          'old_total_price': byAddStock[1].oldTotalPrice,
          'total_qty': '$tQty',
        });
      } else {
        debugPrint('3');
        await totalStockCol.doc('${byTotalStock[0].id}').delete();
      }

      await getStockByModel(
        brand: brand.value.text,
        model: model.value ?? '',
        year: proYear.value.text,
        condition: condition.value ?? '',
      );
      if (stockByModel.isNotEmpty) {
        debugPrint('4');
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
      } else {
        debugPrint('5');
        await getLastTotalStock();
        var newTotalId = 1;
        if (totalStock.isNotEmpty) newTotalId = totalStock[0].id + 1;

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
      }
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

  Future<void> getDataByModel() async {
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
