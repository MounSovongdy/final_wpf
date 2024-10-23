import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/add_stock_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/micro_controller.dart';
import 'package:motor/controllers/product_controller.dart';
import 'package:motor/controllers/salesman_controller.dart';
import 'package:motor/controllers/total_stock_controller.dart';
import 'package:motor/controllers/user_controller.dart';
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
  final conU = Get.put(UserController());
  final conMi = Get.put(MicroController());
  final conSM = Get.put(SalesmanController());
  final conPro = Get.put(ProductController());

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

                          con.index.value = 21;
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

                          con.index.value = 23;
                        },
                        title: 'Cash',
                        svgSrc: 'assets/icons/TotalExpenses.svg',
                      ),
                    ),
                  ],
                ),
                DrawerListTile(
                  tap: () {
                    if (Responsive.isMobile(context)) con.controlDrawer();
                    startInactivityTimer();

                    con.index.value = 6;
                  },
                  title: 'Receivable',
                  svgSrc: 'assets/icons/Receivable.svg',
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
                          await getAllStock();
                          conTS.filteredTotalStock.value = totalStock;
                          conTS.search.value
                              .addListener(conTS.filterTotalStockData);
                          con.index.value = 9;
                        },
                        title: 'Stock',
                        svgSrc: 'assets/icons/TotalStock.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllProduct();
                          conPro.filteredProduct.value = product;
                          conPro.search.value
                              .addListener(conPro.filterProductData);

                          con.index.value = 11;
                        },
                        title: 'Product',
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

                          con.index.value = 25;
                        },
                        title: 'Expenses',
                        svgSrc: 'assets/icons/TotalExpenses.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();

                          con.index.value = 13;
                        },
                        title: 'Financial Report',
                        svgSrc: 'assets/icons/FinancialReport.svg',
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
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllUser();
                          conU.filteredUsers.value = user;
                          conU.search.value.addListener(conU.filterUserData);
                          con.index.value = 15;
                        },
                        title: 'User',
                        svgSrc: 'assets/icons/CreateUser.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllSaleMan();
                          conSM.filteredSale.value = saleMan;
                          conSM.search.value.addListener(conSM.filterSaleData);

                          con.index.value = 17;
                        },
                        title: 'Salesman',
                        svgSrc: 'assets/icons/CreateSalesman.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllMicro();
                          conMi.filteredMicro.value = micro;
                          conMi.search.value.addListener(conMi.filterMicroData);

                          con.index.value = 19;
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
