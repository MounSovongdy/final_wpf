import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDataTable extends StatelessWidget {
  final List<DataColumn> column;
  final List<DataRow> row;

  const AppDataTable({
    super.key,
    required this.column,
    required this.row,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowMinHeight: 10.px,
      dataRowMaxHeight: 35.px,
      headingRowHeight: 35.px,
      border: TableBorder.all(),
      headingRowColor: const WidgetStatePropertyAll(bgColor),
      columns: column,
      rows: row,
    );
  }
}
