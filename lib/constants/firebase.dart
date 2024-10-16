import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:motor/models/user_model.dart';

final _firebase = FirebaseFirestore.instance;

final userCol = _firebase.collection('user');

var currVersion = '1.0.0'.obs;
var user = [].obs;

Future<List<UserModel>> getUser(String user) async {
  var res = await userCol.where('user', isEqualTo: user).get();

  return res.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
}

Future<void> updateUser(String user, String password) async {
  var docId = '';
  var result = await userCol.where('user', isEqualTo: user).get();

  for (var doc in result.docs) {
    docId = doc.id;
  }

  await userCol.doc(docId).update({'password': password});
}
