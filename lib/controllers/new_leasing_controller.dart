import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/models/friend_commission_model.dart';
import 'package:motor/models/leasing_model.dart';
import 'package:motor/models/micro_commission_model.dart';
import 'package:motor/models/payment_table_model.dart';
import 'package:motor/models/receivable_model.dart';
import 'package:motor/models/sale_man_commission_model.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class NewLeasingController extends GetxController {
  var bookingIdList = [''].obs;
  var idCardList = [''].obs;
  var brandList = [''].obs;
  var modelList = [''].obs;
  var colorList = [''].obs;
  var conditionList = ['New', 'Used'].obs;
  var typeList = ['Tax Paper', 'Plate Number'].obs;
  var comeByList = [
    'Walk In',
    'Friend',
    'Facebook',
    'Tik Tok',
    'Instagram',
  ].obs;
  var platePayList = ['Already', 'Not Yet'];

  var isTax = true.obs;

  var bookingId = Rxn<String>();
  var idCard = Rxn<String>();

  var name = TextEditingController().obs;
  var gender = TextEditingController().obs;
  var age = TextEditingController().obs;
  var phoneCus = TextEditingController().obs;
  var address = TextEditingController().obs;

  var dateBooking = TextEditingController().obs;
  var micro = TextEditingController().obs;
  var salesman = TextEditingController().obs;
  var workingHours = TextEditingController().obs;

  var brand = Rxn<String>();
  var model = Rxn<String>();
  var color = Rxn<String>();
  var power = TextEditingController().obs;
  var year = TextEditingController().obs;
  var condition = Rxn<String>();
  var engine = TextEditingController().obs;
  var frame = TextEditingController().obs;
  var type = Rxn<String>();
  var plateNo = TextEditingController().obs;

  var sell = TextEditingController().obs;
  var discount = TextEditingController().obs;
  var deposit = TextEditingController().obs;
  var remain = TextEditingController().obs;
  var approve = TextEditingController().obs;
  var totalOwn = TextEditingController().obs;

  var comeBy = Rxn<String>();
  var nameIntro = TextEditingController().obs;
  var phoneIntro = TextEditingController().obs;
  var commission = TextEditingController().obs;

  var phoneCus2 = TextEditingController().obs;
  var phoneCus3 = TextEditingController().obs;
  var document = TextEditingController().obs;
  var firstPayDate = TextEditingController().obs;
  var interest = TextEditingController().obs;
  var total = TextEditingController().obs;
  var term = TextEditingController().obs;
  var platePay = Rxn<String>();
  var plateAmount = TextEditingController().obs;

  var isReceivable = false.obs;
  var noList = [].obs;
  var scheduleList = [].obs;
  var amountList = [].obs;

  void createLeasing(BuildContext context) async {
    if (bookingId.value != null &&
        idCard.value != null &&
        name.value.text != '' &&
        gender.value.text != '' &&
        age.value.text != '' &&
        phoneCus.value.text != '' &&
        dateBooking.value.text != '' &&
        micro.value.text != '' &&
        salesman.value.text != '' &&
        brand.value != null &&
        model.value != null &&
        color.value != null &&
        power.value.text != '' &&
        year.value.text.length == 4 &&
        condition.value != null &&
        engine.value.text != '' &&
        frame.value.text != '' &&
        type.value != null &&
        sell.value.text != '' &&
        discount.value.text != '' &&
        deposit.value.text != '' &&
        remain.value.text != '' &&
        approve.value.text != '' &&
        totalOwn.value.text != '' &&
        comeBy.value != null) {
      var id = DateFormat('yyMMddkkmmss').format(DateTime.now());
      var leasingID = int.parse(id);
      var bookID = int.parse(bookingId.value ?? '0');
      var dateNow = dateFormat.format(DateTime.now());
      var timeNow = timeFormat.format(DateTime.now());

      await getBySaleManName(salesman.value.text);
      await getBySaleManNameCom(
        year: '${DateTime.now().year}',
        month: '${DateTime.now().month}',
        name: salesman.value.text,
      );
      var unitSale = 0;
      var newSaleComId = 1;
      if (bySaleManCom.isNotEmpty) {
        newSaleComId = bySaleManCom[0].id;
        unitSale = int.parse(bySaleManCom[0].unitSale) + 1;
      } else {
        await getLastSaleManCommission();
        if (saleManCom.isNotEmpty) newSaleComId = saleManCom[0].id + 1;
        unitSale = 1;
      }

      await getByMicroName(micro.value.text);
      await getByMicroNameCom(
        year: '${DateTime.now().year}',
        month: '${DateTime.now().month}',
        name: micro.value.text,
      );
      var unitMicro = 0;
      var newMicroComId = 1;
      if (byMicroCom.isNotEmpty) {
        newMicroComId = byMicroCom[0].id;
        unitMicro = int.parse(byMicroCom[0].unitSale) + 1;
      } else {
        await getLastMicroCommission();

        if (microCom.isNotEmpty) newMicroComId = microCom[0].id + 1;
        unitMicro = 1;
      }

      await getLastFriendCommission();
      var newFriendComId = 1;
      if (friendCom.isNotEmpty) newFriendComId = friendCom[0].id + 1;

      int debt = int.parse(totalOwn.value.text);
      List<PaymentTableModel> dataListTable = [];

      LeasingModel newLeasing = LeasingModel(
        id: leasingID,
        leasingDate: '$dateNow $timeNow',
        bookingId: bookID,
        idCard: idCard.value ?? '',
        name: name.value.text,
        gender: gender.value.text,
        age: age.value.text,
        tel: phoneCus.value.text,
        address: address.value.text,
        bookingDate: dateBooking.value.text,
        micro: micro.value.text,
        saleman: salesman.value.text,
        workingHours: workingHours.value.text,
        brand: brand.value ?? '',
        model: model.value ?? '',
        year: year.value.text,
        color: color.value ?? '',
        power: power.value.text,
        condition: condition.value ?? '',
        engineNo: engine.value.text,
        frameNo: frame.value.text,
        type: type.value ?? '',
        plateNo: plateNo.value.text,
        price: sell.value.text,
        discount: discount.value.text,
        deposit: deposit.value.text,
        remain: remain.value.text,
        approveAmount: approve.value.text,
        totalDebt: totalOwn.value.text,
        comeBy: comeBy.value ?? '',
        comeByName: nameIntro.value.text,
        comeByTel: phoneIntro.value.text,
        commission: commission.value.text,
      );
      SaleManCommissionModel newSaleManCom = SaleManCommissionModel(
        id: newSaleComId,
        year: '${DateTime.now().year}',
        month: '${DateTime.now().month}',
        saleManId: bySaleMan[0].id,
        saleManName: bySaleMan[0].name,
        saleSalary: bySaleMan[0].salary,
        saleBonus: bySaleMan[0].bonus,
        unitSale: '$unitSale',
        totalBonus:
            '${int.parse(bySaleMan[0].salary) + (int.parse(bySaleMan[0].bonus) * unitSale)}',
      );
      MicroCommissionModel newMicroCom = MicroCommissionModel(
        id: newMicroComId,
        year: '${DateTime.now().year}',
        month: '${DateTime.now().month}',
        microId: byMicro[0].id,
        microName: byMicro[0].name,
        tBonus: byMicro[0].tBonus,
        unitSale: '$unitMicro',
        totalBonus: '${int.parse(byMicro[0].tBonus) * unitMicro}',
      );
      FriendCommissionModel newFriCom = FriendCommissionModel(
        id: newFriendComId,
        year: '${DateTime.now().year}',
        month: '${DateTime.now().month}',
        name: nameIntro.value.text,
        tel: phoneIntro.value.text,
        commission: commission.value.text,
        unitSale: '1',
        totalCommission: commission.value.text,
      );
      ReceivableModel newReceivable = ReceivableModel(
        id: leasingID,
        saleman: salesman.value.text,
        date: '$dateNow $timeNow',
        name: name.value.text,
        tel1: phoneCus.value.text,
        tel2: phoneCus2.value.text,
        tel3: phoneCus3.value.text,
        document: document.value.text,
        brand: brand.value ?? '',
        model: model.value ?? '',
        year: year.value.text,
        color: color.value ?? '',
        power: power.value.text,
        condition: condition.value ?? '',
        firstPayment: firstPayDate.value.text,
        interest: interest.value.text,
        total: total.value.text,
        term: term.value.text,
        platePayment: platePay.value ?? '',
        plateAmount: plateAmount.value.text,
        receiveAmount: '0',
        amountLeft: total.value.text,
      );
      PaymentTableModel newPlatePaid = PaymentTableModel(
        id: leasingID,
        no: 0,
        type: 'Plate',
        date: 'P',
        amount: plateAmount.value.text,
        note: '',
        paid: '',
        paidDate: '',
        lateDate: '',
        penalty: '0',
      );

      if (comeBy.value == 'Friend') {
        if (nameIntro.value.text != '' &&
            phoneIntro.value.text != '' &&
            commission.value.text != '') {
          if (debt > 0) {
            if (phoneCus2.value.text != '' &&
                phoneCus3.value.text != '' &&
                document.value.text != '' &&
                firstPayDate.value.text != '' &&
                interest.value.text != '' &&
                total.value.text != '' &&
                term.value.text != '' &&
                platePay.value != null) {
              await generatePaymentTable();
              for (var i = 0; i < noList.length; i++) {
                PaymentTableModel newPayment = PaymentTableModel(
                  id: leasingID,
                  no: int.parse(noList[i]),
                  type: 'Table',
                  date: scheduleList[i],
                  amount: amountList[i],
                  note: '',
                  paid: '',
                  paidDate: '',
                  lateDate: '',
                  penalty: '0',
                );
                dataListTable.add(newPayment);
              }

              await insertFriendCommission(newFriCom);
              await insertLeasing(
                newLeasing,
                newSaleManCom,
                newMicroCom,
                newReceivable,
                newPlatePaid,
                dataListTable,
                currYear: '${DateTime.now().year}',
                currMonth: '${DateTime.now().month}',
                saleman: salesman.value.text,
                micro: micro.value.text,
                model: model.value ?? '',
                brand: brand.value ?? '',
                year: year.value.text,
                condition: condition.value ?? '',
                bookingId: bookID,
                debt: debt,
                platePaid: platePay.value == 'Not Yet' ? true : false,
                clear: clearText,
              );
            } else {
              LoadingWidget.showTextDialog(
                Get.context!,
                title: 'Error',
                content: 'Please input Receivable information.',
                color: redColor,
              );
            }
          } else {
            await insertFriendCommission(newFriCom);
            await insertLeasing(
              newLeasing,
              newSaleManCom,
              newMicroCom,
              newReceivable,
              newPlatePaid,
              dataListTable,
              currYear: '${DateTime.now().year}',
              currMonth: '${DateTime.now().month}',
              saleman: salesman.value.text,
              micro: micro.value.text,
              model: model.value ?? '',
              brand: brand.value ?? '',
              year: year.value.text,
              condition: condition.value ?? '',
              bookingId: bookID,
              debt: debt,
              platePaid: platePay.value == 'Not Yet' ? true : false,
              clear: clearText,
            );
          }
        } else {
          LoadingWidget.showTextDialog(
            Get.context!,
            title: 'Error',
            content: 'Please input Friend information.',
            color: redColor,
          );
        }
      } else {
        if (debt > 0) {
          if (phoneCus2.value.text != '' &&
              phoneCus3.value.text != '' &&
              document.value.text != '' &&
              firstPayDate.value.text != '' &&
              interest.value.text != '' &&
              total.value.text != '' &&
              term.value.text != '' &&
              platePay.value != null) {
            await generatePaymentTable();
            for (var i = 0; i < noList.length; i++) {
              PaymentTableModel newPayment = PaymentTableModel(
                id: leasingID,
                no: int.parse(noList[i]),
                type: 'Table',
                date: scheduleList[i],
                amount: amountList[i],
                note: '',
                paid: '',
                paidDate: '',
                lateDate: '',
                penalty: '0',
              );
              dataListTable.add(newPayment);
            }
            await insertLeasing(
              newLeasing,
              newSaleManCom,
              newMicroCom,
              newReceivable,
              newPlatePaid,
              dataListTable,
              currYear: '${DateTime.now().year}',
              currMonth: '${DateTime.now().month}',
              saleman: salesman.value.text,
              micro: micro.value.text,
              model: model.value ?? '',
              brand: brand.value ?? '',
              year: year.value.text,
              condition: condition.value ?? '',
              bookingId: bookID,
              debt: debt,
              platePaid: platePay.value == 'Not Yet' ? true : false,
              clear: clearText,
            );
          } else {
            LoadingWidget.showTextDialog(
              Get.context!,
              title: 'Error',
              content: 'Please input Receivable information.',
              color: redColor,
            );
          }
        } else {
          await insertLeasing(
            newLeasing,
            newSaleManCom,
            newMicroCom,
            newReceivable,
            newPlatePaid,
            dataListTable,
            currYear: '${DateTime.now().year}',
            currMonth: '${DateTime.now().month}',
            saleman: salesman.value.text,
            micro: micro.value.text,
            model: model.value ?? '',
            brand: brand.value ?? '',
            year: year.value.text,
            condition: condition.value ?? '',
            bookingId: bookID,
            debt: debt,
            platePaid: platePay.value == 'Not Yet' ? true : false,
            clear: clearText,
          );
        }
      }
    } else {
      LoadingWidget.showTextDialog(
        context,
        title: 'Error',
        content: 'Please input all information.',
        color: redColor,
      );
    }
  }

  Future<void> generatePaymentTable() async {
    var date = DateTime.parse(firstPayDate.value.text);
    var startDate = DateTime(date.year, date.month, date.day);
    var x = int.parse(total.value.text);
    var y = int.tryParse(plateAmount.value.text) ?? 0;
    var z = int.parse(term.value.text);
    var temp = (x - y) / z;
    var perAmount = double.parse(temp.toStringAsFixed(2));

    scheduleList.value = [dateFormat.format(startDate)];
    noList.value = ['1'];
    amountList.value = ['$perAmount'];

    for (int i = 0; i < int.parse(term.value.text) - 1; i++) {
      startDate = addMonth(startDate, date.day);
      var newDate = dateFormat.format(startDate);
      scheduleList.add(newDate);
      noList.add('${i + 2}');

      if (i + 1 == (int.parse(term.value.text) - 1)) {
        var newA = (x - y) - (perAmount * (i + 1));
        var newB = double.parse(newA.toStringAsFixed(2));
        amountList.add('$newB');
      } else {
        amountList.add('$perAmount');
      }
    }
  }

  DateTime addMonth(DateTime date, int day) {
    DateTime newDate = DateTime(date.year, date.month + 1, day);
    if (day == 29 || day == 30 || day == 31) {
      if (date.month == 1) {
        newDate = DateTime(date.year, 3, 0);
      } else {
        newDate = DateTime(date.year, date.month + 1, day);

        if (newDate.month != (date.month % 12) + 1) {
          newDate = DateTime(newDate.year, newDate.month, 0);
        }
      }
    }

    return newDate;
  }

  void getDataByBookingIDAndIdCard() {
    var bookId = bookingId.value ?? '0';

    if (idCard.value != null) {
      for (var data in booking) {
        if (idCard.value == data.idCard) {
          bookingId.value = '${data.id}';
          bookId = bookingId.value!;
        }
      }
    }

    for (var data in booking) {
      if (int.tryParse(bookId) == data.id) {
        idCard.value = data.idCard;
        name.value.text = data.name;
        gender.value.text = data.gender;
        age.value.text = data.age;
        phoneCus.value.text = data.tel;
        address.value.text = data.address;
        dateBooking.value.text = data.bookingDate;
        micro.value.text = data.micro;
        salesman.value.text = data.saleman;
        workingHours.value.text = data.workingHours;
        brand.value = data.brand;
        model.value = data.model;
        color.value = data.color;
        year.value.text = data.year;
        power.value.text = data.power;
        condition.value = data.condition;
        sell.value.text = data.price;
        discount.value.text = data.discount;
        deposit.value.text = data.deposit;
        remain.value.text = data.remain;
        comeBy.value = data.comeBy;
        nameIntro.value.text = data.comeByName;
        phoneIntro.value.text = data.comeByTel;
      }
    }
  }

  void calculateRemain() {
    if (sell.value.text != '' &&
        discount.value.text != '' &&
        deposit.value.text != '') {
      var p = num.parse(sell.value.text);
      var di = num.parse(discount.value.text);
      var de = num.parse(deposit.value.text);
      var re = p - (di + de);
      var newRe = num.parse('$re').toString();
      remain.value.text = newRe.contains('.')
          ? num.parse(newRe).toStringAsFixed(2)
          : num.parse(newRe).toString();
    } else {
      remain.value.text = '';
    }
  }

  void calculateTotalDebt() {
    if (remain.value.text != '' && approve.value.text != '') {
      var re = num.parse(remain.value.text);
      var app = num.parse(approve.value.text);
      var totDebt = re - app;
      var newTot = num.parse('$totDebt').toString();
      totalOwn.value.text = newTot.contains('.')
          ? num.parse(newTot).toStringAsFixed(2)
          : num.parse(newTot).toString();

      if (totalOwn.value.text != '') {
        if (num.parse(totalOwn.value.text) > 0 ||
            num.parse(totalOwn.value.text) < 0) {
          isReceivable.value = true;
        } else {
          isReceivable.value = false;
        }
      } else {
        isReceivable.value = false;
      }
    } else {
      totalOwn.value.text = '';
    }
  }

  void calculateTotal() {
    if (totalOwn.value.text != '' && interest.value.text != '') {
      var own = num.parse(totalOwn.value.text);
      var inter = num.parse(interest.value.text);
      var tot = own + ((own * inter) / 100);
      var newTot = num.parse(tot.toStringAsFixed(2)).toString();
      total.value.text = newTot.contains('.')
          ? num.parse(newTot).toStringAsFixed(2)
          : num.parse(newTot).toString();
    } else {
      total.value.text = '';
    }
  }

  void clearText() {
    bookingId.value = null;
    idCard.value = null;
    name.value.text = '';
    gender.value.text = '';
    age.value.text = '';
    phoneCus.value.text = '';
    address.value.text = '';
    dateBooking.value.text = '';
    micro.value.text = '';
    salesman.value.text = '';
    workingHours.value.text = '';
    brand.value = null;
    model.value = null;
    color.value = null;
    year.value.text = '';
    power.value.text = '';
    condition.value = null;
    engine.value.text = '';
    frame.value.text = '';
    type.value = null;
    plateNo.value.text = '';
    sell.value.text = '';
    discount.value.text = '';
    deposit.value.text = '';
    remain.value.text = '';
    approve.value.text = '';
    totalOwn.value.text = '';
    comeBy.value = null;
    nameIntro.value.text = '';
    phoneIntro.value.text = '';
    commission.value.text = '';
    phoneCus2.value.text = '';
    phoneCus3.value.text = '';
    document.value.text = '';
    firstPayDate.value.text = '';
    interest.value.text = '';
    total.value.text = '';
    term.value.text = '';
    platePay.value = null;
    plateAmount.value.text = '';
  }
}
