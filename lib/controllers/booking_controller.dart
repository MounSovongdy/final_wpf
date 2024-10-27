import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/new_booking_controller.dart';

class BookingController extends GetxController {
  final con = Get.put(NewBookingController());

  var title = 'New Booking'.obs;

  var search = TextEditingController().obs;
  var filteredBooking = [].obs;

  void filterBookingData() {
    String query = search.value.text.toLowerCase();

    filteredBooking.value = booking.where((data) {
      return data.saleman.toLowerCase().contains(query) ||
          data.bookingDate.toLowerCase().contains(query) ||
          data.idCard.toLowerCase().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.tel.toLowerCase().contains(query) ||
          data.brand.toLowerCase().contains(query) ||
          data.model.toLowerCase().contains(query) ||
          data.color.toLowerCase().contains(query) ||
          data.power.toLowerCase().contains(query) ||
          data.year.toLowerCase().contains(query) ||
          data.condition.toLowerCase().contains(query) ||
          data.price.toLowerCase().contains(query) ||
          data.remain.toLowerCase().contains(query) ||
          data.micro.toLowerCase().contains(query) ||
          data.statusBooking.toLowerCase().contains(query) ||
          data.statusDone.toLowerCase().contains(query) ||
          data.workingHours.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> editBooking(int id) async {
    await getByBookingID(id);
    con.isRead.value = true;
    con.micro.value = byBooking[0].micro;
    con.salesman.value = byBooking[0].saleman;
    con.gender.value = byBooking[0].gender;
    con.brand.value = byBooking[0].brand;
    con.model.value = byBooking[0].model;
    con.color.value = byBooking[0].color;
    con.condition.value = byBooking[0].condition;
    con.comeBy.value = byBooking[0].comeBy;
    con.address.value = byBooking[0].address;
    con.date.value.text = byBooking[0].bookingDate;
    con.idCard.value.text = byBooking[0].idCard;
    con.name.value.text = byBooking[0].name;
    con.age.value.text = byBooking[0].age;
    con.phoneCus.value.text = byBooking[0].tel;
    con.year.value.text = byBooking[0].year;
    con.power.value.text = byBooking[0].power;
    con.sell.value.text = byBooking[0].price;
    con.discount.value.text = byBooking[0].discount;
    con.depo.value.text = byBooking[0].deposit;
    con.remain.value.text = byBooking[0].remain;
    con.nameIntro.value.text = byBooking[0].comeByName;
    con.phoneIntro.value.text = byBooking[0].comeByTel;
    con.remark.value.text = byBooking[0].remark;
  }

  var statusList = ['Approve', 'Reject'].obs;

  var status = Rxn<String>();
  var newStatus = Rxn<String>();
  var newMicro = Rxn<String>();
  var oldMicro = Rxn<String>();

  Future<void> updateStaus(int id, String bookingDate) async {
    await getByBookingMicro(id);
    var data = byBookingMicro[0];

    var dateNow = dateFormat.format(DateTime.now());
    var timeNow = timeFormat.format(DateTime.now());

    var date1 = DateTime.parse(bookingDate);
    var date2 = DateTime.parse('$dateNow $timeNow');

    var year1 = date1.year;
    var month1 = date1.month;
    var day1 = date1.day;
    var hour1 = date1.hour;
    var minute1 = date1.minute;

    var year2 = date2.year;
    var month2 = date2.month;
    var day2 = date2.day;
    var hour2 = date2.hour;
    var minute2 = date2.minute;

    var start = DateTime(year1, month1, day1, hour1, minute1);
    var end = DateTime(year2, month2, day2, hour2, minute2);
    var difference = end.difference(start);

    var workDays = difference.inDays;
    var workHours = difference.inHours % 24;
    var workMinutes = difference.inMinutes % 60;
    var workingHours = '$workDays Days $workHours Hours $workMinutes Minutes';

    if (data.micro2 == '' && data.statusBooking2 == '') {
      if (status.value != 'New') {
        await updateStatusBooking1(
          id: id,
          status: status.value ?? '',
          statusDate: '$dateNow $timeNow',
          workingHours: workingHours,
        );
      }
    }
    if (data.statusBooking1 == 'Reject' && data.statusBooking2 == '') {
      if (newMicro.value != null && data.micro1 != newMicro.value) {
        await assignNewMicroBooking(
          id: id,
          newMicro: newMicro.value ?? '',
          status: status.value ?? '',
          statusDate: '$dateNow $timeNow',
          workingHours: workingHours,
        );
      }
    }
    if (data.statusBooking1 == 'Reject' && data.micro2 != '') {
      if (newStatus.value != 'New') {
        await updateStatusBooking2(
          id: id,
          status: newStatus.value ?? '',
          statusDate: '$dateNow $timeNow',
          workingHours: workingHours,
        );
      }
    }
  }

  void clearDialog() {
    status.value = null;
    newStatus.value = null;
    newMicro.value = null;
    oldMicro.value = null;
  }
}
