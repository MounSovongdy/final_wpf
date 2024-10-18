import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/add_stock_controller.dart';
import 'package:motor/controllers/newBooking_controller.dart';
import 'package:motor/controllers/total_stock_controller.dart';
import 'package:motor/screens/components/drawer_expansion_tile.dart';
import 'package:motor/screens/components/drawer_list_tile.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restart_app/restart_app.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({super.key});

  final con = Get.put(MainController());
  final conTS = Get.put(TotalStockController());
  final conAS = Get.put(AddStockController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Responsive.isMobile(context)
              ? DrawerHeader(padding: EdgeInsets.zero, child: Container())
              : Container(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerListTile(
                  tap: () {
                    if (Responsive.isMobile(context)) con.controlDrawer();
                    startInactivityTimer();

                    con.index.value = 0;
                  },
                  title: 'Dashboard',
                  svgSrc: 'assets/icons/Dashboard.svg',
                ),
                DrawerListTile(
                  tap: () {
                    if (Responsive.isMobile(context)) con.controlDrawer();
                    startInactivityTimer();

                    con.index.value = 1;
                  },
                  title: 'Booking',
                  svgSrc: 'assets/icons/Booking.svg',
                ),
                DrawerExpansionTile(
                  title: 'Sale Record',
                  svgSrc: 'assets/icons/Financial.svg',
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 2;
                        },
                        title: 'Leasing',
                        svgSrc: 'assets/icons/SaleRecord.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 16;
                        },
                        title: 'Cash',
                        svgSrc: 'assets/icons/TotalExpenses.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 17;
                        },
                        title: 'Report',
                        svgSrc: 'assets/icons/Report.svg',
                      ),
                    ),
                  ],
                ),
                DrawerListTile(
                  tap: () {
                    if (Responsive.isMobile(context)) con.controlDrawer();
                    startInactivityTimer();

                    con.index.value = 3;
                  },
                  title: 'Receivable',
                  svgSrc: 'assets/icons/Receivable.svg',
                ),
                DrawerListTile(
                  tap: () {
                    if (Responsive.isMobile(context)) con.controlDrawer();
                    startInactivityTimer();

                    con.index.value = 9;
                  },
                  title: 'Print Invoice',
                  svgSrc: 'assets/icons/Invoice.svg',
                ),
                DrawerExpansionTile(
                  title: 'Stock',
                  svgSrc: 'assets/icons/Stock.svg',
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          conTS.filteredUsers.value = user;
                          conTS.search.value.addListener(conTS.filterUserData);
                          con.index.value = 4;
                        },
                        title: 'Stock',
                        svgSrc: 'assets/icons/TotalStock.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 6;
                        },
                        title: 'Create Product',
                        svgSrc: 'assets/icons/CreateProduct.svg',
                      ),
                    ),
                  ],
                ),
                DrawerExpansionTile(
                  title: 'Financial',
                  svgSrc: 'assets/icons/Financial.svg',
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 7;
                        },
                        title: 'Financial Report',
                        svgSrc: 'assets/icons/FinancialReport.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 8;
                        },
                        title: 'Total Expenses',
                        svgSrc: 'assets/icons/TotalExpenses.svg',
                      ),
                    ),
                  ],
                ),
                DrawerExpansionTile(
                  title: 'Management',
                  svgSrc: 'assets/icons/Management.svg',
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 13;
                        },
                        title: 'User',
                        svgSrc: 'assets/icons/CreateUser.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 14;
                        },
                        title: 'Salesman',
                        svgSrc: 'assets/icons/CreateSalesman.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 15;
                        },
                        title: 'Micro',
                        svgSrc: 'assets/icons/CreateMicro.svg',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerListTile(
                tap: () {
                  if (!GetPlatform.isWeb) {
                    Restart.restartApp(
                      notificationTitle: 'Restarting App',
                      notificationBody: 'Tap here to open the app again.',
                    );
                  } else {
                    reload();
                  }
                },
                title: 'Log Out',
                svgSrc: 'assets/icons/Logout.svg',
              ),
              const UnderLine(),
              Padding(
                padding: EdgeInsets.all(13.px),
                child: AppText.subTitle(
                  context,
                  txt: '© 2024 Admin Dashboard',
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
