import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RowTextField extends StatelessWidget {
  final SizedBox spacer;
  final Widget? widget1, widget2, widget3;


  const RowTextField({
    super.key,
    required this.spacer,
    this.widget1,
    this.widget2,
    this.widget3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Responsive.isDesktop(context) ? spacer : Container(),
        Container(
          margin: EdgeInsets.only(right: defWebPad.px),
          child: Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(flex: 4, child: widget1 ?? Container()),
                    Expanded(flex: 1, child: Container()),
                    Expanded(flex: 4, child: widget2 ?? Container()),
                    Expanded(flex: 1, child: Container()),
                    Expanded(flex: 4, child: widget3 ?? Container()),
                  ],
                )
              : Column(
                  children: [
                    spacer,
                    widget1 ?? Container(),
                    spacer,
                    widget2 ?? Container(),
                    spacer,
                    widget3 ?? Container(),
                    if (widget3 != null) spacer,
                  ],
                ),
        ),
      ],
    );
  }
}
