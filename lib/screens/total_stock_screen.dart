import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TotalStockScreen extends StatelessWidget {
  TotalStockScreen({super.key});

  final data = [
    {'no': '1','brand':'Honda','model': 'Dream','year':'2024','color': 'White','cost':'2980','qBegin':'100','qToday':'89','total':'289000'},
    {'no': '2','brand':'Honda','model': 'Scoopy','year':'2025','color': 'Yellow','cost':'3680','qBegin':'100','qToday':'89','total':'289000'},
    {'no': '3','brand':'Honda','model': 'Beat','year':'2024','color': 'Blue','cost':'2780','qBegin':'100','qToday':'89','total':'289000'},
    {'no': '4','brand':'Honda','model': 'Wave','year':'2023','color': 'Black','cost':'1980','qBegin':'100','qToday':'89','total':'289000'},
    {'no': '5','brand':'Honda','model': 'Dream','year':'2024','color': 'Red','cost':'2980','qBegin':'100','qToday':'89','total':'289000'},
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
                      headerList: const ['No ','Brand','Model','Year','Color','Cost Price','Q Begin','Q Today','Total Price'],
                      dataList: const ['no','brand','model','year','color','cost','qBegin','qToday','total'],
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
