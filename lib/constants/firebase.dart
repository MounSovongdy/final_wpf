import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:motor/models/user_model.dart';

final _firebase = FirebaseFirestore.instance;

final userCol = _firebase.collection('user');

var currVersion = '1.0.0'.obs;
var user = [].obs;

Future<List<UserModel>> getUser() async {
  var res = await userCol.get();

  return res.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
}

Future<void> addUser(UserModel user) async {
  await userCol.add(user.toMap());
}

Future<void> updateUser(UserModel user) async {
  await userCol.doc(user.id).update(user.toMap());
}

Future<void> deleteUser(String id) async {
  await userCol.doc(id).delete();
}
