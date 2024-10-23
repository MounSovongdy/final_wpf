import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/total_expense_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TotalExpenseScreen extends StatefulWidget {
  const TotalExpenseScreen({super.key});

  @override
  State<TotalExpenseScreen> createState() => _TotalExpenseScreenState();
}

class _TotalExpenseScreenState extends State<TotalExpenseScreen> {

  final con = Get.put(TotalExpenseController());
  final conMain = Get.put(MainController());


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
          AppText.header(context, txt: 'Expense List'),
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
          RowTextField(
            spacer: spacer(context),
            widget1: AppTextField(
              txt: 'Total Expense',
              con: con.expense.value,
              isNumber: true,
              digit: 10,
            ),
            widget2: AppTextField(
              txt: 'Days Count',
              con: con.days.value,
              readOnly: true,
            ),
            widget3: AppTextField(
              txt: 'Amount ',
              con: con.amount.value,
              readOnly: true,
            ),
          ),
          spacer(context),

          RowTextField6(
            spacer: spacer(context),
            widget1: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        value: con.isVisibleEmp,
                        onChanged: (bool? value) {
                          setState(() {
                            con.isVisibleEmp = value!; // Update visibility state
                          });
                        },
                      ),
                      Text(
                        "Staff Expense",
                        style: TextStyle(
                          color: con.isVisibleEmp ? bgColor : Colors.black,
                          // Change color
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget2: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        value: con.isVisibleTech,
                        onChanged: (bool? value) {
                          setState(() {
                            con.isVisibleTech = value!; // Update visibility state
                          });
                        },
                      ),
                      Text(
                        "Micro Expense",
                        style: TextStyle(
                          color: con.isVisibleTech ? bgColor : Colors.black,
                          // Change color
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget3: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        value: con.isVisibleAds,
                        onChanged: (bool? value) {
                          setState(() {
                            con.isVisibleAds = value!; // Update visibility state
                          });
                        },
                      ),
                      Text(
                        "Advertisement",
                        style: TextStyle(
                          color: con.isVisibleAds ? bgColor : Colors.black,
                          // Change color
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget4: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        value: con.isVisibleKPI,
                        onChanged: (bool? value) {
                          setState(() {
                            con.isVisibleKPI = value!; // Update visibility state
                          });
                        },
                      ),
                      Text(
                        "KPI Paid",
                        style: TextStyle(
                          color: con.isVisibleKPI ? bgColor : Colors.black,
                          // Change color
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget5: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        value: con.isVisibleGift,
                        onChanged: (bool? value) {
                          setState(() {
                            con.isVisibleGift = value!; // Update visibility state
                          });
                        },
                      ),
                      Text(
                        "Gift Expense",
                        style: TextStyle(
                          color: con.isVisibleGift ? bgColor : Colors.black,
                          // Change color
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget6: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        value: con.isVisibleCommission,
                        onChanged: (bool? value) {
                          setState(() {
                            con.isVisibleCommission = value!; // Update visibility state
                          });
                        },
                      ),
                      Text(
                        "Commission",
                        style: TextStyle(
                          color: con.isVisibleCommission ? bgColor : Colors.black,
                          // Change color
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          con.isVisibleEmp
              ? AppDataTable(
            column: [
              DataTableWidget.column(context, 'No'),
              DataTableWidget.column(context, 'Date'),
              DataTableWidget.column(context, 'Staff Name'),
              DataTableWidget.column(context, 'Salary'),
            ],
            source: TotalExpenseDataSource(),
          )
              : Container(),
          con.isVisibleTech
              ? AppDataTable(
            column: [
              DataTableWidget.column(context, 'Micro Name'),
              DataTableWidget.column(context, 'Teacher Name'),
              DataTableWidget.column(context, 'Bonus'),
            ],
            source: TotalExpenseDataSource(),
          )
              : Container(),
          con.isVisibleAds
              ? AppDataTable(
            column: [
              DataTableWidget.column(context, 'No'),
              DataTableWidget.column(context, 'Date'),
              DataTableWidget.column(context, 'Amount'),
              DataTableWidget.column(context, 'Method'),
            ],
            source: TotalExpenseDataSource(),
          )
              : Container(),
          con.isVisibleKPI
              ? AppDataTable(
            column: [
              DataTableWidget.column(context, 'No'),
              DataTableWidget.column(context, 'Date'),
              DataTableWidget.column(context, 'Amount'),
              DataTableWidget.column(context, 'Gift Item'),
            ],
            source: TotalExpenseDataSource(),
          )
              : Container(),
          con.isVisibleGift
              ? AppDataTable(
            column: [
              DataTableWidget.column(context, 'No'),
              DataTableWidget.column(context, 'Date'),
              DataTableWidget.column(context, 'Gift Item'),
              DataTableWidget.column(context, 'Amount'),
            ],
            source: TotalExpenseDataSource(),
          )
              : Container(),
          con.isVisibleCommission
              ? AppDataTable(
            column: [
              DataTableWidget.column(context, 'No'),
              DataTableWidget.column(context, 'Date'),
              DataTableWidget.column(context, 'Name'),
              DataTableWidget.column(context, 'Telephone'),
              DataTableWidget.column(context, 'Amount'),
            ],
            source: TotalExpenseDataSource(),
          )
              : Container(),
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
                txt: 'New',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () {
                  startInactivityTimer();
                  conMain.index.value = 26;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TotalExpenseDataSource extends DataTableSource {
  final con = Get.put(TotalExpenseController());
  int selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= rowCount) return null;

    return DataRow.byIndex(
      index: index,
      cells: [
        DataTableWidget.cell(
          Get.context!,
          '${con.filteredUsers[index].id}',
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredUsers[index].name,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredUsers[index].role,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredUsers[index].user,
        ),
        DataTableWidget.cell(
          Get.context!,
          con.filteredUsers[index].dateCreate,
        ),
        DataTableWidget.cellBtn(
          Get.context!,
          edit: () => debugPrint('Edit $index'),
          delete: () {
            startInactivityTimer();
            LoadingWidget.showTextDialog(
              Get.context!,
              title: 'Warning',
              content: 'Are you sure to delete?',
              color: redColor,
              txtBack: 'Cancel',
              btnColor: secondGreyColor,
              widget: TextButton(
                onPressed: () {},
                child: AppText.title(Get.context!, txt: 'Confirm'),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  int get rowCount => con.filteredUsers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
