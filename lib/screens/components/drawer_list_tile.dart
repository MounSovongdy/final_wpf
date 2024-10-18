import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/newBooking_controller.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrawerListTile extends StatelessWidget {
  final String title, svgSrc;
  final VoidCallback tap;
  final double height;

  DrawerListTile({
    super.key,
    this.height =  16,
    required this.title,
    required this.svgSrc,
    required this.tap,
  });

  final con = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    var backgroundColor = bgColor.obs;
    var textColor = whiteColor.obs;

    return Obx(
      () => MouseRegion(
        onEnter: (_) {
          backgroundColor.value = whiteColor;
          textColor.value = bgColor;
        },
        onExit: (_) {
          backgroundColor.value = bgColor;
          textColor.value = whiteColor;
        },
        child: Container(
          color: backgroundColor.value,
          child: ListTile(
            onTap: tap,
            horizontalTitleGap: 0.0,
            leading: Padding(
              padding: EdgeInsets.only(right: 23.px),
              child: SvgPicture.asset(
                svgSrc,
                height: Responsive.isDesktop(context) ? height.px : height.px - 2,
                color: textColor.value, // ignore: deprecated_member_use
              ),
            ),
            title: AppText.title(
              context,
              txt: title,
              color: textColor.value,
            ),
          ),
        ),
      ),
    );
  }
}
