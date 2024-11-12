import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FinanceCard extends StatelessWidget {
  final List title;
  final List value;

  const FinanceCard({super.key, required this.title, required this.value});

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
      itemCount: title.length,
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
                AppText.title(context, txt: '${title[index]['name']}'),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => AppText.header(
                        context,
                        txt: '${value[index]['value']}',
                        color: bgColor,
                      ),
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
