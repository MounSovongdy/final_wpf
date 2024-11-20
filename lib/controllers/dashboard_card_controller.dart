import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';

class DashboardCardController extends GetxController {
  var leasingSale = 0.0.obs;
  var cashSale = 0.0.obs;

  var activeCon = 0.0.obs;
  var closeCon = 0.0.obs;

  var listNew = [].obs;
  var listApproved = [].obs;
  var listRejected = [].obs;

  var stockTotal = 0.obs;
  var stockNew = 0.obs;
  var stockUsed = 0.obs;

  var listUser = [].obs;
  var listSale = [].obs;
  var listMicro = [].obs;

  var loading = true.obs;

  @override
  void onInit() async {
    loading.value = true;
    await loadDataBooking();
    await loadDataStock();
    await loadDataManagement();
    await loadDataSale();
    await loadDataReceivable();
    loading.value = false;

    super.onInit();
  }

  Future<void> loadDataBooking() async {
    listNew.clear();
    listApproved.clear();
    listRejected.clear();
    await getAllBooking();
    for (var data in booking) {
      if (data.statusBooking == "New") listNew.add(data.statusBooking);
      if (data.statusBooking == "Approve") listApproved.add(data.statusBooking);
      if (data.statusBooking == "Reject") listRejected.add(data.statusBooking);
    }
  }

  Future<void> loadDataStock() async {
    stockTotal.value = 0;
    stockNew.value = 0;
    stockUsed.value = 0;
    await getAllStock();
    for (var data in totalStock) {
      var totalQty = int.parse(data.totalQty);
      stockTotal.value = stockTotal.value + totalQty;

      if (data.condition == "New") {
        var newQty = int.parse(data.totalQty);
        stockNew.value = stockNew.value + newQty;
      }

      if (data.condition == "Used") {
        var usedQty = int.parse(data.totalQty);
        stockUsed.value = stockUsed.value + usedQty;
      }
    }
  }

  Future<void> loadDataManagement() async {
    listUser.clear();
    listSale.clear();
    listMicro.clear();
    await getAllUser();
    await getAllSaleMan();
    await getAllMicro();
    for (var data in user) listUser.add(data.user);
    for (var data in saleMan) listSale.add(data.name);
    for (var data in micro) listMicro.add(data.name);
  }

  Future<void> loadDataSale() async {
    var tempLeasing = [];
    var tempCash = [];
    await getAllLeasing();
    await getAllCash();
    for (var data in leasing) tempLeasing.add(data.id);
    for (var data in cash) tempCash.add(data.id);
    var doubleLeasing = double.parse('${tempLeasing.length}');
    var doubleCash = double.parse('${tempCash.length}');
    var doubleTotal = doubleLeasing + doubleCash;

    leasingSale.value = (doubleLeasing / doubleTotal) * 100;
    cashSale.value = (doubleCash / doubleTotal) * 100;
  }

  Future<void> loadDataReceivable() async {
    var tempActive = [];
    var tempClose = [];
    await getAllReceivable();
    if (receivable.isNotEmpty)
      for (var data in receivable) {
        var left = num.parse(data.amountLeft);
        if (left > 0) tempActive.add(data.id);
        if (left == 0) tempClose.add(data.id);
      }

    var doubleActive = double.parse('${tempActive.length}');
    var doubleClose = double.parse('${tempClose.length}');
    var doubleTotal = doubleActive + doubleClose;

    activeCon.value = (doubleActive / doubleTotal) * 100;
    closeCon.value = (doubleClose / doubleTotal) * 100;
  }
}
