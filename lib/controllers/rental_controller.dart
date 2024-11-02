import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentalController extends GetxController{
  var search = TextEditingController().obs;
  var filteredUsers = [].obs;
  var title = 'New Rental'.obs;
}