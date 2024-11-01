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
  final size = 40;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: !Responsive.isMobile(context) ? 4 : 2,
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
          child: Padding(
            padding: EdgeInsets.all(defWebPad.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  
                  children: [
                    AppText.title(
                      context,
                      txt: '${con.itemTitle[index]['name']}',
                    ),
                    spacer(context),
                    Icon(
                      con.icons[index % con.icons.length].icon,
                      size: Responsive.isDesktop(context) ? size.px : size.px - 2,
                    ),
                  ],
                ),
                const Spacer(),
                AppText.largeHeader(
                  context,
                  txt: '90',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
