import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/dashboard_card_controller.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard({super.key});

  final con = Get.put(DashboardCardController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: !Responsive.isMobile(context) ? 2 : 2,
        crossAxisSpacing: Responsive.isDesktop(context) ? 20 : 10,
        mainAxisSpacing: Responsive.isDesktop(context) ? 20 : 10,
        childAspectRatio: Responsive.isDesktop(context) ? 2 : 1.5,
      ),
      itemCount: con.itemTitle.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          color: whiteColor,
          shadowColor: whiteColor,
          surfaceTintColor: whiteColor,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defRadius.px),
                    topRight: Radius.circular(defRadius.px),
                  ),
                  color: bgColor.withOpacity(0.5),
                ),
                padding: EdgeInsets.symmetric(horizontal: defWebPad.px),
                child: Row(
                  children: [
                    AppText.title(context,
                        txt: '${con.itemTitle[index]['name']}'),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh_rounded),
                      iconSize: 18,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(defWebPad.px),
              ),
            ],
          ),
        );
      },
    );
  }
}
