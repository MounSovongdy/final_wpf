import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TitleUnderline extends StatelessWidget {
  final SizedBox spacer;
  final String txt;

  const TitleUnderline({super.key, required this.spacer, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spacer,
        Row(
          children: [
            AppText.title(
              context,
              txt: txt,
              fontWeight: FontWeight.bold,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.px, left: 10.px),
                child: const UnderLine(color: secondGreyColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
