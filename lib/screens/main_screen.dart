import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/screens/add_stock_screen.dart';
import 'package:motor/screens/booking_screen.dart';
import 'package:motor/screens/create_product_screen.dart';
import 'package:motor/screens/dashboard_screen.dart';
import 'package:motor/screens/financial_record_screen.dart';
import 'package:motor/screens/invoice_screen.dart';
import 'package:motor/screens/receivable_screen.dart';
import 'package:motor/screens/sale_record_screen.dart';
import 'package:motor/screens/total_expense_screen.dart';
import 'package:motor/screens/total_stock_screen.dart';
import 'package:motor/screens/widgets/custom_app_bar.dart';
import 'package:motor/screens/components/drawer_menu.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final con = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) con.drawer.value = true;

    var appBar = CustomAppBar.defAppBar(
      context,
      tap: con.controlMenu,
      txt: 'Admin Level',
    );

    var drawer = Drawer(child: DrawerMenu());

    var mobile = screenWidget;

    var desktop = Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (con.drawer.value) Expanded(child: DrawerMenu()),
          Expanded(flex: 4, child: screenWidget),
        ],
      ),
    );

    var body = SafeArea(
      child: Responsive(
        mobile: mobile,
        desktop: desktop,
      ),
    );

    return Scaffold(
      backgroundColor: greyColor,
      key: con.scaffoldKey,
      drawer: Responsive.isMobile(context) ? drawer : null,
      appBar: appBar,
      body: body,
    );
  }

  Widget get screenWidget {
    return Obx(() {
      switch (con.index.value) {
        case 0:
          return DashboardScreen();
        case 1:
          return BookingScreen();
        case 2:
          return SaleRecordScreen();
        case 3:
          return ReceivableScreen();
        case 4:
          return TotalStockScreen();
        case 5:
          return AddStockScreen();
        case 6:
          return const CreateProductScreen();
        case 7:
          return const FinancialRecordScreen();
        case 8:
          return const TotalExpenseScreen();
        case 9:
          return const InvoiceScreen();
        default:
          return DashboardScreen();
      }
    });
  }
}
