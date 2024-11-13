import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDataTableOld extends StatelessWidget {
  final List<DataColumn> column;
  final DataTableSource source;
  AppDataTableOld({super.key, required this.column, required this.source});

  final scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Scrollbar(
        controller: scroll,
        interactive: true,
        thumbVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: PaginatedDataTable(
          controller: scroll,
          showFirstLastButtons: true,
          headingRowColor: const WidgetStatePropertyAll(bgColor),
          showCheckboxColumn: false,
          dataRowMinHeight: 10.px,
          dataRowMaxHeight: 35.px,
          headingRowHeight: 40.px,
          showEmptyRows: false,
          availableRowsPerPage: const [10],
          columns: column,
          source: source,
        ),
      ),
    );
  }
}

