import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/models/add_stock_model.dart';
import 'package:motor/models/booking_micro_model.dart';
import 'package:motor/models/booking_model.dart';
import 'package:motor/models/brand_model.dart';
import 'package:motor/models/cash_model.dart';
import 'package:motor/models/friend_commission_model.dart';
import 'package:motor/models/leasing_model.dart';
import 'package:motor/models/micro_commission_model.dart';
import 'package:motor/models/micro_model.dart';
import 'package:motor/models/payment_table_model.dart';
import 'package:motor/models/product_model.dart';
import 'package:motor/models/receivable_model.dart';
import 'package:motor/models/sale_man_commission_model.dart';
import 'package:motor/models/sale_man_model.dart';
import 'package:motor/models/total_stock_model.dart';
import 'package:motor/models/user_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

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
final leasingCol = _firebase.collection('leasing');
final microComCol = _firebase.collection('micro_commission');
final saleManComCol = _firebase.collection('sale_man_commission');
final friendComCol = _firebase.collection('friend_commission');
final cashCol = _firebase.collection('cash');
final receivableCol = _firebase.collection('receivable');
final paymentTableCol = _firebase.collection('payment_table');

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
var leasing = [].obs;
var microCom = [].obs;
var saleManCom = [].obs;
var friendCom = [].obs;
var cash = [].obs;
var byReceivable = [].obs;
var receivable = [].obs;
var byPaymentTable = [].obs;
var paymentTable = [].obs;

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

Future<void> updateStatusBooking1({
  required int id,
  required String status,
  required String statusDate,
  required String workingHours,
}) async {
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

    await bookingCol.doc(docId1).update({
      'status_booking': status,
      'status_date': statusDate,
      'working_hours': workingHours,
    });
    await bookingMicroCol.doc(docId2).update({
      'status_booking1': status,
      'status_date1': statusDate,
      'working_hours1': workingHours,
    });
  } catch (e) {
    debugPrint('Failed to updateStatusBooking1: $e');
  }
}

Future<void> assignNewMicroBooking({
  required int id,
  required String newMicro,
  required String status,
  required String statusDate,
  required String workingHours,
}) async {
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

    await bookingCol.doc(docId1).update({
      'status_booking': 'New',
      'status_date': '',
      'working_hours': '',
      'micro': newMicro,
    });
    await bookingMicroCol.doc(docId2).update({
      'status_booking1': status,
      'status_date1': statusDate,
      'working_hours1': workingHours,
      'micro2': newMicro,
      'status_booking2': 'New',
      'status_date2': '',
      'working_hours2': '',
    });
  } catch (e) {
    debugPrint('Failed to assignNewMicroBooking: $e');
  }
}

Future<void> updateStatusBooking2({
  required int id,
  required String status,
  required String statusDate,
  required String workingHours,
}) async {
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

    await bookingCol.doc(docId1).update({
      'status_booking': status,
      'status_date': statusDate,
      'working_hours': workingHours,
    });
    await bookingMicroCol.doc(docId2).update({
      'status_booking2': status,
      'status_date2': statusDate,
      'working_hours2': workingHours,
    });
  } catch (e) {
    debugPrint('Failed to updateStatusBooking2: $e');
  }
}

Future<void> getByBookingMicro(int id) async {
  var res = await bookingMicroCol.where('booking_id', isEqualTo: id).get();
  byBookingMicro.value =
      res.docs.map((doc) => BookingMicroModel.fromMap(doc.data())).toList();
}

Future<void> getBookingApprove() async {
  var res = await bookingCol
      .where('status_booking', isEqualTo: 'Approve')
      .where('status_done', isEqualTo: '')
      .get();
  booking.value =
      res.docs.map((doc) => BookingModel.fromMap(doc.data())).toList();
}

Future<void> getAllLeasing() async {
  var res = await leasingCol.orderBy('id', descending: true).get();
  leasing.value =
      res.docs.map((doc) => LeasingModel.fromMap(doc.data())).toList();
}

Future<void> insertLeasing(
  LeasingModel leasing,
  SaleManCommissionModel saleCom,
  MicroCommissionModel microCom,
  ReceivableModel receivable,
  PaymentTableModel payment,
  List<PaymentTableModel> paymentList, {
  required String model,
  required String brand,
  required String year,
  required String condition,
  required int bookingId,
  required int debt,
  required bool platePaid,
  required void Function() clear,
}) async {
  try {
    var docId = '';
    var res = await totalStockCol
        .where('model', isEqualTo: model)
        .where('brand', isEqualTo: brand)
        .where('year', isEqualTo: year)
        .where('condition', isEqualTo: condition)
        .get();

    for (var doc in res.docs) {
      docId = doc.id;
    }

    stockByModel.value =
        res.docs.map((doc) => TotalStockModel.fromMap(doc.data())).toList();

    if (stockByModel.isNotEmpty) {
      var oldQty = int.parse(stockByModel[0].totalQty);
      var currQty = int.parse('1');
      var newQty = oldQty - currQty;

      if (oldQty > 0) {
        LoadingWidget.dialogLoading(duration: 5, isBack: false);

        await totalStockCol.doc(docId).update({'total_qty': '$newQty'});
        await leasingCol.doc('${leasing.id}').set(leasing.toMap());
        await updateStatusbooking(bookingId);
        await insertSaleManCommission(saleCom);
        await insertMicroCommission(microCom);
        if (debt > 0) await insertReceivable(receivable);
        if (debt > 0) {
          if (platePaid) {
            await paymentTableCol.doc('${payment.id}-0').set(payment.toMap());
          }
          for (var data in paymentList) {
            insertPaymentTable(data);
          }
        }

        await getBookingApprove();
        Get.back();
        clear();
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Successfully',
          content: 'The Leasing already created.',
          color: greenColor,
        );
      } else {
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Error',
          content: 'The Model is Out of Stock.',
          color: redColor,
        );
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        content: 'The Model is not yet record stock',
        color: redColor,
      );
    }
  } catch (e) {
    debugPrint('Failed to add Leasing: $e');
  }
}

Future<void> updateStatusbooking(int id) async {
  try {
    var docId = '';
    var res = await bookingCol.where('id', isEqualTo: id).get();

    for (var doc in res.docs) {
      docId = doc.id;
    }

    await bookingCol.doc(docId).update({'status_done': 'Done'});
  } catch (e) {
    debugPrint('Failed to update status booking: $e');
  }
}

Future<void> getLastSaleManCommission() async {
  var res = await saleManComCol.orderBy('id', descending: true).limit(1).get();
  saleManCom.value = res.docs
      .map((doc) => SaleManCommissionModel.fromMap(doc.data()))
      .toList();
}

Future<void> getBySaleManName(String name) async {
  var res = await saleManCol.where('name', isEqualTo: name).get();
  bySaleMan.value =
      res.docs.map((doc) => SaleManModel.fromMap(doc.data())).toList();
}

Future<void> insertSaleManCommission(SaleManCommissionModel saleCom) async {
  try {
    await saleManComCol.doc('${saleCom.id}').set(saleCom.toMap());
  } catch (e) {
    debugPrint('Failed to add insert Saleman Commission: $e');
  }
}

Future<void> getLastMicroCommission() async {
  var res = await microComCol.orderBy('id', descending: true).limit(1).get();
  microCom.value =
      res.docs.map((doc) => MicroCommissionModel.fromMap(doc.data())).toList();
}

Future<void> getByMicroName(String name) async {
  var res = await microCol.where('name', isEqualTo: name).get();
  byMicro.value =
      res.docs.map((doc) => MicroModel.fromMap(doc.data())).toList();
}

Future<void> insertMicroCommission(MicroCommissionModel microCom) async {
  try {
    await microComCol.doc('${microCom.id}').set(microCom.toMap());
  } catch (e) {
    debugPrint('Failed to add insert Micro Commission: $e');
  }
}

Future<void> getLastFriendCommission() async {
  var res = await friendComCol.orderBy('id', descending: true).limit(1).get();
  friendCom.value =
      res.docs.map((doc) => FriendCommissionModel.fromMap(doc.data())).toList();
}

Future<void> insertFriendCommission(FriendCommissionModel friCom) async {
  try {
    await friendComCol.doc('${friCom.id}').set(friCom.toMap());
  } catch (e) {
    debugPrint('Failed to add insert Friend Commission: $e');
  }
}

Future<void> getAllReceivable() async {
  var res = await receivableCol.orderBy('id', descending: true).get();
  receivable.value =
      res.docs.map((doc) => ReceivableModel.fromMap(doc.data())).toList();
}

Future<void> insertReceivable(ReceivableModel receivable) async {
  try {
    await receivableCol.doc('${receivable.id}').set(receivable.toMap());
  } catch (e) {
    debugPrint('Failed to add insert Receivable: $e');
  }
}

Future<void> insertPaymentTable(PaymentTableModel payment) async {
  try {
    await paymentTableCol
        .doc('${payment.id}-${payment.no}')
        .set(payment.toMap());
  } catch (e) {
    debugPrint('Failed to add insert Payment Table: $e');
  }
}

Future<void> getAllCash() async {
  var res = await cashCol.orderBy('id', descending: true).get();
  cash.value = res.docs.map((doc) => CashModel.fromMap(doc.data())).toList();
}

Future<void> insertCash(
  CashModel cash, {
  required String model,
  required String brand,
  required String year,
  required String condition,
  required void Function() clear,
}) async {
  try {
    var docId = '';
    var res = await totalStockCol
        .where('model', isEqualTo: model)
        .where('brand', isEqualTo: brand)
        .where('year', isEqualTo: year)
        .where('condition', isEqualTo: condition)
        .get();

    for (var doc in res.docs) {
      docId = doc.id;
    }

    stockByModel.value =
        res.docs.map((doc) => TotalStockModel.fromMap(doc.data())).toList();

    if (stockByModel.isNotEmpty) {
      var oldQty = int.parse(stockByModel[0].totalQty);
      var currQty = int.parse('1');
      var newQty = oldQty - currQty;

      if (oldQty > 0) {
        LoadingWidget.dialogLoading(duration: 5, isBack: false);
        await totalStockCol.doc(docId).update({'total_qty': '$newQty'});
        await cashCol.doc('${cash.id}').set(cash.toMap());
        Get.back();
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Successfully',
          content: 'The Cash already created.',
          color: greenColor,
        );
        clear();
      } else {
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Error',
          content: 'The Model is Out of Stock.',
          color: redColor,
        );
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        content: 'The Model is not yet record stock',
        color: redColor,
      );
    }
  } catch (e) {
    debugPrint('Failed to add cash: $e');
  }
}

Future<void> getByPaymentTable(int id) async {
  var res = await paymentTableCol.where('id', isEqualTo: id).get();
  byPaymentTable.value =
      res.docs.map((doc) => PaymentTableModel.fromMap(doc.data())).toList();
}

Future<void> insertPayment({
  required int id,
  required int no,
  required String date,
  required String paidDate,
  required String paid,
  required String note,
  required String late,
}) async {
  try {
    var docId1 = '';
    var docId2 = '';

    var res1 = await paymentTableCol
        .where('id', isEqualTo: id)
        .where('no', isEqualTo: no)
        .where('date', isEqualTo: date)
        .get();
    var res2 = await receivableCol.where('id', isEqualTo: id).get();
    byReceivable.value =
        res2.docs.map((doc) => ReceivableModel.fromMap(doc.data())).toList();

    for (var doc in res1.docs) {
      docId1 = doc.id;
    }
    for (var doc in res2.docs) {
      docId2 = doc.id;
    }

    await paymentTableCol.doc(docId1).update({
      'paid': paid,
      'paid_date': paidDate,
      'note': note,
      'late_date': late,
    });

    var receive = conToNum(byReceivable[0].receiveAmount) + conToNum(paid);
    var left = conToNum(byReceivable[0].total) - receive;
    await receivableCol.doc(docId2).update({
      'receive_amount': '${receive.toStringAsFixed(2)}',
      'amount_left': '${left.toStringAsFixed(2)}',
      'plate_amount': paidDate == 'P' ? paid : '',
    });
  } catch (e) {
    debugPrint('Failed to add insert Payment: $e');
  }
}

Future<void> addMorePayment({
  required int id,
  required String paidDate,
  required String paid,
  required String note,
}) async {
  try {
    var res1 = await paymentTableCol.where('id', isEqualTo: id).get();
    byPaymentTable.value =
        res1.docs.map((doc) => PaymentTableModel.fromMap(doc.data())).toList();

    var docId2 = '';
    var res2 = await receivableCol.where('id', isEqualTo: id).get();

    byReceivable.value =
        res2.docs.map((doc) => ReceivableModel.fromMap(doc.data())).toList();

    for (var doc in res2.docs) {
      docId2 = doc.id;
    }

    await paymentTableCol
        .doc('$id-${byPaymentTable[byPaymentTable.length - 1].no + 1}')
        .set({
      'amount': '',
      'date': '',
      'late_date': '',
      'no': byPaymentTable[byPaymentTable.length - 1].no + 1,
      'penalty': '0',
      'type': 'Input',
      'id': id,
      'paid': paid,
      'paid_date': paidDate,
      'note': note,
    });

    var receive = conToNum(byReceivable[0].receiveAmount) + conToNum(paid);
    var left = conToNum(byReceivable[0].total) - receive;
    await receivableCol.doc(docId2).update({
      'receive_amount': '${receive.toStringAsFixed(2)}',
      'amount_left': '${left.toStringAsFixed(2)}',
    });
  } catch (e) {
    debugPrint('Failed to add add more Payment: $e');
  }
}

dynamic conToNum(String input) {
  if (input.contains('.')) {
    return double.tryParse(input) ?? input;
  } else {
    return int.tryParse(input) ?? input;
  }
}
