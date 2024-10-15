import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final _firebase = FirebaseFirestore.instance;

final adminCol = _firebase.collection('admin');

var currVersion = '1.0.0'.obs;
var adminData = [].obs;
