import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDropdown extends StatelessWidget {
  final String txt;
  final bool readOnly, showSuffixIcon;
  final Widget? suffix;
  final double width, height;
  final List<String> list;
  final String? value;
  final Function(String?)? onChanged;

  const AppDropdown({
    super.key,
    required this.txt,
    required this.list,
    required this.onChanged,
    this.readOnly = true,
    this.showSuffixIcon = false,
    this.suffix,
    this.width = 150,
    this.height = 40,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 20.px),
            child: AppText.title(context, txt: txt, textAlign: TextAlign.right),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: width.px,
            height: height.px,
            child: DropdownButtonFormField<String>(
              value: value,
              items: list.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: AppText.title(context, txt: item),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: defWebPad.px),
              ),
            ),
          ),
        )
      ],
    );
  }
}
