import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TotalStockScreen extends StatelessWidget {
  TotalStockScreen({super.key});

  final con = Get.put(MainController());

  final data = [
    {'no': '1', 'model': 'Dream', 'color': 'White'},
    {'no': '2', 'model': 'Beat', 'color': 'Yello'},
    {'no': '3', 'model': 'Scoppy', 'color': 'Black'},
    {'no': '4', 'model': 'Honda', 'color': 'Red'},
  ];

  @override
  Widget build(BuildContext context) {
    var spacer = SizedBox(
      height: Responsive.isDesktop(context) ? defWebPad : defMobPad,
      width: Responsive.isDesktop(context) ? defWebPad : defMobPad,
    );

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: 'Total Stock'),
            spacer,
            Obx(
              () => adminData.isNotEmpty
                  ? AppDataTable(
                      resource: data,
                      headerList: const ['No ', 'Model', 'Color'],
                      dataList: const ['no', 'model', 'color'],
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
