import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/data_table_controller.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDataTable extends StatefulWidget {
  final List<DataColumn> columnHeaders;
  final List<List<DataCell>> rowData;
  final double columnSpacing;
  final double dataRowHeight;
  final double headingRowHeight;
  final double dividerThickness;
  final int maxRows;
  final Color headerColor;
  final TextStyle headerTextStyle;
  final TextStyle cellTextStyle;
  final Color evenRowColor;
  final Color oddRowColor;
  final dynamic borderColor;
  final dynamic borderWidth;
  final int rowsPerPage;

  const AppDataTable({
    super.key,
    required this.columnHeaders,
    required this.rowData,
    this.dividerThickness = 0.0,
    this.columnSpacing = 10.0,
    this.dataRowHeight = 35.0,
    this.headingRowHeight = 40.0,
    this.maxRows = 10,
    this.rowsPerPage = 10,
    this.headerColor = bgColor,
    this.headerTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      color: whiteColor,
      fontSize: 18,
    ),
    this.cellTextStyle = const TextStyle(fontSize: 16),
    this.evenRowColor = const Color(0xFFE0F7FA),
    this.oddRowColor = whiteColor,
    this.borderWidth = 1.5,
    this.borderColor = greyColor,
  });

  @override
  State<AppDataTable> createState() => _AppDataTableState();
}

class _AppDataTableState extends State<AppDataTable> {
  final DataTableController _con = Get.put(DataTableController());

  @override
  void didUpdateWidget(covariant AppDataTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rowData != widget.rowData) {
      _con.resetPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalRows = widget.rowData.length;
        final pageCount = (totalRows / widget.rowsPerPage).ceil();

        return Column(
          children: [
            Scrollbar(
              controller: scroll,
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: scroll,
                child: Container(
                  width: widget.columnHeaders.length * 180.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: widget.borderWidth,
                      color: widget.borderColor,
                    ),
                  ),
                  padding: EdgeInsets.all(widget.borderWidth),
                  child: GetBuilder<DataTableController>(
                    builder: (_) {
                      final start = _con.currentPage * widget.rowsPerPage;
                      final end = (start + widget.rowsPerPage).clamp(0, totalRows);
                      final displayedRows = widget.rowData.sublist(start, end);

                      // Fill empty rows if needed
                      int emptyRowsNeeded =
                          widget.rowsPerPage - displayedRows.length;
                      for (int i = 0; i < emptyRowsNeeded; i++) {
                        displayedRows.add(
                          List<DataCell>.generate(
                            widget.columnHeaders.length,
                                (_) => DataCell(Text("")),
                          ),
                        );
                      }

                      return DataTable(
                        dataRowMinHeight: widget.columnSpacing.px,
                        dataRowMaxHeight: widget.dataRowHeight.px,
                        headingRowHeight: widget.headingRowHeight.px,
                        dividerThickness: widget.dividerThickness.px,
                        headingRowColor: WidgetStateProperty.all(
                          widget.headerColor,
                        ),
                        columns: widget.columnHeaders,
                        rows: displayedRows.asMap().entries.map((entry) {
                          int index = entry.key;
                          List<DataCell> row = entry.value;
                          bool isEvenRow = index % 2 == 0;
                          return DataRow(
                            color: WidgetStateProperty.all(
                              isEvenRow
                                  ? widget.evenRowColor
                                  : widget.oddRowColor,
                            ),
                            cells: row.map((cell) => cell).toList(),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h), // Spacer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => _con.goToPreviousPage(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.px),
                  child: GetBuilder<DataTableController>(
                    builder: (_) => AppText.title(
                      context,
                      txt: "Page ${_con.currentPage + 1} of $pageCount",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => _con.goToNextPage(pageCount),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
