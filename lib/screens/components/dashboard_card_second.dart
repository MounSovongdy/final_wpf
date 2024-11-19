import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/dashboard_card_controller.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardCardSecond extends StatelessWidget {
  DashboardCardSecond({super.key});

  final con = Get.put(DashboardCardController());
  final size = 32;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: !Responsive.isMobile(context) ? 4 : 2,
        crossAxisSpacing: Responsive.isDesktop(context) ? 20 : 10,
        mainAxisSpacing: Responsive.isDesktop(context) ? 20 : 10,
        childAspectRatio: Responsive.isDesktop(context) ? 3 : 2.5,
      ),
      itemCount: con.itemTitle.length,
      itemBuilder: (context, index) {
        return SizedBox(
          child: Container(
            color: con.cardColor[index]['color'],
            child: Padding(
              padding: EdgeInsets.all(defWebPad.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Responsive.isDesktop(context)
                          ? AppText.title(context,
                              txt: '${con.itemTitle[index]['name']}')
                          : AppText.subTitle(context,
                              txt: '${con.itemTitle[index]['name']}'),
                      const Spacer(),
                      Responsive.isDesktop(context)
                          ? AppText.largeHeader(context,
                              txt: '${con.itemValue[index]['value']}')
                          : AppText.title(context,
                              txt: '${con.itemValue[index]['value']}'),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    con.icons[index % con.icons.length].icon,
                    size:
                        Responsive.isDesktop(context) ? size.px : size.px - 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}