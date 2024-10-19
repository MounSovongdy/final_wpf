import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/invoice_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pdf/pdf.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({super.key});

  final con = Get.put(InvoiceController());
  final scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(defWebPad.px),
      padding: EdgeInsets.all(defWebPad.px),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(defRadius.px),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          AppText.header(context, txt: 'Invoice'),
          spacer(context),
          TextField(
            controller: con.search.value,
            decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Search by any data',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          spacer(context),
          Scrollbar(
            controller: scroll,
            interactive: true,
            child: SingleChildScrollView(
              controller: scroll,
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => AppDataTable(
                  column: [
                    DataTableWidget.dataColumn(context, 'ID'),
                    DataTableWidget.dataColumn(context, 'Full Name'),
                    DataTableWidget.dataColumn(context, 'Role'),
                    DataTableWidget.dataColumn(context, 'Action'),
                  ],
                  row: List.generate(
                    con.filteredUsers.length,
                    (index) => DataRow(
                      cells: [
                        DataTableWidget.dataRowTxt(
                          context,
                          con.filteredUsers[index].id,
                        ),
                        DataTableWidget.dataRowTxt(
                          context,
                          con.filteredUsers[index].name,
                        ),
                        DataTableWidget.dataRowTxt(
                          context,
                          con.filteredUsers[index].role,
                        ),
                        DataTableWidget.dataRowBtn(
                          context,
                          edit: () => debugPrint('Edit $index'),
                          delete: () => debugPrint('Delete $index'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          spacer(context),
          spacer(context),
          spacer(context),
          const UnderLine(color: secondGreyColor),
          spacer(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              spacer(context),
              spacer(context),
              AppButton(
                txt: 'Print Invoice',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () async {
                  startInactivityTimer();
                  final pdfData = await con.generatePdf(
                    PdfPageFormat.a4,
                    'Hello World! This is a test print with a custom font.',
                  );
                  con.printPdf(pdfData);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
