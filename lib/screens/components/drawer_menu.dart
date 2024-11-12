import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/add_stock_controller.dart';
import 'package:motor/controllers/address_controller.dart';
import 'package:motor/controllers/advertising_controller.dart';
import 'package:motor/controllers/booking_controller.dart';
import 'package:motor/controllers/cash_controller.dart';
import 'package:motor/controllers/commission_controller.dart';
import 'package:motor/controllers/finance_card_controller.dart';
import 'package:motor/controllers/finance_record_controller.dart';
import 'package:motor/controllers/gift_controller.dart';
import 'package:motor/controllers/koi_controller.dart';
import 'package:motor/controllers/leasing_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/micro_controller.dart';
import 'package:motor/controllers/product_controller.dart';
import 'package:motor/controllers/receivable_controller.dart';
import 'package:motor/controllers/rental_controller.dart';
import 'package:motor/controllers/reset_password_controller.dart';
import 'package:motor/controllers/salesman_controller.dart';
import 'package:motor/controllers/staff_controller.dart';
import 'package:motor/controllers/teacher_bonus_controller.dart';
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
  final conBook = Get.put(BookingController());
  final conLeasing = Get.put(LeasingController());
  final conCash = Get.put(CashController());
  final conRec = Get.put(ReceivableController());
  final conA = Get.put(AddressController());
  final conStaff = Get.put(StaffController());
  final conFri = Get.put(CommissionController());
  final conTeacher = Get.put(MicroExpenseController());
  final conAdv = Get.put(AdvertisingController());
  final conRental = Get.put(RentalController());
  final conGift = Get.put(GiftController());
  final conKoi = Get.put(KoiController());
  final conReset = Get.put(ResetPasswordController());
  final conFR = Get.put(FinanceRecordController());
  final conFC = Get.put(FinanceCardController());

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
                  tap: () async {
                    if (Responsive.isMobile(context)) con.controlDrawer();
                    startInactivityTimer();
                    await getAllBooking();
                    conBook.filteredBooking.value = booking;
                    conBook.search.value.addListener(conBook.filterBookingData);
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
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllLeasing();
                          conLeasing.filteredLeasing.value = leasing;
                          conLeasing.search.value
                              .addListener(conLeasing.filterLeasingData);
                          con.index.value = 21;
                        },
                        title: 'Leasing Sale',
                        svgSrc: 'assets/icons/SaleRecord.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllCash();
                          conCash.filteredCash.value = cash;
                          conCash.search.value
                              .addListener(conCash.filterCashData);

                          con.index.value = 23;
                        },
                        title: 'Cash Sale',
                        svgSrc: 'assets/icons/TotalExpenses.svg',
                      ),
                    ),
                  ],
                ),
                DrawerListTile(
                  tap: () async {
                    if (Responsive.isMobile(context)) con.controlDrawer();
                    startInactivityTimer();
                    await getAllReceivable();
                    conRec.filteredRece.value = receivable;
                    conRec.search.value
                        .addListener(conRec.filterReceivableData);

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
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllTotalExpense();
                          conFR.monthList.clear();
                          if (totalExpense.isNotEmpty) {
                            for (var data in totalExpense) {
                              conFR.monthList.add('${data.year}-${data.month}');
                            }
                            conFR.monthList.value =
                                conFR.monthList.toSet().toList();
                            conFR.selectedMonth.value = conFR.monthList[0];

                            await getTotalExpense(
                              year: conFR.selectedMonth.value!.split('-')[0],
                              month: conFR.selectedMonth.value!.split('-')[1],
                            );
                            if (byTotalExpense.isNotEmpty) {
                              var tempA =
                                  num.parse(byTotalExpense[0].advertise);
                              var tempS = num.parse(byTotalExpense[0].salaryE);
                              var tempr = num.parse(byTotalExpense[0].rental);
                              var tempk = num.parse(byTotalExpense[0].koi);
                              var tempg = num.parse(byTotalExpense[0].gift);
                              var tempe = num.parse(byTotalExpense[0].bonusE);
                              var tempt = num.parse(byTotalExpense[0].bonusT);
                              var tempc =
                                  num.parse(byTotalExpense[0].commission);
                              var tempte =
                                  num.parse(byTotalExpense[0].totalExpense);

                              conFC.adv.value = '$tempA'.contains('.')
                                  ? num.parse('$tempA').toStringAsFixed(2)
                                  : num.parse('$tempA').toString();
                              conFC.salary.value = '$tempS'.contains('.')
                                  ? num.parse('$tempS').toStringAsFixed(2)
                                  : num.parse('$tempS').toString();
                              conFC.rent.value = '$tempr'.contains('.')
                                  ? num.parse('$tempr').toStringAsFixed(2)
                                  : num.parse('$tempr').toString();
                              conFC.koi.value = '$tempk'.contains('.')
                                  ? num.parse('$tempk').toStringAsFixed(2)
                                  : num.parse('$tempk').toString();
                              conFC.gift.value = '$tempg'.contains('.')
                                  ? num.parse('$tempg').toStringAsFixed(2)
                                  : num.parse('$tempg').toString();
                              conFC.bonusE.value = '$tempe'.contains('.')
                                  ? num.parse('$tempe').toStringAsFixed(2)
                                  : num.parse('$tempe').toString();
                              conFC.bonusT.value = '$tempt'.contains('.')
                                  ? num.parse('$tempt').toStringAsFixed(2)
                                  : num.parse('$tempt').toString();
                              conFC.comm.value = '$tempc'.contains('.')
                                  ? num.parse('$tempc').toStringAsFixed(2)
                                  : num.parse('$tempc').toString();

                              conFR.totalExpense.value.text = '$tempte'
                                      .contains('.')
                                  ? '${num.parse('$tempte').toStringAsFixed(2)} \$'
                                  : '${num.parse('$tempte')} \$';

                              conFC.itemValue.value = [
                                {'value': '${conFC.adv.value} \$'},
                                {'value': '${conFC.rent.value} \$'},
                                {'value': '${conFC.salary.value} \$'},
                                {'value': '${conFC.koi.value} \$'},
                                {'value': '${conFC.gift.value} \$'},
                                {'value': '${conFC.bonusE.value} \$'},
                                {'value': '${conFC.bonusT.value} \$'},
                                {'value': '${conFC.comm.value} \$'},
                              ];

                              conFC.financeValue.value = [
                                {'value': '${conFC.netsale.value} \$'},
                                {'value': '${conFC.saleRevenue.value} \$'},
                                {'value': '${conFC.totalUnitSale.value} \$'},
                                {'value': '${conFC.avgSaleRevenue.value} \$'},
                                {'value': '${conFC.avgProfit.value} \$'},
                              ];
                            }
                          }

                          con.index.value = 13;
                        },
                        title: 'Financial Report',
                        svgSrc: 'assets/icons/FinancialReport.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllSaleManCommission();
                          conStaff.monthList.clear();
                          if (saleManCom.isNotEmpty) {
                            for (var data in saleManCom) {
                              conStaff.monthList
                                  .add('${data.year}-${data.month}');
                            }
                            conStaff.monthList.value =
                                conStaff.monthList.toSet().toList();
                            conStaff.selectedMonth.value =
                                conStaff.monthList[0];
                            conStaff.filteredStaff.clear();
                            await getByDateSaleManCommission(
                              conStaff.selectedMonth.value!.split('-')[0],
                              conStaff.selectedMonth.value!.split('-')[1],
                            );
                            await getTotalExpense(
                              year: conStaff.selectedMonth.value!.split('-')[0],
                              month:
                                  conStaff.selectedMonth.value!.split('-')[1],
                            );
                            if (byTotalExpense.isNotEmpty) {
                              var temp = num.parse(byTotalExpense[0].salaryE) +
                                  num.parse(byTotalExpense[0].bonusE);
                              conStaff.amount.value.text = '$temp'.contains('.')
                                  ? num.parse('$temp').toStringAsFixed(2)
                                  : num.parse('$temp').toString();
                            }
                          }
                          conStaff.filteredStaff.value = saleManCom;
                          conStaff.search.value
                              .addListener(conStaff.filterStaffData);

                          con.index.value = 43;
                        },
                        title: 'Staff Expense',
                        svgSrc: 'assets/icons/Staff.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllMicroCommission();
                          conTeacher.monthList.clear();
                          if (microCom.isNotEmpty) {
                            for (var data in microCom) {
                              conTeacher.monthList
                                  .add('${data.year}-${data.month}');
                            }
                            conTeacher.monthList.value =
                                conTeacher.monthList.toSet().toList();
                            conTeacher.selectedMonth.value =
                                conTeacher.monthList[0];
                            conTeacher.filteredMicro.clear();
                            await getByDateMicroCommission(
                              conTeacher.selectedMonth.value!.split('-')[0],
                              conTeacher.selectedMonth.value!.split('-')[1],
                            );
                            await getTotalExpense(
                              year:
                                  conTeacher.selectedMonth.value!.split('-')[0],
                              month:
                                  conTeacher.selectedMonth.value!.split('-')[1],
                            );
                            if (byTotalExpense.isNotEmpty)
                              conTeacher.amount.value.text =
                                  byTotalExpense[0].bonusT;
                            else
                              conTeacher.amount.value.text = '';
                          }
                          conTeacher.filteredMicro.value = microCom;
                          conTeacher.search.value
                              .addListener(conTeacher.filterMicroData);

                          con.index.value = 31;
                        },
                        title: 'Teacher Bonus',
                        svgSrc: 'assets/icons/Teacher.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllAdvertise();
                          conAdv.monthList.clear();
                          if (advertise.isNotEmpty) {
                            for (var data in advertise) {
                              conAdv.monthList
                                  .add('${data.year}-${data.month}');
                            }
                            conAdv.monthList.value =
                                conAdv.monthList.toSet().toList();
                            conAdv.selectedMonth.value = conAdv.monthList[0];
                            conAdv.filteredAdv.clear();
                            await getByDateAdvertise(
                              conAdv.selectedMonth.value!.split('-')[0],
                              conAdv.selectedMonth.value!.split('-')[1],
                            );
                            await getTotalExpense(
                              year: conAdv.selectedMonth.value!.split('-')[0],
                              month: conAdv.selectedMonth.value!.split('-')[1],
                            );
                            if (byTotalExpense.isNotEmpty)
                              conAdv.amount.value.text =
                                  byTotalExpense[0].advertise;
                            else
                              conAdv.amount.value.text = '';
                          }
                          conAdv.filteredAdv.value = advertise;
                          conAdv.search.value.addListener(conAdv.filterAdvData);

                          con.index.value = 33;
                        },
                        title: 'Advertising',
                        svgSrc: 'assets/icons/Adv.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllKoi();
                          conKoi.monthList.clear();
                          if (koi.isNotEmpty) {
                            for (var data in koi) {
                              conKoi.monthList
                                  .add('${data.year}-${data.month}');
                            }
                            conKoi.monthList.value =
                                conKoi.monthList.toSet().toList();
                            conKoi.selectedMonth.value = conKoi.monthList[0];
                            conKoi.filteredKoi.clear();
                            await getByDateKoi(
                              conKoi.selectedMonth.value!.split('-')[0],
                              conKoi.selectedMonth.value!.split('-')[1],
                            );
                            await getTotalExpense(
                              year: conKoi.selectedMonth.value!.split('-')[0],
                              month: conKoi.selectedMonth.value!.split('-')[1],
                            );
                            if (byTotalExpense.isNotEmpty)
                              conKoi.amount.value.text = byTotalExpense[0].koi;
                            else
                              conKoi.amount.value.text = '';
                          }
                          conKoi.filteredKoi.value = koi;
                          conKoi.search.value.addListener(conKoi.filterKoiData);

                          con.index.value = 35;
                        },
                        title: 'KOI',
                        svgSrc: 'assets/icons/Koi.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllGift();
                          conGift.monthList.clear();
                          if (gift.isNotEmpty) {
                            for (var data in gift) {
                              conGift.monthList
                                  .add('${data.year}-${data.month}');
                            }
                            conGift.monthList.value =
                                conGift.monthList.toSet().toList();
                            conGift.selectedMonth.value = conGift.monthList[0];
                            conGift.filteredGift.clear();
                            await getByDateGift(
                              conGift.selectedMonth.value!.split('-')[0],
                              conGift.selectedMonth.value!.split('-')[1],
                            );
                            await getTotalExpense(
                              year: conGift.selectedMonth.value!.split('-')[0],
                              month: conGift.selectedMonth.value!.split('-')[1],
                            );
                            if (byTotalExpense.isNotEmpty)
                              conGift.amount.value.text =
                                  byTotalExpense[0].gift;
                            else
                              conGift.amount.value.text = '';
                          }
                          conGift.filteredGift.value = gift;
                          conGift.search.value
                              .addListener(conGift.filterGiftData);

                          con.index.value = 37;
                        },
                        title: 'Gift',
                        svgSrc: 'assets/icons/Gift.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllFriendCommission();
                          conFri.monthList.clear();
                          if (friendCom.isNotEmpty) {
                            for (var data in friendCom) {
                              conFri.monthList
                                  .add('${data.year}-${data.month}');
                            }
                            conFri.monthList.value =
                                conFri.monthList.toSet().toList();
                            conFri.selectedMonth.value = conFri.monthList[0];
                            conFri.filteredCommission.clear();
                            await getByDateFriendCommission(
                              conFri.selectedMonth.value!.split('-')[0],
                              conFri.selectedMonth.value!.split('-')[1],
                            );
                            await getTotalExpense(
                              year: conFri.selectedMonth.value!.split('-')[0],
                              month: conFri.selectedMonth.value!.split('-')[1],
                            );
                            if (byTotalExpense.isNotEmpty)
                              conFri.amount.value.text =
                                  byTotalExpense[0].commission;
                            else
                              conFri.amount.value.text = '';
                          }
                          conFri.filteredCommission.value = friendCom;
                          conFri.search.value
                              .addListener(conFri.filterCommissionData);

                          con.index.value = 39;
                        },
                        title: 'Commission',
                        svgSrc: 'assets/icons/TotalExpenses.svg',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllRental();
                          conRental.monthList.clear();
                          if (rental.isNotEmpty) {
                            for (var data in rental) {
                              conRental.monthList
                                  .add('${data.year}-${data.month}');
                            }
                            conRental.monthList.value =
                                conRental.monthList.toSet().toList();
                            conRental.selectedMonth.value =
                                conRental.monthList[0];
                            conRental.filteredRental.clear();
                            await getByDateRental(
                              conRental.selectedMonth.value!.split('-')[0],
                              conRental.selectedMonth.value!.split('-')[1],
                            );
                            await getTotalExpense(
                              year:
                                  conRental.selectedMonth.value!.split('-')[0],
                              month:
                                  conRental.selectedMonth.value!.split('-')[1],
                            );
                            if (byTotalExpense.isNotEmpty)
                              conRental.amount.value.text =
                                  byTotalExpense[0].rental;
                            else
                              conRental.amount.value.text = '';
                          }
                          conRental.filteredRental.value = rental;
                          conRental.search.value
                              .addListener(conRental.filterRentalData);

                          con.index.value = 41;
                        },
                        title: 'Rental',
                        svgSrc: 'assets/icons/Rental.svg',
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
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          await getAllAddress();
                          conA.filteredAddress.value = address;
                          conA.search.value.addListener(conA.filterAddressData);

                          con.index.value = 27;
                        },
                        title: 'Address',
                        svgSrc: 'assets/icons/Address.svg',
                      ),
                    ),
                  ],
                ),
                DrawerExpansionTile(
                  title: 'Setting',
                  svgSrc: 'assets/icons/Setting.svg',
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 36.px),
                      child: DrawerListTile(
                        tap: () async {
                          if (Responsive.isMobile(context)) con.controlDrawer();
                          startInactivityTimer();
                          conReset.clearText();
                          await getAllUser();
                          conReset.fullNameList.clear();
                          for (var data in user)
                            conReset.fullNameList.add(data.name);

                          con.index.value = 45;
                        },
                        title: 'Reset Password',
                        svgSrc: 'assets/icons/ResetPassword.svg',
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
              spacer(context),
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
                child: Row(
                  children: [
                    AppText.subTitle(
                      context,
                      txt: '© 2024 Admin Dashboard',
                      color: whiteColor,
                    ),
                    const Spacer(),
                    AppText.subTitle(
                      context,
                      txt: 'v1.0.1',
                      color: whiteColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
