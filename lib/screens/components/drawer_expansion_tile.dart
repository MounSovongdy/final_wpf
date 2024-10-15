import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrawerExpansionTile extends StatelessWidget {
  final String title, svgSrc;
  final List<Widget> children;

  const DrawerExpansionTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.children,
  });

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
          child: ExpansionTile(
            childrenPadding: EdgeInsets.zero,
            collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
            shape: const RoundedRectangleBorder(side: BorderSide.none),
            leading: SvgPicture.asset(
              svgSrc,
              height: Responsive.isDesktop(context) ? 16.px : 16.px - 2,
              color: textColor.value, // ignore: deprecated_member_use
            ),
            title: AppText.title(context, txt: title, color: textColor.value),
            trailing: Icon(Icons.chevron_right, color: whiteColor, size: 20.px),
            children: children,
          ),
        ),
      ),
    );
  }
}
