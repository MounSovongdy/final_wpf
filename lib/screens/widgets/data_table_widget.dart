import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DataTableWidget {
  static DataColumn dataColumn(
    BuildContext context,
    String label,
  ) {
    return DataColumn(
      label: AppText.title(
        context,
        txt: label,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
    );
  }

  static DataCell dataRowTxt(
    BuildContext context,
    String txt,
  ) {
    return DataCell(
      AppText.title(context, txt: txt),
    );
  }

  static DataCell dataRowBtn(
    BuildContext context, {
    required Function()? edit,
    required Function()? delete,
  }) {
    return DataCell(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: edit,
          icon: const Icon(
            Icons.edit,
            color: greenColor,
          ),
        ),
        SizedBox(width: 20.px),
        IconButton(
          onPressed: delete,
          icon: const Icon(
            Icons.delete,
            color: redColor,
          ),
        ),
      ],
    ));
  }
}
