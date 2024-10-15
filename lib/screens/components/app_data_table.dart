import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';

class AppDataTable extends StatelessWidget {
  final List resource;
  final List headerList;
  final List dataList;

  const AppDataTable({
    super.key,
    required this.resource,
    required this.headerList,
    required this.dataList,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      border: TableBorder.all(),
      dataRowMinHeight: 10,
      dataRowMaxHeight: 35,
      headingRowHeight: 35,
      headingRowColor: const WidgetStatePropertyAll(bgColor),
      columns: List.generate(headerList.length, (index) {
        return dataColumnWidget(context, headerList[index]);
      }),
      rows: List.generate(resource.length, (index) {
        var data = resource[index];
        return DataRow(
          cells: List.generate(data.length, (index) {
            return dataRowWidget(context, data[dataList[index]]);
          }),
        );
      }),
    );
  }

  DataColumn dataColumnWidget(BuildContext context, String label) {
    return DataColumn(
      label: AppText.title(
        context,
        txt: label,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
    );
  }

  DataCell dataRowWidget(BuildContext context, String txt) {
    return DataCell(
      AppText.title(context, txt: txt),
    );
  }
}
