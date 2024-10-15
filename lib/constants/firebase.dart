import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _firebase = FirebaseFirestore.instance;

final adminCol = _firebase.collection('admin');

var currVersion = '1.0.0'.obs;
var adminData = [].obs;

void loadAdminData() async {
  try {
    adminData.clear();
    await adminCol.get().then((e) {
      if (e.docs.isNotEmpty) {
        adminData.value = e.docs;
      } else {
        adminData.value = [];
      }
    });
  } catch (ex) {
    debugPrint('Error problem loadAdminData: $ex');
  }
}
