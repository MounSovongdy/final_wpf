import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/salesman_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SalesmanScreen extends StatelessWidget {
  SalesmanScreen({super.key});

  final con = Get.put(SalesmanController());
  final con1 = Get.put(MainController());
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
          AppText.header(context, txt: 'Salesman List'),
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
                () => con.filteredSale.isNotEmpty
                    ? AppDataTable(
                        column: [
                          DataTableWidget.dataColumn(context, 'ID'),
                          DataTableWidget.dataColumn(
                            context,
                            'Full Name                 ',
                          ),
                          DataTableWidget.dataColumn(context, 'Gender   '),
                          DataTableWidget.dataColumn(context, 'Tel'),
                          DataTableWidget.dataColumn(context, 'Position'),
                          DataTableWidget.dataColumn(context, 'Salary'),
                          DataTableWidget.dataColumn(context, 'Bonus'),
                          DataTableWidget.dataColumn(context, 'Join Date   '),
                          DataTableWidget.dataColumn(context, 'Action    '),
                        ],
                        row: List.generate(
                          con.filteredSale.length,
                          (index) => DataRow(
                            cells: [
                              DataTableWidget.dataRowTxt(
                                context,
                                con.filteredSale[index].id,
                              ),
                              DataTableWidget.dataRowTxt(
                                context,
                                con.filteredSale[index].name,
                              ),
                              DataTableWidget.dataRowTxt(
                                context,
                                con.filteredSale[index].gender,
                              ),
                              DataTableWidget.dataRowTxt(
                                context,
                                con.filteredSale[index].tel,
                              ),
                              DataTableWidget.dataRowTxt(
                                context,
                                con.filteredSale[index].position,
                              ),
                              DataTableWidget.dataRowTxt(
                                context,
                                con.filteredSale[index].salary,
                              ),
                              DataTableWidget.dataRowTxt(
                                context,
                                con.filteredSale[index].bonus,
                              ),
                              DataTableWidget.dataRowTxt(
                                context,
                                con.filteredSale[index].date,
                              ),
                              DataTableWidget.dataRowBtn(
                                context,
                                edit: () => debugPrint('Edit $index'),
                                delete: () {
                                  startInactivityTimer();
                                  LoadingWidget.showTextDialog(
                                    context,
                                    title: 'Warning',
                                    content: 'Are you sure to delete?',
                                    color: redColor,
                                    txtBack: 'Cancel',
                                    btnColor: secondGreyColor,
                                    widget: TextButton(
                                      onPressed: () async {
                                        deleteSaleMan(
                                            con.filteredSale[index].id);
                                        await getAllSaleMan();
                                        con.filteredSale.value = saleMan;
                                        Get.back();
                                      },
                                      child: AppText.title(context,
                                          txt: 'Confirm'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        width: 100.px,
                        alignment: Alignment.center,
                        child: AppText.title(context, txt: "No Date"),
                      ),
              ),
            ),
          ),
          spacer(context),
          spacer(context),
          const UnderLine(color: secondGreyColor),
          spacer(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                txt: 'New',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () {
                  startInactivityTimer();
                  con1.index.value = 18;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
