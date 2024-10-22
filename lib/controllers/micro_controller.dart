import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/controllers/create_micro_controller.dart';

class MicroController extends GetxController {
  final con = Get.put(CreateMicroController());

  var title = 'Create Micro'.obs;

  var search = TextEditingController().obs;
  var filteredMicro = [].obs;

  void filterMicroData() {
    String query = search.value.text.toLowerCase();

    filteredMicro.value = micro.where((data) {
      return data.id.toString().contains(query) ||
          data.name.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> editMicro(int id) async {
    await getByMicroID(id);
    con.nameInstitution.value.text = byMicro[0].name;
    con.tel.value.text = byMicro[0].tel;
    con.email.value.text = byMicro[0].email;
    con.tBonus.value.text = byMicro[0].tBonus;
    con.nameContact.value.text = byMicro[0].contactName;
    con.telContact.value.text = byMicro[0].contactTel;
    con.emailContact.value.text = byMicro[0].contactEmail;
    con.positionContact.value.text = byMicro[0].contactPosition;
  }
}
