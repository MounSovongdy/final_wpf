import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard({super.key});

  final item = [
    {'name': 'Booking', 'qty': '60'},
    {'name': 'Sale Record', 'qty': '30'},
    {'name': 'Receivable', 'qty': '90'},
    {'name': 'Total Stock', 'qty': '120'},
    {'name': 'Add Stock', 'qty': '120'},
  ];

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
      itemCount: item.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          color: whiteColor,
          shadowColor: whiteColor,
          surfaceTintColor: whiteColor,
          child: Padding(
            padding: EdgeInsets.all(defWebPad.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.title(context, txt: '${item[index]['name']}'),
                const Spacer(),
                Container(
                  alignment: Alignment.bottomRight,
                  child: AppText.largeHeader(
                    context,
                    txt: '${item[index]['qty']}',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
