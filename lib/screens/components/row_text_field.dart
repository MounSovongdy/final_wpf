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

class RowTextField2 extends StatelessWidget {
  final SizedBox spacer;
  final Widget? widget1, widget2;

  const RowTextField2({
    super.key,
    required this.spacer,
    this.widget1,
    this.widget2,
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
                  ],
                )
              : Column(
                  children: [
                    spacer,
                    widget1 ?? Container(),
                    spacer,
                    widget2 ?? Container(),
                  ],
                ),
        ),
      ],
    );
  }
}

class RowTextField6 extends StatelessWidget {
  final SizedBox spacer;
  final Widget? widget1, widget2, widget3, widget4, widget5, widget6;

  const RowTextField6({
    super.key,
    required this.spacer,
    this.widget1,
    this.widget2,
    this.widget3,
    this.widget4,
    this.widget5,
    this.widget6,
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
                    Expanded(flex: 1, child: Container()),
                    Expanded(flex: 4, child: widget4 ?? Container()),
                    Expanded(flex: 1, child: Container()),
                    Expanded(flex: 4, child: widget5 ?? Container()),
                    Expanded(flex: 1, child: Container()),
                    Expanded(flex: 4, child: widget6 ?? Container()),
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
                    spacer,
                    widget4 ?? Container(),
                    spacer,
                    widget5 ?? Container(),
                    spacer,
                    widget6 ?? Container(),
                    if (widget6 != null) spacer,
                  ],
                ),
        ),
      ],
    );
  }
}

class RowCardDashboard3Row extends StatelessWidget {
  final SizedBox spacer;
  final Widget? widget1, widget2, widget3;

  const RowCardDashboard3Row({
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
          child: Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(flex: 4, child: widget1 ?? Container()),
                    spacer,
                    Expanded(flex: 4, child: widget2 ?? Container()),
                    spacer,
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

class RowCardDashboard2Row extends StatelessWidget {
  final SizedBox spacer;
  final Widget? widget1, widget2;

  const RowCardDashboard2Row({
    super.key,
    required this.spacer,
    this.widget1,
    this.widget2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Responsive.isDesktop(context) ? spacer : Container(),
        Container(
          child: Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(flex: 4, child: widget1 ?? Container()),
                    spacer,
                    Expanded(flex: 4, child: widget2 ?? Container()),
                  ],
                )
              : Column(
                  children: [
                    spacer,
                    widget1 ?? Container(),
                    spacer,
                    widget2 ?? Container(),
                  ],
                ),
        ),
      ],
    );
  }
}
