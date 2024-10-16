import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';

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

  static DataCell dataRow(
    BuildContext context,
    String txt,
  ) {
    return DataCell(
      AppText.title(context, txt: txt),
    );
  }
}
