import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/new_booking_controller.dart';
import 'package:motor/controllers/user_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final con = Get.put(UserController());
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
          Scrollbar(
            controller: scroll,
            interactive: true,
            child: SingleChildScrollView(
              controller: scroll,
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => AppDataTable(
                  column: [
                    DataTableWidget.dataColumn(context, 'No'),
                    DataTableWidget.dataColumn(context, 'Full Name'),
                    DataTableWidget.dataColumn(context, 'Role level'),
                    DataTableWidget.dataColumn(context, 'User Login'),
                    DataTableWidget.dataColumn(context, 'Date Create'),
                    DataTableWidget.dataColumn(context, 'Status'),
                    DataTableWidget.dataColumn(context, 'Action'),
                  ],
                  row: List.generate(
                    con.filteredUsers.length,
                    (index) => DataRow(cells: [
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
                    ]),
                  ),
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
                txt: 'Create User',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () {
                  con1.index.value = 12;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
