import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/newBooking_controller.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppRadio extends StatelessWidget {
  final List list;
  final String title, txt, value;
  final int groupValue;
  final Function(int?)? onChanged;

  AppRadio({
    super.key,
    required this.title,
    required this.list,
    required this.txt,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final con = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 20.px),
            child: AppText.title(
              context,
              txt: title,
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: List.generate(
              list.length,
              (i) => Expanded(
                child: Row(
                  children: [
                    Radio(
                      activeColor: bgColor,
                      value: int.parse('${list[i][value]}'),
                      groupValue: groupValue,
                      onChanged: onChanged,
                    ),
                    Expanded(child: AppText.title(context, txt: list[i][txt])),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
