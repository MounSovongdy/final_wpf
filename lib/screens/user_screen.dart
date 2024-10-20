import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/user_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final con = Get.put(UserController());
  final con1 = Get.put(MainController());
  final scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: 'User List'),
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
            Obx(
              () => con.filteredUsers.isNotEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Scrollbar(
                        controller: scroll,
                        interactive: true,
                        thumbVisibility: true,
                        scrollbarOrientation: ScrollbarOrientation.bottom,
                        child: PaginatedDataTable(
                          controller: scroll,
                          showFirstLastButtons: true,
                          headingRowColor: const WidgetStatePropertyAll(
                            bgColor,
                          ),
                          showCheckboxColumn: false,
                          dataRowMinHeight: 10.px,
                          dataRowMaxHeight: 35.px,
                          headingRowHeight: 40.px,
                          rowsPerPage: con.filteredUsers.length > 8
                              ? 8
                              : con.filteredUsers.length,
                          availableRowsPerPage: const [8],
                          columns: [
                            DataTableWidget.column(context, 'ID'),
                            DataTableWidget.column(context, 'Full Name'),
                            DataTableWidget.column(context, 'Role level'),
                            DataTableWidget.column(context, 'User Login'),
                            DataTableWidget.column(context, 'Date Create'),
                            DataTableWidget.column(context, 'Action'),
                          ],
                          source: UserDataSource(),
                        ),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: defWebPad.px),
                      alignment: Alignment.center,
                      child: AppText.title(context, txt: 'No Data'),
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
                    con1.index.value = 16;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserDataSource extends DataTableSource {
  final con = Get.put(UserController());
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
                onPressed: () async {
                  deleteUser(con.filteredUsers[index].id);
                  con.filteredUsers.clear();
                  await getAllUser();
                  con.filteredUsers.value = user;
                  Get.back();
                },
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
