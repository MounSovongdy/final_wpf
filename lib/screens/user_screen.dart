import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/create_user_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/user_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table_second.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final con = Get.put(UserController());
  final conCU = Get.put(CreateUserController());
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
                  ? userDataTable(context)
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
                AppButtonSubmit(
                  txt: 'New',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                    conCU.clearText();
                    con.title.value = 'Create User';
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

Widget userDataTable(BuildContext context) {
  final con = Get.put(UserController());
  final conCU = Get.put(CreateUserController());
  final conMain = Get.put(MainController());
  
  return AppDataTableSecond(
    columnHeaders: [
      DataTableWidget.column(context, 'ID'),
      DataTableWidget.column(context, 'Full Name'),
      DataTableWidget.column(context, 'Role level'),
      DataTableWidget.column(context, 'User Login'),
      DataTableWidget.column(context, 'Date Create'),
      DataTableWidget.column(context, 'Action'),
    ],
    rowData: List.generate(
      con.filteredUsers.length,
      (index) {
        var data = con.filteredUsers[index];

        return [
          DataTableWidget.cell(Get.context!, '${data.id}'),
          DataTableWidget.cell(Get.context!, data.name),
          DataTableWidget.cell(Get.context!, data.role),
          DataTableWidget.cell(Get.context!, data.user),
          DataTableWidget.cell(Get.context!, data.dateCreate),
          DataTableWidget.cellBtn(
            Get.context!,
            edit: () async {
              startInactivityTimer();
              conCU.clearText();
              con.title.value = 'Edit User';
              await con.editUser(data.id);
              conMain.index.value = 16;
            },
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
                    await deleteUser(con.filteredUsers[index].id);
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
        ];
      },
    ),
  );
}

