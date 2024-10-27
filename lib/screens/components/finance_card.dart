import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/finance_card_controller.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FinanceCard extends StatelessWidget {
  FinanceCard({super.key});

  final con = Get.put(FinanceCardController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: !Responsive.isMobile(context) ? 5 : 2,
        crossAxisSpacing: Responsive.isDesktop(context) ? 20 : 10,
        mainAxisSpacing: Responsive.isDesktop(context) ? 20 : 10,
        childAspectRatio: Responsive.isDesktop(context) ? 2 : 1.5,
      ),
      itemCount: con.itemTitle.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: greyColor.withOpacity(0.8),
          child: Padding(
            padding: EdgeInsets.all(defWebPad.px / 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.title(
                  context,
                  txt: '${con.itemTitle[index]['name']}',
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    AppText.header(
                      context,
                      txt: '${con.itemValue[index]['value']}',
                      color: bgColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
