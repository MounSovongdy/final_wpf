import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';

class ScriptMigrate extends StatefulWidget {
  const ScriptMigrate({super.key});

  @override
  State<ScriptMigrate> createState() => _ScriptMigrateState();
}

class _ScriptMigrateState extends State<ScriptMigrate> {
  @override
  void initState() {
    super.initState();
    getData();
    getData2();
  }

  var list = [];
  var loading = true.obs;
  Future<void> getData() async {
    loading.value = true;
    var res = await stockDetailCol.get();
    list = res.docs;
    list.sort((a, b) => a['id'].compareTo(b['id']));
    loading.value = false;
  }

  var list2 = [];
  Future<void> getData2() async {
    loading.value = true;
    var res = await addStockCol.get();
    list2 = res.docs;
    list2.sort((a, b) => a['id'].compareTo(b['id']));
    loading.value = false;
  }

  Future<void> update(id, txt) async {
    loading.value = true;
    await addStockCol.doc('$id').update({'left_qty': txt});
    loading.value = false;
    debugPrint('Done $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        centerTitle: true,
        elevation: 0,
        title: AppText.header(context, txt: 'Script For Migration'),
      ),
      body: Obx(
        () => loading.value
            ? LoadingWidget.loading
            : ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  list.length,
                  (index) {
                    var id = list[index]['id'];
                    var left = list[index]['left_qty'];
                    var left2 = list2[index]['left_qty'];
                    return Row(
                      children: [
                        AppText.title(context, txt: '$id = $left , $left2'),
                        TextButton(
                          onPressed: () => update(id, left),
                          child: AppText.title(context, txt: 'Update'),
                        ),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
