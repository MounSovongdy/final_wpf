import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    con.micro.value = byBooking[0].micro;
    con.salesman.value = byBooking[0].saleman;
    con.gender.value = byBooking[0].gender;
    con.brand.value = byBooking[0].brand;
    con.model.value = byBooking[0].model;
    con.color.value = byBooking[0].color;
    con.condition.value = byBooking[0].condition;
    con.comeBy.value = byBooking[0].comeBy;
    con.address.value = byBooking[0].address;
  }
}
