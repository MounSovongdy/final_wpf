import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/models/add_stock_model.dart';
import 'package:motor/models/address_model.dart';
import 'package:motor/models/advertising_model.dart';
import 'package:motor/models/booking_micro_model.dart';
import 'package:motor/models/booking_model.dart';
import 'package:motor/models/brand_model.dart';
import 'package:motor/models/cash_model.dart';
import 'package:motor/models/color_model.dart';
import 'package:motor/models/friend_commission_model.dart';
import 'package:motor/models/gift_model.dart';
import 'package:motor/models/koi_model.dart';
import 'package:motor/models/leasing_model.dart';
import 'package:motor/models/micro_commission_model.dart';
import 'package:motor/models/micro_model.dart';
import 'package:motor/models/payment_table_model.dart';
import 'package:motor/models/product_model.dart';
import 'package:motor/models/receivable_model.dart';
import 'package:motor/models/rental_model.dart';
import 'package:motor/models/reset_password_model.dart';
import 'package:motor/models/sale_man_commission_model.dart';
import 'package:motor/models/sale_man_model.dart';
import 'package:motor/models/total_expense_model.dart';
import 'package:motor/models/total_stock_model.dart';
import 'package:motor/models/user_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

final _firebase = FirebaseFirestore.instance;

final userCol = _firebase.collection('user_test');
final saleManCol = _firebase.collection('sale_man_test');
final microCol = _firebase.collection('micro_test');
final addressCol = _firebase.collection('address_test');
final colorCol = _firebase.collection('color_test');
final brandCol = _firebase.collection('brand_test');
final productCol = _firebase.collection('product_test');
final resetPasswordCol = _firebase.collection('reset_password_test');
final addStockCol = _firebase.collection('add_stock_test');
final stockDetailCol = _firebase.collection('stock_detail_test');
final totalStockCol = _firebase.collection('total_stock_test');
final bookingCol = _firebase.collection('booking_test');
final bookingDeleteCol = _firebase.collection('booking_delete_test');
final bookingMicroCol = _firebase.collection('booking_micro_test');
final bookingMicroDeleteCol = _firebase.collection('booking_micro_delete_test');
final leasingCol = _firebase.collection('leasing_test');
final microComCol = _firebase.collection('micro_commission_test');
final saleManComCol = _firebase.collection('sale_man_commission_test');
final friendComCol = _firebase.collection('friend_commission_test');
final cashCol = _firebase.collection('cash_test');
final receivableCol = _firebase.collection('receivable_test');
final paymentTableCol = _firebase.collection('payment_table_test');
final advertisingCol = _firebase.collection('advertising_test');
final rentalCol = _firebase.collection('rental_test');
final giftCol = _firebase.collection('gift_test');
final koiCol = _firebase.collection('koi_test');
final totalExpenseCol = _firebase.collection('total_expense_test');

var currVersion = '1.0.0'.obs;
var userLogin = ''.obs;
var userName = ''.obs;
var userRole = ''.obs;
var byUser = [].obs;
var user = [].obs;
var bySaleMan = [].obs;
var saleMan = [].obs;
var byMicro = [].obs;
var micro = [].obs;
var address = [].obs;
var byAddress = [].obs;
var byColor = [].obs;
var color = [].obs;
var byBrand = [].obs;
var brand = [].obs;
var byProduct = [].obs;
var product = [].obs;
var addStock = [].obs;
var byAddStock = [].obs;
var stockByModel = [].obs;
var byTotalStock = [].obs;
var totalStock = [].obs;
var byBooking = [].obs;
var booking = [].obs;
var byBookingMicro = [].obs;
var bookingMicro = [].obs;
var byLeasing = [].obs;
var leasing = [].obs;
var byMicroCom = [].obs;
var microCom = [].obs;
var bySaleManCom = [].obs;
var saleManCom = [].obs;
var friendCom = [].obs;
var advertise = [].obs;
var rental = [].obs;
var gift = [].obs;
var koi = [].obs;
var byCash = [].obs;
var cash = [].obs;
var byReceivable = [].obs;
var receivable = [].obs;
var schedule = [].obs;
var byPaymentTable = [].obs;
var paymentTable = [].obs;
var byResetPassword = [].obs;
var resetPassword = [].obs;
var totalExpense = [].obs;
var byTotalExpense = [].obs;
var cashIndex = [].obs;
var leasingIndex = [].obs;
var receivablewithpayment = [].obs;
var plate = [].obs;

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

Future<void> getLastResetPassword() async {
  var res =
      await resetPasswordCol.orderBy('id', descending: true).limit(1).get();
  byResetPassword.value =
      res.docs.map((doc) => ResetPasswordModel.fromMap(doc.data())).toList();
}

Future<void> resetUserPasword(ResetPasswordModel reset) async {
  try {
    await resetPasswordCol.doc('${reset.id}').set(reset.toMap());
  } catch (e) {
    debugPrint('Failed to reset user password: $e');
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

Future<void> getLastBrand() async {
  var res = await brandCol.orderBy('id', descending: true).limit(1).get();
  brand.value = res.docs.map((doc) => BrandModel.fromMap(doc.data())).toList();
}

Future<void> getByBrandID(int id) async {
  var res = await brandCol.where('id', isEqualTo: id).get();
  byBrand.value =
      res.docs.map((doc) => BrandModel.fromMap(doc.data())).toList();
}

Future<void> insertBrand(BrandModel brand) async {
  try {
    await brandCol.doc('${brand.id}').set(brand.toMap());
  } catch (e) {
    debugPrint('Failed to add brand: $e');
  }
}

Future<void> updateByBrand(int id, BrandModel b) async {
  try {
    var docId = '';
    var result = await brandCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await brandCol.doc(docId).update(b.toMap());
  } catch (e) {
    debugPrint('Failed to updateByBrand: $e');
  }
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

Future<void> getByAddStockByModel({
  required String brand,
  required String model,
  required String year,
  required String condition,
}) async {
  var res = await addStockCol
      .where('brand', isEqualTo: brand)
      .where('model', isEqualTo: model)
      .where('year', isEqualTo: year)
      .where('condition', isEqualTo: condition)
      .get();
  byAddStock.value =
      res.docs.map((doc) => AddStockModel.fromMap(doc.data())).toList();
  byAddStock.sort((a, b) => b.id.compareTo(a.id));
}

Future<void> insertAddStock(AddStockModel add) async {
  try {
    await addStockCol.doc('${add.id}').set(add.toMap());
  } catch (e) {
    debugPrint('Failed to add stock: $e');
  }
}

Future<void> updateAddStock(int id, String left) async {
  try {
    var docId = '';
    var result = await addStockCol.where('id', isEqualTo: id).get();
    for (var doc in result.docs) docId = doc.id;

    await addStockCol.doc(docId).update({'left_qty': left});
  } catch (e) {
    debugPrint('Failed to updateStockDetail: $e');
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
  required TotalStockModel totalStock,
}) async {
  try {
    var docId = '';
    var result = await totalStockCol.where('id', isEqualTo: id).get();
    for (var doc in result.docs) docId = doc.id;
    await totalStockCol.doc(docId).set(totalStock.toMap());
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

Future<void> getByLeasing(int id) async {
  var res = await leasingCol.where('id', isEqualTo: id).get();
  byLeasing.value =
      res.docs.map((doc) => LeasingModel.fromMap(doc.data())).toList();
}

Future<void> getByReceivable(int id) async {
  var res = await receivableCol.where('id', isEqualTo: id).get();
  byReceivable.value =
      res.docs.map((doc) => ReceivableModel.fromMap(doc.data())).toList();
}

Future<void> getByPaymentSchedule(int id) async {
  var res = await paymentTableCol
      .where('id', isEqualTo: id)
      .where('type', isEqualTo: 'Table')
      .get();
  schedule.value =
      res.docs.map((doc) => PaymentTableModel.fromMap(doc.data())).toList();

  schedule.sort((a, b) => a.date.compareTo(b.date));
}

Future<void> getByPlateSchedule(int id) async {
  var res = await paymentTableCol
      .where('id', isEqualTo: id)
      .where('type', isEqualTo: 'Plate')
      .get();
  plate.value =
      res.docs.map((doc) => PaymentTableModel.fromMap(doc.data())).toList();

  plate.sort((a, b) => a.date.compareTo(b.date));
}

Future<void> insertLeasing(
  LeasingModel leasing,
  SaleManCommissionModel saleCom,
  MicroCommissionModel microCom,
  ReceivableModel receivable,
  PaymentTableModel payment,
  List<PaymentTableModel> paymentList, {
  required String sellPrice,
  required String currYear,
  required String currMonth,
  required String saleman,
  required String micro,
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

    for (var doc in res.docs) docId = doc.id;

    stockByModel.value =
        res.docs.map((doc) => TotalStockModel.fromMap(doc.data())).toList();

    var list = [];
    var costPrice = '0';
    var costId = 0;
    var newLeft = '';
    var res1 = await addStockCol
        .where('model', isEqualTo: model)
        .where('brand', isEqualTo: brand)
        .where('year', isEqualTo: year)
        .where('condition', isEqualTo: condition)
        .get();
    list = res1.docs.map((doc) => AddStockModel.fromMap(doc.data())).toList();
    list.sort((a, b) => a.id.compareTo(b.id));

    if (stockByModel.isNotEmpty) {
      var oldQty = int.parse(stockByModel[0].totalQty);
      var currQty = int.parse('1');
      var newQty = oldQty - currQty;

      if (oldQty > 0) {
        if (list.isNotEmpty) {
          var newList = [];
          for (var data in list) if (data.leftQty != '0') newList.add(data);

          costPrice = newList[0].price;
          costId = newList[0].id;
          newLeft = '${int.parse(newList[0].leftQty) - 1}';
        }
        await totalStockCol.doc(docId).update({'total_qty': '$newQty'});
        await updateAddStock(costId, newLeft);
        await leasingCol.doc('${leasing.id}').set(leasing.toMap());
        await insertFinancial(
          year: currYear,
          month: currMonth,
          sell: sellPrice,
          cost: costPrice,
        );
        await updateStatusbooking(bookingId);
        await insertSaleManCommission(
          year: currYear,
          month: currMonth,
          name: saleman,
          saleCom: saleCom,
        );
        await insertMicroCommission(
          year: currYear,
          month: currMonth,
          name: micro,
          microCom: microCom,
        );
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
        Navigator.of(Get.context!).pop();
        clear();
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Successfully',
          content: 'The Leasing already created.',
          color: greenColor,
        );
      } else {
        Get.back();
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Error',
          content: 'The Model is Out of Stock.',
          color: redColor,
        );
      }
    } else {
      Get.back();
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

Future<void> getAllSaleManCommission() async {
  var res = await saleManComCol.orderBy('id', descending: true).get();
  saleManCom.value = res.docs
      .map((doc) => SaleManCommissionModel.fromMap(doc.data()))
      .toList();
}

Future<void> getByDateSaleManCommission(String year, String month) async {
  var res = await saleManComCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .get();
  saleManCom.value = res.docs
      .map((doc) => SaleManCommissionModel.fromMap(doc.data()))
      .toList();

  saleManCom.sort((a, b) => b.id.compareTo(a.id));
}

Future<void> getLastSaleManCommission() async {
  var res = await saleManComCol.orderBy('id', descending: true).limit(1).get();
  saleManCom.value = res.docs
      .map((doc) => SaleManCommissionModel.fromMap(doc.data()))
      .toList();
}

Future<void> getBySaleManNameCom({
  required String year,
  required String month,
  required String name,
}) async {
  var res = await saleManComCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .where('sale_man_name', isEqualTo: name)
      .get();
  bySaleManCom.value = res.docs
      .map((doc) => SaleManCommissionModel.fromMap(doc.data()))
      .toList();
}

Future<void> getBySaleManName(String name) async {
  var res = await saleManCol.where('name', isEqualTo: name).get();
  bySaleMan.value =
      res.docs.map((doc) => SaleManModel.fromMap(doc.data())).toList();
}

Future<void> insertSaleManCommission({
  required String year,
  required String month,
  required String name,
  required SaleManCommissionModel saleCom,
}) async {
  try {
    var docId = '';
    var res = await saleManComCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .where('sale_man_name', isEqualTo: name)
        .get();
    bySaleManCom.value = res.docs
        .map((doc) => SaleManCommissionModel.fromMap(doc.data()))
        .toList();

    if (bySaleManCom.isNotEmpty) {
      for (var doc in res.docs) {
        docId = doc.id;
      }
      await saleManComCol.doc(docId).update(saleCom.toMap());
    } else {
      await saleManComCol
          .doc('$year$month-${saleCom.saleManId}')
          .set(saleCom.toMap());
    }
  } catch (e) {
    debugPrint('Failed to add insert Saleman Commission: $e');
  }
}

Future<void> insertStaff(
  SaleManCommissionModel staff, {
  required String year,
  required String month,
  required String name,
}) async {
  try {
    var res = await saleManComCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .where('sale_man_name', isEqualTo: name)
        .get();

    if (res.docs.isEmpty) {
      await saleManComCol
          .doc('$year$month-${staff.saleManId}')
          .set(staff.toMap());
    }
  } catch (e) {
    debugPrint('Failed to add insert staff: $e');
  }
}

Future<void> getAllMicroCommission() async {
  var res = await microComCol.orderBy('id', descending: true).get();
  microCom.value =
      res.docs.map((doc) => MicroCommissionModel.fromMap(doc.data())).toList();
}

Future<void> getByDateMicroCommission(String year, String month) async {
  var res = await microComCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .get();
  microCom.value =
      res.docs.map((doc) => MicroCommissionModel.fromMap(doc.data())).toList();
}

Future<void> getLastMicroCommission() async {
  var res = await microComCol.orderBy('id', descending: true).limit(1).get();
  microCom.value =
      res.docs.map((doc) => MicroCommissionModel.fromMap(doc.data())).toList();
}

Future<void> getByMicroNameCom({
  required String year,
  required String month,
  required String name,
}) async {
  var res = await microComCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .where('micro_name', isEqualTo: name)
      .get();
  byMicroCom.value =
      res.docs.map((doc) => MicroCommissionModel.fromMap(doc.data())).toList();
}

Future<void> getByMicroName(String name) async {
  var res = await microCol.where('name', isEqualTo: name).get();
  byMicro.value =
      res.docs.map((doc) => MicroModel.fromMap(doc.data())).toList();
}

Future<void> insertMicroCommission({
  required String year,
  required String month,
  required String name,
  required MicroCommissionModel microCom,
}) async {
  try {
    var docId = '';
    var res = await saleManComCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .where('micro_name', isEqualTo: name)
        .get();
    byMicroCom.value = res.docs
        .map((doc) => MicroCommissionModel.fromMap(doc.data()))
        .toList();

    if (byMicroCom.isNotEmpty) {
      for (var doc in res.docs) {
        docId = doc.id;
      }
      await microComCol.doc(docId).update(microCom.toMap());
    } else {
      await microComCol
          .doc('$year$month-${microCom.microId}')
          .set(microCom.toMap());
    }
  } catch (e) {
    debugPrint('Failed to add insert Micro Commission: $e');
  }
}

Future<void> getAllFriendCommission() async {
  var res = await friendComCol.orderBy('id', descending: true).get();
  friendCom.value =
      res.docs.map((doc) => FriendCommissionModel.fromMap(doc.data())).toList();
}

Future<void> getByDateFriendCommission(String year, String month) async {
  var res = await friendComCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .get();
  friendCom.value =
      res.docs.map((doc) => FriendCommissionModel.fromMap(doc.data())).toList();
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

Future<void> getAllAdvertise() async {
  var res = await advertisingCol.orderBy('id', descending: true).get();
  advertise.value =
      res.docs.map((doc) => AdvertisingModel.fromMap(doc.data())).toList();
}

Future<void> getByDateAdvertise(String year, String month) async {
  var res = await advertisingCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .get();
  advertise.value =
      res.docs.map((doc) => AdvertisingModel.fromMap(doc.data())).toList();
}

Future<void> getLastAdvertise() async {
  var res = await advertisingCol.orderBy('id', descending: true).limit(1).get();
  advertise.value =
      res.docs.map((doc) => AdvertisingModel.fromMap(doc.data())).toList();
}

Future<void> insertAdvertise(AdvertisingModel adv) async {
  try {
    await advertisingCol.doc('${adv.id}').set(adv.toMap());
  } catch (e) {
    debugPrint('Failed to add insert advertise: $e');
  }
}

Future<void> getAllRental() async {
  var res = await rentalCol.orderBy('id', descending: true).get();
  rental.value =
      res.docs.map((doc) => RentalModel.fromMap(doc.data())).toList();
}

Future<void> getByDateRental(String year, String month) async {
  var res = await rentalCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .get();
  rental.value =
      res.docs.map((doc) => RentalModel.fromMap(doc.data())).toList();
}

Future<void> getLastRental() async {
  var res = await rentalCol.orderBy('id', descending: true).limit(1).get();
  rental.value =
      res.docs.map((doc) => RentalModel.fromMap(doc.data())).toList();
}

Future<void> insertRental(RentalModel ren) async {
  try {
    await rentalCol.doc('${ren.id}').set(ren.toMap());
  } catch (e) {
    debugPrint('Failed to add insert rental: $e');
  }
}

Future<void> getAllGift() async {
  var res = await giftCol.orderBy('id', descending: true).get();
  gift.value = res.docs.map((doc) => GiftModel.fromMap(doc.data())).toList();
}

Future<void> getByDateGift(String year, String month) async {
  var res = await giftCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .get();
  gift.value = res.docs.map((doc) => GiftModel.fromMap(doc.data())).toList();
}

Future<void> getLastGift() async {
  var res = await giftCol.orderBy('id', descending: true).limit(1).get();
  gift.value = res.docs.map((doc) => GiftModel.fromMap(doc.data())).toList();
}

Future<void> insertGift(GiftModel gif) async {
  try {
    await giftCol.doc('${gif.id}').set(gif.toMap());
  } catch (e) {
    debugPrint('Failed to add insert gift: $e');
  }
}

Future<void> getAllKoi() async {
  var res = await koiCol.orderBy('id', descending: true).get();
  koi.value = res.docs.map((doc) => KoiModel.fromMap(doc.data())).toList();
}

Future<void> getByDateKoi(String year, String month) async {
  var res = await koiCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .get();
  koi.value = res.docs.map((doc) => KoiModel.fromMap(doc.data())).toList();
}

Future<void> getLastKoi() async {
  var res = await koiCol.orderBy('id', descending: true).limit(1).get();
  koi.value = res.docs.map((doc) => KoiModel.fromMap(doc.data())).toList();
}

Future<void> insertKoi(KoiModel koi) async {
  try {
    await koiCol.doc('${koi.id}').set(koi.toMap());
  } catch (e) {
    debugPrint('Failed to add insert Kol: $e');
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

Future<void> getByCash(int id) async {
  var res = await cashCol.where('id', isEqualTo: id).get();
  byCash.value = res.docs.map((doc) => CashModel.fromMap(doc.data())).toList();
}

Future<void> insertCash(
  CashModel cash, {
  required String sellPrice,
  required String currYear,
  required String currMonth,
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

    for (var doc in res.docs) docId = doc.id;

    stockByModel.value =
        res.docs.map((doc) => TotalStockModel.fromMap(doc.data())).toList();

    var list = [];
    var costPrice = '0';
    var costId = 0;
    var newLeft = '';
    var res1 = await addStockCol
        .where('model', isEqualTo: model)
        .where('brand', isEqualTo: brand)
        .where('year', isEqualTo: year)
        .where('condition', isEqualTo: condition)
        .get();
    list = res1.docs.map((doc) => AddStockModel.fromMap(doc.data())).toList();
    list.sort((a, b) => a.id.compareTo(b.id));

    if (stockByModel.isNotEmpty) {
      var oldQty = int.parse(stockByModel[0].totalQty);
      var currQty = int.parse('1');
      var newQty = oldQty - currQty;

      if (oldQty > 0) {
        if (list.isNotEmpty) {
          var newList = [];
          for (var data in list) if (data.leftQty != '0') newList.add(data);

          costPrice = newList[0].price;
          costId = newList[0].id;
          newLeft = '${int.parse(newList[0].leftQty) - 1}';
        }
        await totalStockCol.doc(docId).update({'total_qty': '$newQty'});
        await updateAddStock(costId, newLeft);
        await cashCol.doc('${cash.id}').set(cash.toMap());
        await insertFinancial(
          year: currYear,
          month: currMonth,
          sell: sellPrice,
          cost: costPrice,
        );
        Navigator.of(Get.context!).pop();
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Successfully',
          content: 'The Cash already created.',
          color: greenColor,
        );
        clear();
      } else {
        Get.back();
        LoadingWidget.showTextDialog(
          Get.context!,
          title: 'Error',
          content: 'The Model is Out of Stock.',
          color: redColor,
        );
      }
    } else {
      Get.back();
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

  byPaymentTable.sort((a, b) => a.no.compareTo(b.no));
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

    var receive = conToNum(byReceivable[0].receiveAmount) + conToNum(paid);
    var left = conToNum(byReceivable[0].total) - receive;

    if (left >= 0) {
      await receivableCol.doc(docId2).update({
        'receive_amount': '${receive.toStringAsFixed(2)}',
        'amount_left': '${left.toStringAsFixed(2)}',
        'plate_amount': paidDate == 'P' ? paid : '',
      });
      await paymentTableCol.doc(docId1).update({
        'paid': paid,
        'paid_date': paidDate,
        'note': note,
        'late_date': late,
      });
    }
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
    byPaymentTable.sort((a, b) => b.no.compareTo(a.no));

    var docId2 = '';
    var res2 = await receivableCol.where('id', isEqualTo: id).get();

    byReceivable.value =
        res2.docs.map((doc) => ReceivableModel.fromMap(doc.data())).toList();

    for (var doc in res2.docs) {
      docId2 = doc.id;
    }

    var receive = conToNum(byReceivable[0].receiveAmount) + conToNum(paid);
    var left = conToNum(byReceivable[0].total) - receive;

    if (left >= 0) {
      await receivableCol.doc(docId2).update({
        'receive_amount': '${receive.toStringAsFixed(2)}',
        'amount_left': '${left.toStringAsFixed(2)}',
      });
      await paymentTableCol.doc('$id-${byPaymentTable[0].no + 1}').set({
        'amount': '',
        'date': '',
        'late_date': '',
        'no': byPaymentTable[0].no + 1,
        'penalty': '0',
        'type': 'Input',
        'id': id,
        'paid': paid,
        'paid_date': paidDate,
        'note': note,
      });
    }
  } catch (e) {
    debugPrint('Failed to add add more Payment: $e');
  }
}

Future<void> getAllAddress() async {
  var res = await addressCol.orderBy('id', descending: true).get();
  address.value =
      res.docs.map((doc) => AddressModel.fromMap(doc.data())).toList();
}

Future<void> getLastAddress() async {
  var res = await addressCol.orderBy('id', descending: true).limit(1).get();
  byAddress.value =
      res.docs.map((doc) => AddressModel.fromMap(doc.data())).toList();
}

Future<void> getByAddressID(int id) async {
  var res = await addressCol.where('id', isEqualTo: id).get();
  byAddress.value =
      res.docs.map((doc) => AddressModel.fromMap(doc.data())).toList();
}

Future<void> updateByAddress(int id, AddressModel add) async {
  try {
    var docId = '';
    var result = await addressCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await addressCol.doc(docId).update(add.toMap());
  } catch (e) {
    debugPrint('Failed to updateByAddress: $e');
  }
}

Future<void> deleteAddress(int id) async {
  try {
    var docId = '';
    var result = await addressCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await addressCol.doc(docId).delete();
  } catch (e) {
    debugPrint('Failed to delete address: $e');
  }
}

Future<void> insertAddress(AddressModel addr) async {
  try {
    await addressCol.doc('${addr.id}').set(addr.toMap());
  } catch (e) {
    debugPrint('Failed to add address: $e');
  }
}

Future<void> getAllColor() async {
  var res = await colorCol.orderBy('id', descending: true).get();
  color.value = res.docs.map((doc) => ColorModel.fromMap(doc.data())).toList();
}

Future<void> getLastColor() async {
  var res = await colorCol.orderBy('id', descending: true).limit(1).get();
  color.value = res.docs.map((doc) => ColorModel.fromMap(doc.data())).toList();
}

Future<void> getByColorID(int id) async {
  var res = await colorCol.where('id', isEqualTo: id).get();
  byColor.value =
      res.docs.map((doc) => ColorModel.fromMap(doc.data())).toList();
}

Future<void> insertColor(ColorModel color) async {
  try {
    await colorCol.doc('${color.id}').set(color.toMap());
  } catch (e) {
    debugPrint('Failed to add Color: $e');
  }
}

Future<void> updateByColor(int id, ColorModel b) async {
  try {
    var docId = '';
    var result = await colorCol.where('id', isEqualTo: id).get();

    for (var doc in result.docs) {
      docId = doc.id;
    }

    await colorCol.doc(docId).update(b.toMap());
  } catch (e) {
    debugPrint('Failed to updateByColor: $e');
  }
}

dynamic conToNum(String input) {
  if (input.contains('.')) {
    return double.tryParse(input) ?? input;
  } else {
    return int.tryParse(input) ?? input;
  }
}

Future<void> getAllTotalExpense() async {
  var res = await totalExpenseCol.orderBy('id', descending: true).get();

  totalExpense.value =
      res.docs.map((doc) => TotalExpenseModel.fromMap(doc.data())).toList();
}

Future<void> getTotalExpense({
  required String year,
  required String month,
}) async {
  var res = await totalExpenseCol
      .where('year', isEqualTo: year)
      .where('month', isEqualTo: month)
      .get();

  byTotalExpense.value =
      res.docs.map((doc) => TotalExpenseModel.fromMap(doc.data())).toList();
}

Future<void> insertFinancial({
  required String year,
  required String month,
  required String sell,
  required String cost,
}) async {
  try {
    var res = await totalExpenseCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    if (res.docs.isNotEmpty) {
      num netSale = 0;
      num saleRevenue = 0;
      num totalSale = 0;
      num totalProfit = 0;
      num avgProfit = 0;
      num totalExpense = 0;

      for (var e in res.docs) {
        netSale = num.parse(e['net_sale']);
        saleRevenue = num.parse(e['sale_revenue']);
        totalSale = num.parse(e['total_sale']);
        totalProfit = num.parse(e['total_profit']);
        avgProfit = num.parse(e['avg_profit']);
        totalExpense = num.parse(e['total_expense']);
      }
      netSale = netSale + num.parse(sell);
      saleRevenue = saleRevenue + (num.parse(sell) - num.parse(cost));
      totalSale = totalSale + 1;
      totalProfit = saleRevenue - totalExpense;
      avgProfit = totalProfit / totalSale;

      var tempNetSale = '$netSale'.contains('.')
          ? num.parse('$netSale').toStringAsFixed(2)
          : num.parse('$netSale').toString();
      var tempSaleRevenue = '$saleRevenue'.contains('.')
          ? num.parse('$saleRevenue').toStringAsFixed(2)
          : num.parse('$saleRevenue').toString();
      var tempTotalSale = '$totalSale'.contains('.')
          ? num.parse('$totalSale').toStringAsFixed(2)
          : num.parse('$totalSale').toString();
      var tempTotalProfit = '$totalProfit'.contains('.')
          ? num.parse('$totalProfit').toStringAsFixed(2)
          : num.parse('$totalProfit').toString();
      var tempAvgProfit = '$avgProfit'.contains('.')
          ? num.parse('$avgProfit').toStringAsFixed(2)
          : num.parse('$avgProfit').toString();

      await totalExpenseCol.doc('$year-$month').update({
        'net_sale': tempNetSale,
        'sale_revenue': tempSaleRevenue,
        'total_sale': tempTotalSale,
        'total_profit': tempTotalProfit,
        'avg_profit': tempAvgProfit,
      });
    } else {
      num netSale = num.parse(sell);
      num saleRevenue = num.parse(sell) - num.parse(cost);
      num totalSale = 1;
      num totalProfit = saleRevenue;
      num avgProfit = totalProfit / totalSale;

      var newNetSale = '$netSale'.contains('.')
          ? num.parse('$netSale').toStringAsFixed(2)
          : num.parse('$netSale').toString();
      var newSaleRevenue = '$saleRevenue'.contains('.')
          ? num.parse('$saleRevenue').toStringAsFixed(2)
          : num.parse('$saleRevenue').toString();
      var newTotalSale = '$totalSale'.contains('.')
          ? num.parse('$totalSale').toStringAsFixed(2)
          : num.parse('$totalSale').toString();
      var newTotalProfilt = '$totalProfit'.contains('.')
          ? num.parse('$totalProfit').toStringAsFixed(2)
          : num.parse('$totalProfit').toString();
      var newAvgProfit = '$avgProfit'.contains('.')
          ? num.parse('$avgProfit').toStringAsFixed(2)
          : num.parse('$avgProfit').toString();

      await totalExpenseCol.doc('$year-$month').set({
        'id': num.parse('$year$month'),
        'year': year,
        'month': month,
        'rental': '0',
        'salaryE': '0',
        'bonusE': '0',
        'bonusT': '0',
        'advertise': '0',
        'koi': '0',
        'gift': '0',
        'commission': '0',
        'total_expense': '0',
        'net_sale': newNetSale,
        'sale_revenue': newSaleRevenue,
        'total_sale': newTotalSale,
        'total_profit': newTotalProfilt,
        'avg_profit': newAvgProfit,
      });
    }
  } catch (e) {
    debugPrint('Failed to insert sale total expense: $e');
  }
}

Future<void> insertTotalExpenseRental({
  required String year,
  required String month,
}) async {
  try {
    var res1 = await rentalCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();
    var res2 = await totalExpenseCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    if (res1.docs.isNotEmpty) {
      num amount = 0;
      for (var e in res1.docs) amount = amount + num.parse(e['amount']);

      if (res2.docs.isNotEmpty) {
        num oldTotal = 0;
        num salaryE = 0;
        num bonusE = 0;
        num bonusT = 0;
        num advertise = 0;
        num koi = 0;
        num gift = 0;
        num commission = 0;
        num totalProfit = 0;
        num avgProfit = 0;
        num saleRevenue = 0;
        num totalSale = 0;

        for (var e in res2.docs) {
          salaryE = num.parse(e['salaryE']);
          bonusE = num.parse(e['bonusE']);
          bonusT = num.parse(e['bonusT']);
          advertise = num.parse(e['advertise']);
          koi = num.parse(e['koi']);
          gift = num.parse(e['gift']);
          commission = num.parse(e['commission']);
          saleRevenue = num.parse(e['sale_revenue']);
          totalSale = num.parse(e['total_sale']);
        }

        oldTotal = amount +
            salaryE +
            bonusE +
            bonusT +
            advertise +
            koi +
            gift +
            commission;
        totalProfit = saleRevenue - oldTotal;
        avgProfit = totalProfit / totalSale;

        var tempNewTotal = '$oldTotal'.contains('.')
            ? num.parse('$oldTotal').toStringAsFixed(2)
            : num.parse('$oldTotal').toString();
        var tempTotalProfit = '$totalProfit'.contains('.')
            ? num.parse('$totalProfit').toStringAsFixed(2)
            : num.parse('$totalProfit').toString();
        var tempAvgProfit = '$avgProfit'.contains('.')
            ? num.parse('$avgProfit').toStringAsFixed(2)
            : num.parse('$avgProfit').toString();
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();

        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        await totalExpenseCol.doc('$year-$month').update({
          'rental': tempAmount,
          'total_expense': tempNewTotal,
          'total_profit': tempTotalProfit,
          'avg_profit': tempAvgProfit,
        });
        Get.back();
      } else {
        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();

        await totalExpenseCol.doc('$year-$month').set({
          'id': num.parse('$year$month'),
          'year': year,
          'month': month,
          'rental': tempAmount,
          'salaryE': '0',
          'bonusE': '0',
          'bonusT': '0',
          'advertise': '0',
          'koi': '0',
          'gift': '0',
          'commission': '0',
          'total_expense': tempAmount,
          'net_sale': '0',
          'sale_revenue': '0',
          'total_sale': '0',
          'total_profit': '0',
          'avg_profit': '0',
        });
        Get.back();
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        content: 'Please insert rental before calculate.',
        color: redColor,
      );
    }
  } catch (e) {
    debugPrint('Failed to total expense rental: $e');
  }
}

Future<void> insertTotalExpenseFriend({
  required String year,
  required String month,
}) async {
  try {
    var res1 = await friendComCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();
    var res2 = await totalExpenseCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    if (res1.docs.isNotEmpty) {
      num amount = 0;
      for (var e in res1.docs) amount = amount + num.parse(e['commission']);

      if (res2.docs.isNotEmpty) {
        num oldTotal = 0;
        num rental = 0;
        num salaryE = 0;
        num bonusE = 0;
        num bonusT = 0;
        num advertise = 0;
        num koi = 0;
        num gift = 0;
        num totalProfit = 0;
        num avgProfit = 0;
        num saleRevenue = 0;
        num totalSale = 0;

        for (var e in res2.docs) {
          rental = num.parse(e['rental']);
          salaryE = num.parse(e['salaryE']);
          bonusE = num.parse(e['bonusE']);
          bonusT = num.parse(e['bonusT']);
          advertise = num.parse(e['advertise']);
          koi = num.parse(e['koi']);
          gift = num.parse(e['gift']);
          saleRevenue = num.parse(e['sale_revenue']);
          totalSale = num.parse(e['total_sale']);
        }

        oldTotal = rental +
            salaryE +
            bonusE +
            bonusT +
            advertise +
            koi +
            gift +
            amount;
        totalProfit = saleRevenue - oldTotal;
        avgProfit = totalProfit / totalSale;

        var tempNewTotal = '$oldTotal'.contains('.')
            ? num.parse('$oldTotal').toStringAsFixed(2)
            : num.parse('$oldTotal').toString();
        var tempTotalProfit = '$totalProfit'.contains('.')
            ? num.parse('$totalProfit').toStringAsFixed(2)
            : num.parse('$totalProfit').toString();
        var tempAvgProfit = '$avgProfit'.contains('.')
            ? num.parse('$avgProfit').toStringAsFixed(2)
            : num.parse('$avgProfit').toString();
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();

        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        await totalExpenseCol.doc('$year-$month').update({
          'commission': tempAmount,
          'total_expense': tempNewTotal,
          'total_profit': tempTotalProfit,
          'avg_profit': tempAvgProfit,
        });
        Get.back();
      } else {
        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();
        await totalExpenseCol.doc('$year-$month').set({
          'id': num.parse('$year$month'),
          'year': year,
          'month': month,
          'rental': '0',
          'salaryE': '0',
          'bonusE': '0',
          'bonusT': '0',
          'advertise': '0',
          'koi': '0',
          'gift': '0',
          'commission': tempAmount,
          'total_expense': tempAmount,
          'net_sale': '0',
          'sale_revenue': '0',
          'total_sale': '0',
          'total_profit': '0',
          'avg_profit': '0',
        });
        Get.back();
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        content: 'Please insert friend before calculate.',
        color: redColor,
      );
    }
  } catch (e) {
    debugPrint('Failed to total expense friend: $e');
  }
}

Future<void> insertTotalExpenseGift({
  required String year,
  required String month,
}) async {
  try {
    var res1 = await giftCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();
    var res2 = await totalExpenseCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    if (res1.docs.isNotEmpty) {
      num amount = 0;
      for (var e in res1.docs) amount = amount + num.parse(e['amount']);

      if (res2.docs.isNotEmpty) {
        num oldTotal = 0;
        num rental = 0;
        num salaryE = 0;
        num bonusE = 0;
        num bonusT = 0;
        num advertise = 0;
        num koi = 0;
        num commission = 0;
        num totalProfit = 0;
        num avgProfit = 0;
        num saleRevenue = 0;
        num totalSale = 0;

        for (var e in res2.docs) {
          rental = num.parse(e['rental']);
          salaryE = num.parse(e['salaryE']);
          bonusE = num.parse(e['bonusE']);
          bonusT = num.parse(e['bonusT']);
          advertise = num.parse(e['advertise']);
          koi = num.parse(e['koi']);
          commission = num.parse(e['commission']);
          saleRevenue = num.parse(e['sale_revenue']);
          totalSale = num.parse(e['total_sale']);
        }

        oldTotal = rental +
            salaryE +
            bonusE +
            bonusT +
            advertise +
            koi +
            commission +
            amount;
        totalProfit = saleRevenue - oldTotal;
        avgProfit = totalProfit / totalSale;

        var tempNewTotal = '$oldTotal'.contains('.')
            ? num.parse('$oldTotal').toStringAsFixed(2)
            : num.parse('$oldTotal').toString();
        var tempTotalProfit = '$totalProfit'.contains('.')
            ? num.parse('$totalProfit').toStringAsFixed(2)
            : num.parse('$totalProfit').toString();
        var tempAvgProfit = '$avgProfit'.contains('.')
            ? num.parse('$avgProfit').toStringAsFixed(2)
            : num.parse('$avgProfit').toString();
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();

        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        await totalExpenseCol.doc('$year-$month').update({
          'gift': tempAmount,
          'total_expense': tempNewTotal,
          'total_profit': tempTotalProfit,
          'avg_profit': tempAvgProfit,
        });
        Get.back();
      } else {
        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();
        await totalExpenseCol.doc('$year-$month').set({
          'id': num.parse('$year$month'),
          'year': year,
          'month': month,
          'rental': '0',
          'salaryE': '0',
          'bonusE': '0',
          'bonusT': '0',
          'advertise': '0',
          'koi': '0',
          'gift': tempAmount,
          'commission': '0',
          'total_expense': tempAmount,
          'net_sale': '0',
          'sale_revenue': '0',
          'total_sale': '0',
          'total_profit': '0',
          'avg_profit': '0',
        });
        Get.back();
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        content: 'Please insert gift before calculate.',
        color: redColor,
      );
    }
  } catch (e) {
    debugPrint('Failed to total expense gift: $e');
  }
}

Future<void> insertTotalExpenseKoi({
  required String year,
  required String month,
}) async {
  try {
    var res1 = await koiCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();
    var res2 = await totalExpenseCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    if (res1.docs.isNotEmpty) {
      num amount = 0;
      for (var e in res1.docs) amount = amount + num.parse(e['amount']);

      if (res2.docs.isNotEmpty) {
        num oldTotal = 0;
        num rental = 0;
        num salaryE = 0;
        num bonusE = 0;
        num bonusT = 0;
        num advertise = 0;
        num gift = 0;
        num commission = 0;
        num totalProfit = 0;
        num avgProfit = 0;
        num saleRevenue = 0;
        num totalSale = 0;

        for (var e in res2.docs) {
          rental = num.parse(e['rental']);
          salaryE = num.parse(e['salaryE']);
          bonusE = num.parse(e['bonusE']);
          bonusT = num.parse(e['bonusT']);
          advertise = num.parse(e['advertise']);
          gift = num.parse(e['gift']);
          commission = num.parse(e['commission']);
          saleRevenue = num.parse(e['sale_revenue']);
          totalSale = num.parse(e['total_sale']);
        }

        oldTotal = rental +
            salaryE +
            bonusE +
            bonusT +
            advertise +
            gift +
            commission +
            amount;
        totalProfit = saleRevenue - oldTotal;
        avgProfit = totalProfit / totalSale;

        var tempNewTotal = '$oldTotal'.contains('.')
            ? num.parse('$oldTotal').toStringAsFixed(2)
            : num.parse('$oldTotal').toString();
        var tempTotalProfit = '$totalProfit'.contains('.')
            ? num.parse('$totalProfit').toStringAsFixed(2)
            : num.parse('$totalProfit').toString();
        var tempAvgProfit = '$avgProfit'.contains('.')
            ? num.parse('$avgProfit').toStringAsFixed(2)
            : num.parse('$avgProfit').toString();
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();

        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        await totalExpenseCol.doc('$year-$month').update({
          'koi': tempAmount,
          'total_expense': tempNewTotal,
          'total_profit': tempTotalProfit,
          'avg_profit': tempAvgProfit,
        });
        Get.back();
      } else {
        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();
        await totalExpenseCol.doc('$year-$month').set({
          'id': num.parse('$year$month'),
          'year': year,
          'month': month,
          'rental': '0',
          'salaryE': '0',
          'bonusE': '0',
          'bonusT': '0',
          'advertise': '0',
          'koi': tempAmount,
          'gift': '0',
          'commission': '0',
          'total_expense': tempAmount,
          'net_sale': '0',
          'sale_revenue': '0',
          'total_sale': '0',
          'total_profit': '0',
          'avg_profit': '0',
        });
        Get.back();
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        content: 'Please insert KOL before calculate.',
        color: redColor,
      );
    }
  } catch (e) {
    debugPrint('Failed to total expense koi: $e');
  }
}

Future<void> insertTotalExpenseAdv({
  required String year,
  required String month,
}) async {
  try {
    var res1 = await advertisingCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();
    var res2 = await totalExpenseCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    if (res1.docs.isNotEmpty) {
      num amount = 0;
      for (var e in res1.docs) amount = amount + num.parse(e['amount']);

      if (res2.docs.isNotEmpty) {
        num oldTotal = 0;
        num rental = 0;
        num salaryE = 0;
        num bonusE = 0;
        num bonusT = 0;
        num koi = 0;
        num gift = 0;
        num commission = 0;
        num totalProfit = 0;
        num avgProfit = 0;
        num saleRevenue = 0;
        num totalSale = 0;

        for (var e in res2.docs) {
          rental = num.parse(e['rental']);
          salaryE = num.parse(e['salaryE']);
          bonusE = num.parse(e['bonusE']);
          bonusT = num.parse(e['bonusT']);
          koi = num.parse(e['koi']);
          gift = num.parse(e['gift']);
          commission = num.parse(e['commission']);
          saleRevenue = num.parse(e['sale_revenue']);
          totalSale = num.parse(e['total_sale']);
        }

        oldTotal = rental +
            salaryE +
            bonusE +
            bonusT +
            koi +
            gift +
            commission +
            amount;
        totalProfit = saleRevenue - oldTotal;
        avgProfit = totalProfit / totalSale;

        var tempNewTotal = '$oldTotal'.contains('.')
            ? num.parse('$oldTotal').toStringAsFixed(2)
            : num.parse('$oldTotal').toString();
        var tempTotalProfit = '$totalProfit'.contains('.')
            ? num.parse('$totalProfit').toStringAsFixed(2)
            : num.parse('$totalProfit').toString();
        var tempAvgProfit = '$avgProfit'.contains('.')
            ? num.parse('$avgProfit').toStringAsFixed(2)
            : num.parse('$avgProfit').toString();
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();

        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        await totalExpenseCol.doc('$year-$month').update({
          'advertise': tempAmount,
          'total_expense': tempNewTotal,
          'total_profit': tempTotalProfit,
          'avg_profit': tempAvgProfit,
        });
        Get.back();
      } else {
        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();
        await totalExpenseCol.doc('$year-$month').set({
          'id': num.parse('$year$month'),
          'year': year,
          'month': month,
          'rental': '0',
          'salaryE': '0',
          'bonusE': '0',
          'bonusT': '0',
          'advertise': tempAmount,
          'koi': '0',
          'gift': '0',
          'commission': '0',
          'total_expense': tempAmount,
          'net_sale': '0',
          'sale_revenue': '0',
          'total_sale': '0',
          'total_profit': '0',
          'avg_profit': '0',
        });
        Get.back();
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        content: 'Please insert advertise before calculate.',
        color: redColor,
      );
    }
  } catch (e) {
    debugPrint('Failed to total expense advertise: $e');
  }
}

Future<void> insertTotalExpenseBonusT({
  required String year,
  required String month,
}) async {
  try {
    var res1 = await microComCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();
    var res2 = await totalExpenseCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    if (res1.docs.isNotEmpty) {
      num amount = 0;
      for (var e in res1.docs) amount = amount + num.parse(e['total_bonus']);

      if (res2.docs.isNotEmpty) {
        num oldTotal = 0;
        num rental = 0;
        num salaryE = 0;
        num bonusE = 0;
        num advertise = 0;
        num koi = 0;
        num gift = 0;
        num commission = 0;
        num totalProfit = 0;
        num avgProfit = 0;
        num saleRevenue = 0;
        num totalSale = 0;

        for (var e in res2.docs) {
          rental = num.parse(e['rental']);
          salaryE = num.parse(e['salaryE']);
          bonusE = num.parse(e['bonusE']);
          advertise = num.parse(e['advertise']);
          koi = num.parse(e['koi']);
          gift = num.parse(e['gift']);
          commission = num.parse(e['commission']);
          saleRevenue = num.parse(e['sale_revenue']);
          totalSale = num.parse(e['total_sale']);
        }

        oldTotal = rental +
            salaryE +
            bonusE +
            advertise +
            koi +
            gift +
            commission +
            amount;
        totalProfit = saleRevenue - oldTotal;
        avgProfit = totalProfit / totalSale;

        var tempNewTotal = '$oldTotal'.contains('.')
            ? num.parse('$oldTotal').toStringAsFixed(2)
            : num.parse('$oldTotal').toString();
        var tempTotalProfit = '$totalProfit'.contains('.')
            ? num.parse('$totalProfit').toStringAsFixed(2)
            : num.parse('$totalProfit').toString();
        var tempAvgProfit = '$avgProfit'.contains('.')
            ? num.parse('$avgProfit').toStringAsFixed(2)
            : num.parse('$avgProfit').toString();
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();

        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        await totalExpenseCol.doc('$year-$month').update({
          'bonusT': tempAmount,
          'total_expense': tempNewTotal,
          'total_profit': tempTotalProfit,
          'avg_profit': tempAvgProfit,
        });
        Get.back();
      } else {
        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        var tempAmount = '$amount'.contains('.')
            ? num.parse('$amount').toStringAsFixed(2)
            : num.parse('$amount').toString();
        await totalExpenseCol.doc('$year-$month').set({
          'id': num.parse('$year$month'),
          'year': year,
          'month': month,
          'rental': '0',
          'salaryE': '0',
          'bonusE': '0',
          'bonusT': tempAmount,
          'advertise': '0',
          'koi': '0',
          'gift': '0',
          'commission': '0',
          'total_expense': tempAmount,
          'net_sale': '0',
          'sale_revenue': '0',
          'total_sale': '0',
          'total_profit': '0',
          'avg_profit': '0',
        });
        Get.back();
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        content: 'Please insert advertise before calculate.',
        color: redColor,
      );
    }
  } catch (e) {
    debugPrint('Failed to total expense advertise: $e');
  }
}

Future<void> insertTotalExpenseStaff({
  required String year,
  required String month,
}) async {
  try {
    var res1 = await saleManComCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();
    var res2 = await totalExpenseCol
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    if (res1.docs.isNotEmpty) {
      num salary = 0;
      num bonus = 0;
      for (var e in res1.docs) {
        salary = salary + num.parse(e['sale_salary']);
        bonus =
            bonus + (num.parse(e['total_bonus']) - num.parse(e['sale_salary']));
      }

      if (res2.docs.isNotEmpty) {
        num oldTotal = 0;
        num rental = 0;
        num bonusT = 0;
        num advertise = 0;
        num koi = 0;
        num gift = 0;
        num commission = 0;
        num totalProfit = 0;
        num avgProfit = 0;
        num saleRevenue = 0;
        num totalSale = 0;

        for (var e in res2.docs) {
          rental = num.parse(e['rental']);
          bonusT = num.parse(e['bonusT']);
          advertise = num.parse(e['advertise']);
          koi = num.parse(e['koi']);
          gift = num.parse(e['gift']);
          commission = num.parse(e['commission']);
          saleRevenue = num.parse(e['sale_revenue']);
          totalSale = num.parse(e['total_sale']);
        }

        oldTotal = rental +
            bonusT +
            advertise +
            koi +
            gift +
            commission +
            salary +
            bonus;
        totalProfit = saleRevenue - oldTotal;
        avgProfit = totalProfit / totalSale;

        var tempNewTotal = '$oldTotal'.contains('.')
            ? num.parse('$oldTotal').toStringAsFixed(2)
            : num.parse('$oldTotal').toString();
        var tempTotalProfit = '$totalProfit'.contains('.')
            ? num.parse('$totalProfit').toStringAsFixed(2)
            : num.parse('$totalProfit').toString();
        var tempAvgProfit = '$avgProfit'.contains('.')
            ? num.parse('$avgProfit').toStringAsFixed(2)
            : num.parse('$avgProfit').toString();
        var tempSalary = '$salary'.contains('.')
            ? num.parse('$salary').toStringAsFixed(2)
            : num.parse('$salary').toString();
        var tempBonus = '$bonus'.contains('.')
            ? num.parse('$bonus').toStringAsFixed(2)
            : num.parse('$bonus').toString();

        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        await totalExpenseCol.doc('$year-$month').update({
          'salaryE': tempSalary,
          'bonusE': tempBonus,
          'total_expense': tempNewTotal,
          'total_profit': tempTotalProfit,
          'avg_profit': tempAvgProfit,
        });
        Get.back();
      } else {
        var tot = salary + bonus;
        var tempNewTotal = '$tot'.contains('.')
            ? num.parse('$tot').toStringAsFixed(2)
            : num.parse('$tot').toString();
        var tempSalary = '$salary'.contains('.')
            ? num.parse('$salary').toStringAsFixed(2)
            : num.parse('$salary').toString();
        var tempBonus = '$bonus'.contains('.')
            ? num.parse('$bonus').toStringAsFixed(2)
            : num.parse('$bonus').toString();

        LoadingWidget.dialogLoading(duration: 3, isBack: true);
        await totalExpenseCol.doc('$year-$month').set({
          'id': num.parse('$year$month'),
          'year': year,
          'month': month,
          'rental': '0',
          'salaryE': tempSalary,
          'bonusE': tempBonus,
          'bonusT': '0',
          'advertise': '0',
          'koi': '0',
          'gift': '0',
          'commission': '0',
          'total_expense': tempNewTotal,
          'net_sale': '0',
          'sale_revenue': '0',
          'total_sale': '0',
          'total_profit': '0',
          'avg_profit': '0',
        });
        Get.back();
      }
    } else {
      LoadingWidget.showTextDialog(
        Get.context!,
        title: 'Error',
        content: 'Please insert advertise before calculate.',
        color: redColor,
      );
    }
  } catch (e) {
    debugPrint('Failed to total expense advertise: $e');
  }
}

Future<void> getIndexOfLeasing({
  required String currYear,
  required String currMonth,
}) async {
  try {
    var res = await leasingCol
        .where('leasing_year', isEqualTo: currYear)
        .where('leasing_month', isEqualTo: currMonth)
        .get();
    leasingIndex.value =
        res.docs.map((doc) => LeasingModel.fromMap(doc.data())).toList();
  } catch (e) {
    debugPrint('Failed to get index of Leasing.');
  }
}

Future<void> getIndexOfCash({
  required String currYear,
  required String currMonth,
}) async {
  try {
    var res = await cashCol
        .where('cash_year', isEqualTo: currYear)
        .where('cash_month', isEqualTo: currMonth)
        .get();
    cashIndex.value =
        res.docs.map((doc) => CashModel.fromMap(doc.data())).toList();
  } catch (e) {
    debugPrint('Failed to get index of cash.');
  }
}
