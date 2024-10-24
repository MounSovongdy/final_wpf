import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/models/add_stock_model.dart';
import 'package:motor/models/booking_micro_model.dart';
import 'package:motor/models/booking_model.dart';
import 'package:motor/models/brand_model.dart';
import 'package:motor/models/micro_model.dart';
import 'package:motor/models/product_model.dart';
import 'package:motor/models/sale_man_model.dart';
import 'package:motor/models/total_stock_model.dart';
import 'package:motor/models/user_model.dart';

final _firebase = FirebaseFirestore.instance;

final userCol = _firebase.collection('user');
final saleManCol = _firebase.collection('sale_man');
final microCol = _firebase.collection('micro');
final brandCol = _firebase.collection('brand');
final productCol = _firebase.collection('product');
final addStockCol = _firebase.collection('add_stock');
final totalStockCol = _firebase.collection('total_stock');
final bookingCol = _firebase.collection('booking');
final bookingMicroCol = _firebase.collection('booking_micro');

var currVersion = '1.0.0'.obs;
var byUser = [].obs;
var user = [].obs;
var bySaleMan = [].obs;
var saleMan = [].obs;
var byMicro = [].obs;
var micro = [].obs;
var brand = [].obs;
var byProduct = [].obs;
var product = [].obs;
var addStock = [].obs;
var stockByModel = [].obs;
var byTotalStock = [].obs;
var totalStock = [].obs;
var byBooking = [].obs;
var booking = [].obs;
var byBookingMicro = [].obs;
var bookingMicro = [].obs;

Future<void> getByUser(String userlogin) async {
  var res = await userCol.where('user', isEqualTo: userlogin).get();
  byUser.value = res.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
}

Future<void> getByUserID(int id) async {
  var res = await userCol.where('id', isEqualTo: id).get();
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

Future<void> updateByUser(int id, UserModel user) async {
  try {
    var docId = '';
    var result = await userCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await userCol.doc(docId).update(user.toMap());
  } catch (e) {
    debugPrint('Failed to updateUser: $e');
  }
}

Future<void> deleteUser(int id) async {
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

Future<void> getBySaleManID(int id) async {
  var res = await saleManCol.where('id', isEqualTo: id).get();
  bySaleMan.value =
      res.docs.map((doc) => SaleManModel.fromMap(doc.data())).toList();
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

Future<void> updateBySalenan(int id, SaleManModel sale) async {
  try {
    var docId = '';
    var result = await saleManCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await saleManCol.doc(docId).update(sale.toMap());
  } catch (e) {
    debugPrint('Failed to updateBySalenan: $e');
  }
}

Future<void> deleteSaleMan(int id) async {
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

Future<void> getByMicroID(int id) async {
  var res = await microCol.where('id', isEqualTo: id).get();
  byMicro.value =
      res.docs.map((doc) => MicroModel.fromMap(doc.data())).toList();
}

Future<void> getAllMicro() async {
  var res = await microCol.orderBy('id', descending: true).get();
  micro.value = res.docs.map((doc) => MicroModel.fromMap(doc.data())).toList();
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

Future<void> updateByMicro(int id, MicroModel micro) async {
  try {
    var docId = '';
    var result = await microCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await microCol.doc(docId).update(micro.toMap());
  } catch (e) {
    debugPrint('Failed to updateByMicro: $e');
  }
}

Future<void> deleteMicro(int id) async {
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

Future<void> getByProductID(int id) async {
  var res = await productCol.where('id', isEqualTo: id).get();
  byProduct.value =
      res.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
}

Future<void> getAllBrand() async {
  var res = await brandCol.orderBy('id', descending: true).get();
  brand.value = res.docs.map((doc) => BrandModel.fromMap(doc.data())).toList();
}

Future<void> getByProduct(String brand) async {
  var res = await productCol.where('brand', isEqualTo: brand).get();
  byProduct.value =
      res.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
}

Future<void> getAllProduct() async {
  var res = await productCol.orderBy('id', descending: true).get();
  product.value =
      res.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
}

Future<void> getLastProduct() async {
  var res = await productCol.orderBy('id', descending: true).limit(1).get();
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

Future<void> updateByProduct(int id, ProductModel pro) async {
  try {
    var docId = '';
    var result = await productCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await productCol.doc(docId).update(pro.toMap());
  } catch (e) {
    debugPrint('Failed to updateByProduct: $e');
  }
}

Future<void> deleteProduct(int id) async {
  try {
    var docId = '';
    var result = await productCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await productCol.doc(docId).delete();
  } catch (e) {
    debugPrint('Failed to deleteProduct: $e');
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

Future<void> getByTotalStockID(int id) async {
  var res = await totalStockCol.where('id', isEqualTo: id).get();
  byTotalStock.value =
      res.docs.map((doc) => TotalStockModel.fromMap(doc.data())).toList();
}

Future<void> getAllStock() async {
  var res = await totalStockCol.orderBy('id', descending: true).get();
  totalStock.value =
      res.docs.map((doc) => TotalStockModel.fromMap(doc.data())).toList();
}

Future<void> insertTotalStock(TotalStockModel total) async {
  try {
    await totalStockCol.doc('${total.id}').set(total.toMap());
  } catch (e) {
    debugPrint('Failed to add total stock: $e');
  }
}

Future<void> updateByTotalStock(
  int id, {
  required String model,
  required String brand,
}) async {
  try {
    var docId = '';
    var result = await totalStockCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await totalStockCol.doc(docId).update({
      'model': model,
      'brand': brand,
    });
  } catch (e) {
    debugPrint('Failed to updateByTotalStock: $e');
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

Future<void> getByBookingID(int id) async {
  var res1 = await bookingCol.where('id', isEqualTo: id).get();
  byBooking.value =
      res1.docs.map((doc) => BookingModel.fromMap(doc.data())).toList();

  var res2 = await bookingMicroCol.where('booking_id', isEqualTo: id).get();
  byBookingMicro.value =
      res2.docs.map((doc) => BookingMicroModel.fromMap(doc.data())).toList();
}

Future<void> getAllBooking() async {
  var res = await bookingCol.orderBy('id', descending: true).get();
  booking.value =
      res.docs.map((doc) => BookingModel.fromMap(doc.data())).toList();
}

Future<void> getLastBooking() async {
  var res =
      await bookingMicroCol.orderBy('id', descending: true).limit(1).get();
  bookingMicro.value =
      res.docs.map((doc) => BookingMicroModel.fromMap(doc.data())).toList();
}

Future<void> insertBooking(
  BookingModel book,
  BookingMicroModel bookMicro,
) async {
  try {
    await bookingCol.doc('${book.id}').set(book.toMap());
    await bookingMicroCol.doc('${bookMicro.id}').set(bookMicro.toMap());
  } catch (e) {
    debugPrint('Failed to add booking: $e');
  }
}

Future<void> updateByBooking(
  int id,
  BookingModel book,
  BookingMicroModel bookMicro,
) async {
  try {
    var docId1 = '';
    var result1 = await bookingCol.where('id', isEqualTo: id).get();

    var docId2 = '';
    var result2 =
        await bookingMicroCol.where('booking_id', isEqualTo: id).get();

    for (var doc in result1.docs) {
      docId1 = doc.id;
    }
    for (var doc in result2.docs) {
      docId2 = doc.id;
    }

    await bookingCol.doc(docId1).update(book.toMap());
    await bookingMicroCol.doc(docId2).update(bookMicro.toMap());
  } catch (e) {
    debugPrint('Failed to updateByBooking: $e');
  }
}

Future<void> getBookingApprove() async {
  var res =
      await bookingCol.where('status_booking', isEqualTo: 'Approve').get();
  booking.value =
      res.docs.map((doc) => BookingModel.fromMap(doc.data())).toList();
}

Future<void> insertSaleRecord({
  required String model,
  required String brand,
  required String year,
  required String condition,
  required String qty,
}) async {
  try {
    var docId = '';
    var res = await totalStockCol
        .where('model', isEqualTo: model)
        .where('brand', isEqualTo: brand)
        .where('year', isEqualTo: year)
        .where('condition', isEqualTo: condition)
        .get();
    stockByModel.value =
        res.docs.map((doc) => TotalStockModel.fromMap(doc.data())).toList();

    var oldQty = int.tryParse(stockByModel[0].totalQty) ?? 0;

    if (oldQty > 0) {
      int newQty = oldQty - int.tryParse(qty)!;

      for (var doc in res.docs) {
        docId = doc.id;
      }

      await totalStockCol.doc(docId).update({
        'total_qty': '$newQty',
      });
    }
  } catch (e) {
    debugPrint('Failed to add SaleRecord: $e');
  }
}
