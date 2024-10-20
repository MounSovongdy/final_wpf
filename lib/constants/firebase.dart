import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/models/add_stock_model.dart';
import 'package:motor/models/micro_model.dart';
import 'package:motor/models/product_model.dart';
import 'package:motor/models/sale_man_model.dart';
import 'package:motor/models/total_stock_model.dart';
import 'package:motor/models/user_model.dart';

final _firebase = FirebaseFirestore.instance;

final userCol = _firebase.collection('user');
final saleManCol = _firebase.collection('sale_man');
final microCol = _firebase.collection('micro');
final productCol = _firebase.collection('product');
final addStockCol = _firebase.collection('add_stock');
final totalStockCol = _firebase.collection('total_stock');

var currVersion = '1.0.0'.obs;
var byUser = [].obs;
var user = [].obs;
var saleMan = [].obs;
var micro = [].obs;
var product = [].obs;
var addStock = [].obs;
var stockByModel = [].obs;
var totalStock = [].obs;

Future<void> getByUser(String userlogin) async {
  var res = await userCol.where('user', isEqualTo: userlogin).get();
  byUser.value = res.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
}

Future<void> getAllUser() async {
  var res = await userCol.orderBy('id', descending: true).get();
  user.value = res.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
}

Future<void> getLastUser() async {
  var res = await userCol.orderBy('id', descending: true).limit(1).get();
  user.value = res.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
}

Future<void> insertUser(UserModel user) async {
  try {
    await userCol.doc('${user.id}').set(user.toMap());
  } catch (e) {
    debugPrint('Failed to add user: $e');
  }
}

Future<void> deleteUser(String id) async {
  try {
    var docId = '';
    var result = await userCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await userCol.doc(docId).delete();
  } catch (e) {
    debugPrint('Failed to deleteUser: $e');
  }
}

Future<void> getAllSaleMan() async {
  var res = await saleManCol.orderBy('id', descending: true).get();
  saleMan.value =
      res.docs.map((doc) => SaleManModel.fromMap(doc.data())).toList();
}

Future<void> getLastSaleMan() async {
  var res = await saleManCol.orderBy('id', descending: true).limit(1).get();
  saleMan.value =
      res.docs.map((doc) => SaleManModel.fromMap(doc.data())).toList();
}

Future<void> insertSaleMan(SaleManModel sale) async {
  try {
    await saleManCol.doc('${sale.id}').set(sale.toMap());
  } catch (e) {
    debugPrint('Failed to add sale man: $e');
  }
}

Future<void> deleteSaleMan(String id) async {
  try {
    var docId = '';
    var result = await saleManCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await saleManCol.doc(docId).delete();
  } catch (e) {
    debugPrint('Failed to deleteSaleMan: $e');
  }
}

Future<void> getAllMicro() async {
  var res = await microCol.orderBy('id', descending: true).get();
  micro.value =
      res.docs.map((doc) => MicroModel.fromMap(doc.data())).toList();
}

Future<void> getLastMicro() async {
  var res = await microCol.orderBy('id', descending: true).limit(1).get();
  micro.value = res.docs.map((doc) => MicroModel.fromMap(doc.data())).toList();
}

Future<void> insertMicro(MicroModel micro) async {
  try {
    await microCol.doc('${micro.id}').set(micro.toMap());
  } catch (e) {
    debugPrint('Failed to add micro: $e');
  }
}

Future<void> deleteMicro(String id) async {
  try {
    var docId = '';
    var result = await microCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await microCol.doc(docId).delete();
  } catch (e) {
    debugPrint('Failed to deleteMicro: $e');
  }
}

Future<void> getLastProduct() async {
  var res = await productCol.orderBy('id', descending: true).limit(1).get();
  product.value =
      res.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
}

Future<void> getAllProduct() async {
  var res = await productCol.orderBy('id', descending: true).get();
  product.value =
      res.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
}

Future<void> insertProduct(ProductModel pro) async {
  try {
    await productCol.doc('${pro.id}').set(pro.toMap());
  } catch (e) {
    debugPrint('Failed to add product: $e');
  }
}

Future<void> updateUserPassword(String user, String password) async {
  try {
    var docId = '';
    var result = await userCol.where('user', isEqualTo: user).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await userCol.doc(docId).update({'password': password});
  } catch (e) {
    debugPrint('Failed to update user password: $e');
  }
}

Future<void> getLastAddStock() async {
  var res = await addStockCol.orderBy('id', descending: true).limit(1).get();
  addStock.value =
      res.docs.map((doc) => AddStockModel.fromMap(doc.data())).toList();
}

Future<void> insertAddStock(AddStockModel add) async {
  try {
    await addStockCol.doc('${add.id}').set(add.toMap());
  } catch (e) {
    debugPrint('Failed to add stock: $e');
  }
}

Future<void> getLastTotalStock() async {
  var res = await totalStockCol.orderBy('id', descending: true).limit(1).get();
  totalStock.value =
      res.docs.map((doc) => TotalStockModel.fromMap(doc.data())).toList();
}

Future<void> getStockByModel({
  required String model,
  required String brand,
  required String year,
  required String condition,
}) async {
  var res = await totalStockCol
      .where('model', isEqualTo: model)
      .where('brand', isEqualTo: brand)
      .where('year', isEqualTo: year)
      .where('condition', isEqualTo: condition)
      .get();
  stockByModel.value =
      res.docs.map((doc) => TotalStockModel.fromMap(doc.data())).toList();
}

Future<void> insertTotalStock(TotalStockModel total) async {
  try {
    await totalStockCol.doc('${total.id}').set(total.toMap());
  } catch (e) {
    debugPrint('Failed to add total stock: $e');
  }
}

Future<void> updateTotalStock({
  required String model,
  required String brand,
  required String year,
  required String condition,
  required String oldDateIn,
  required String oldPrice,
  required String oldQty,
  required String oldTotalPrice,
  required String newDateIn,
  required String newPrice,
  required String newQty,
  required String newtotalPrice,
  required String totalQty,
}) async {
  try {
    var docId = '';
    var result = await totalStockCol
        .where('model', isEqualTo: model)
        .where('brand', isEqualTo: brand)
        .where('year', isEqualTo: year)
        .where('condition', isEqualTo: condition)
        .get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await totalStockCol.doc(docId).update({
      'old_price': oldPrice,
      'old_qty': oldQty,
      'old_total_price': oldTotalPrice,
      'new_price': newPrice,
      'new_qty': newQty,
      'new_total_price': newtotalPrice,
      'total_qty': totalQty,
      'old_date_in': oldDateIn,
      'new_date_in': newDateIn,
    });
  } catch (e) {
    debugPrint('Failed to update user password: $e');
  }
}
