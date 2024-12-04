import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/data_table_controller.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDataTableFreeze extends StatefulWidget {
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

  const AppDataTableFreeze({
    super.key,
    required this.columnHeaders,
    required this.rowData,
    this.dividerThickness = 0.0,
    this.columnSpacing = 10.0,
    this.dataRowHeight = 40.0,
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
  State<AppDataTableFreeze> createState() => _AppDataTableState();
}

class _AppDataTableState extends State<AppDataTableFreeze> {
  final DataTableController _con = Get.put(DataTableController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _con.resetPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalRows = widget.rowData.length;
    final pageCount = (totalRows / widget.rowsPerPage).ceil();

    // Calculate rows to display for the current page
    final start = _con.currentPage * widget.rowsPerPage;
    final end = (start + widget.rowsPerPage).clamp(0, totalRows);
    final displayedRows = widget.rowData.sublist(start, end);

    final frozenColumnWidth = 180.0; // Fixed width for the frozen column

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              // Frozen Column
              SizedBox(
                width: 180.0, // Provide fixed width for the frozen column
                child: Column(
                  children: [
                    Container(
                      height: widget.headingRowHeight,
                      color: widget.headerColor,
                      alignment: Alignment.center,
                      child: (widget.columnHeaders.first.label is Text)
                          ? Text(
                              (widget.columnHeaders.first.label as Text).data ?? '',
                              style: widget.headerTextStyle,
                            )
                          : widget.columnHeaders.first.label,
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: displayedRows.length,
                        itemBuilder: (context, index) {
                          final row = displayedRows[index];
                          final isEvenRow = index % 2 == 0;

                          return Container(
                            height: widget.dataRowHeight,
                            color: isEvenRow
                                ? widget.evenRowColor
                                : widget.oddRowColor,
                            alignment: Alignment.centerLeft,
                            child: row.first.child,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Scrollable Section
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        children: widget.columnHeaders
                            .sublist(1)
                            .map((header) => Container(
                                  width: 180.0,
                                  height: widget.headingRowHeight,
                                  alignment: Alignment.center,
                                  color: widget.headerColor,
                                  child: header.label,
                                ))
                            .toList(),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: displayedRows.length,
                          itemBuilder: (context, index) {
                            final row = displayedRows[index];
                            final isEvenRow = index % 2 == 0;

                            return Row(
                              children: row.sublist(1).map((cell) {
                                return Container(
                                  width: 180.0,
                                  height: widget.dataRowHeight,
                                  color: isEvenRow
                                      ? widget.evenRowColor
                                      : widget.oddRowColor,
                                  alignment: Alignment.center,
                                  child: cell.child,
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        // Pagination Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _con.goToPreviousPage(),
            ),
            GetBuilder<DataTableController>(
              builder: (_) => AppText.title(
                context,
                txt: "Page ${_con.currentPage + 1} of $pageCount",
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
  }
}
