import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/models/micro_model.dart';
import 'package:motor/models/product_model.dart';
import 'package:motor/models/sale_man_model.dart';
import 'package:motor/models/user_model.dart';

final _firebase = FirebaseFirestore.instance;

final userCol = _firebase.collection('user');
final saleManCol = _firebase.collection('sale_man');
final microCol = _firebase.collection('micro');
final productCol = _firebase.collection('product');

var currVersion = '1.0.0'.obs;
var user = [].obs;
var saleMan = [].obs;
var micro = [].obs;
var product = [].obs;

Future<void> getByUser(String userlogin) async {
  var res = await userCol.where('user', isEqualTo: userlogin).get();
  user.value = res.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
}

Future<void> getLastUser() async {
  var res = await userCol.orderBy('id', descending: true).limit(1).get();
  user.value = res.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
}

Future<void> insertUser(UserModel user) async {
  try {
    await userCol.doc(user.id).set(user.toMap());
  } catch (e) {
    debugPrint('Failed to add user: $e');
  }
}

Future<void> getLastSaleMan() async {
  var res = await saleManCol.orderBy('id', descending: true).limit(1).get();
  saleMan.value =
      res.docs.map((doc) => SaleManModel.fromMap(doc.data())).toList();
}

Future<void> insertSaleMan(SaleManModel sale) async {
  try {
    await saleManCol.doc(sale.id).set(sale.toMap());
  } catch (e) {
    debugPrint('Failed to add sale man: $e');
  }
}

Future<void> getLastMicro() async {
  var res = await microCol.orderBy('id', descending: true).limit(1).get();
  micro.value = res.docs.map((doc) => MicroModel.fromMap(doc.data())).toList();
}

Future<void> insertMicro(MicroModel micro) async {
  try {
    await microCol.doc(micro.id).set(micro.toMap());
  } catch (e) {
    debugPrint('Failed to add micro: $e');
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
    await productCol.doc(pro.id).set(pro.toMap());
  } catch (e) {
    debugPrint('Failed to add product: $e');
  }
}

Future<void> updateUserPassword(String user, String password) async {
  var docId = '';
  var result = await userCol.where('user', isEqualTo: user).get();

  for (var doc in result.docs) {
    docId = doc.id;
  }

  await userCol.doc(docId).update({'password': password});
}
