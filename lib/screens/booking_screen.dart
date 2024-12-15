import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/booking_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/new_booking_controller.dart';
import 'package:motor/controllers/report_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_data_table.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/data_table_widget.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  final con = Get.put(BookingController());
  final conMain = Get.put(MainController());
  final conNewBook = Get.put(NewBookingController());
  final conReport = Get.put(ReportController());

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
          AppText.header(context, txt: 'Booking Sale List'),
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
            () => con.filteredBooking.isNotEmpty
                ? bookingDataTable(context)
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
              Obx(
                () => con.filteredBooking.isNotEmpty &&
                        userRole.value == roleSuperAdmin
                    ? AppButtonSubmit(
                        txt: 'Report',
                        color: greenColor,
                        width: Responsive.isDesktop(context) ? 150.px : 100.px,
                        tap: () async {
                          await conReport.downloadExcel(
                            fileName: 'Booking_Report.xlsx',
                            headers: [
                              'ID',
                              'Salesman',
                              'Date',
                              'ID Card',
                              'Name',
                              'Tel',
                              'Brand',
                              'Model',
                              'Color',
                              'Year',
                              'Power',
                              'Condition',
                              'Price',
                              'Remain',
                              'Micro',
                              'Status Booking',
                              'Status Done',
                              'Working hours'
                            ],
                            data: [],
                          );
                        },
                      )
                    : Container(),
              ),
              spacer(context),
              AppButtonSubmit(
                txt: 'New',
                width: Responsive.isDesktop(context) ? 150.px : 100.px,
                tap: () async {
                  LoadingWidget.dialogLoading(duration: 1, isBack: true);
                  conNewBook.clearText();
                  con.title.value = 'New Booking';
                  conNewBook.date.value.text = '$dateNow $timeNow';
                  conNewBook.discount.value.text = '0';
                  await microName();
                  await saleManName();
                  await brandName();
                  await addressName();
                  await colorName();

                  startInactivityTimer();
                  Get.back();
                  conMain.index.value = 2;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> addressName() async {
    conNewBook.addressList.clear();
    await getAllAddress();
    address.sort((a, b) => a.id.compareTo(b.id));
    for (var data in address) {
      conNewBook.addressList.add(data.address);
    }
  }

  Future<void> microName() async {
    conNewBook.microList.clear();
    await getAllMicro();
    micro.sort((a, b) => a.id.compareTo(b.id));
    for (var data in micro) {
      conNewBook.microList.add(data.name);
    }
  }

  Future<void> saleManName() async {
    conNewBook.saleManList.clear();
    await getAllSaleMan();
    saleMan.sort((a, b) => a.id.compareTo(b.id));
    for (var data in saleMan) {
      conNewBook.saleManList.add(data.name);
    }
  }

  Future<void> brandName() async {
    conNewBook.brandList.clear();
    await getAllBrand();
    brand.sort((a, b) => a.id.compareTo(b.id));
    for (var data in brand) {
      conNewBook.brandList.add(data.brand);
    }
  }

  Future<void> colorName() async {
    conNewBook.colorList.clear();
    await getAllColor();
    color.sort((a, b) => a.id.compareTo(b.id));
    for (var data in color) {
      conNewBook.colorList.add(data.color);
    }
  }

  Widget bookingDataTable(BuildContext context) {
    final con = Get.put(BookingController());
    final conNewBook = Get.put(NewBookingController());
    final conMain = Get.put(MainController());

    void showDialogStatus(
      BuildContext context, {
      required int bookingId,
      required String bookingDate,
    }) {
      var res = byBookingMicro[0];

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: AppText.header(context, txt: 'Booking Status'),
            content: SizedBox(
              height: 280.px,
              child: Column(
                children: [
                  spacer(context),
                  AppDropdownSearch(
                    txt: 'Micro',
                    value: con.oldMicro,
                    list: conNewBook.microList,
                    enable: false,
                    onChanged: (v) {
                      startInactivityTimer();
                      if (v != null) con.oldMicro.value = v;
                    },
                  ),
                  spacer(context),
                  AppDropdownSearch(
                    txt: 'Status',
                    value: con.status,
                    list: con.statusList,
                    enable: res.statusBooking1 == "New" ? true : false,
                    onChanged: (v) async {
                      startInactivityTimer();
                      if (v != null) con.status.value = v;
                    },
                  ),
                  spacer(context),
                  AppDropdownSearch(
                    txt: 'New Micro',
                    value: con.newMicro,
                    list: conNewBook.microList,
                    enable: res.statusBooking1 == "Reject" && res.micro2 == ''
                        ? true
                        : false,
                    onChanged: (v) {
                      startInactivityTimer();
                      if (v != null) con.newMicro.value = v;
                    },
                  ),
                  spacer(context),
                  AppDropdownSearch(
                    txt: 'New Status',
                    value: con.newStatus,
                    list: con.statusList,
                    enable: res.statusBooking1 == "Reject" &&
                            res.statusBooking2 == "New" &&
                            res.micro2 != ''
                        ? true
                        : false,
                    onChanged: (v) async {
                      startInactivityTimer();
                      if (v != null) con.newStatus.value = v;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              AppButtonSubmit(
                txt: 'Back',
                width: 100.px,
                color: secondGreyColor,
                tap: () => Navigator.of(context).pop(),
              ),
              res.statusBooking1 == 'Approve' ||
                      res.statusBooking2 == 'Approve' ||
                      res.statusBooking2 == 'Reject'
                  ? Container()
                  : spacer(context),
              res.statusBooking1 == 'Approve' ||
                      res.statusBooking2 == 'Approve' ||
                      res.statusBooking2 == 'Reject'
                  ? Container()
                  : spacer(context),
              res.statusBooking1 == 'Approve' ||
                      res.statusBooking2 == 'Approve' ||
                      res.statusBooking2 == 'Reject'
                  ? Container()
                  : AppButtonSubmit(
                      txt: 'Update',
                      width: 120.px,
                      tap: () async {
                        startInactivityTimer();
                        await con.updateStaus(bookingId, bookingDate);

                        await getAllBooking();
                        con.filteredBooking.value = booking;
                        con.search.value.addListener(con.filterBookingData);

                        Get.back();
                      },
                    ),
            ],
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Obx(
          () => AppText.title(
            context,
            txt: 'Total Record: ${con.filteredBooking.length}',
          ),
        ),
        SizedBox(height: 2.px),
        AppDataTable(
          columnHeaders: [
            DataTableWidget.column(context, 'ID'),
            DataTableWidget.column(context, 'Saleman'),
            DataTableWidget.column(context, 'Date'),
            DataTableWidget.column(context, 'ID Card'),
            DataTableWidget.column(context, 'Name'),
            DataTableWidget.column(context, 'Tel'),
            DataTableWidget.column(context, 'Brand'),
            DataTableWidget.column(context, 'Model'),
            DataTableWidget.column(context, 'Color'),
            DataTableWidget.column(context, 'Year'),
            DataTableWidget.column(context, 'Power'),
            DataTableWidget.column(context, 'Condition'),
            DataTableWidget.column(context, 'Price'),
            DataTableWidget.column(context, 'Remain'),
            DataTableWidget.column(context, 'Micro'),
            DataTableWidget.column(context, 'Status Booking'),
            DataTableWidget.column(context, 'Status Done'),
            DataTableWidget.column(context, 'Working Hours'),
            DataTableWidget.column(context, 'Action'),
          ],
          rowData: List.generate(
            con.filteredBooking.length,
            (index) {
              var data = con.filteredBooking[index];
              return [
                DataTableWidget.cell(Get.context!, '${data.id}'),
                DataTableWidget.cell(Get.context!, data.saleman),
                DataTableWidget.cell(Get.context!, data.bookingDate),
                DataTableWidget.cell(Get.context!, data.idCard),
                DataTableWidget.cell(Get.context!, data.name),
                DataTableWidget.cell(Get.context!, data.tel),
                DataTableWidget.cell(Get.context!, data.brand),
                DataTableWidget.cell(Get.context!, data.model),
                DataTableWidget.cell(Get.context!, data.color),
                DataTableWidget.cell(Get.context!, data.year),
                DataTableWidget.cell(Get.context!, data.power),
                DataTableWidget.cell(Get.context!, data.condition),
                DataTableWidget.cell(Get.context!, data.price),
                DataTableWidget.cell(Get.context!, data.remain),
                DataTableWidget.cell(Get.context!, data.micro),
                DataTableWidget.cell(Get.context!, data.statusBooking),
                DataTableWidget.cell(Get.context!, data.statusDone),
                DataTableWidget.cell(Get.context!, data.workingHours),
                DataTableWidget.cellBtn(
                  Get.context!,
                  btnUpdate: true,
                  edit: () async {
                    startInactivityTimer();
                    if (data.statusBooking == "New") {
                      conNewBook.clearText();
                      con.title.value = 'Edit Booking';
                      await microName();
                      await saleManName();
                      await brandName();
                      await addressName();
                      await colorName();

                      await con.editBooking(data.id);
                      conMain.index.value = 2;
                    } else {
                      LoadingWidget.showTextDialog(
                        context,
                        color: redColor,
                        title: "Warning",
                        content:
                            'Can not update because the booking status not "NEW"',
                      );
                    }
                  },
                  update: () async {
                    startInactivityTimer();
                    await microName();
                    await getByBookingMicro(data.id);

                    con.clearDialog();
                    con.status.value = byBookingMicro[0].statusBooking1;
                    con.newStatus.value = byBookingMicro[0].statusBooking2;
                    con.oldMicro.value = byBookingMicro[0].micro1;
                    con.newMicro.value = byBookingMicro[0].micro2;

                    showDialogStatus(
                      Get.context!,
                      bookingId: data.id,
                      bookingDate: data.bookingDate,
                    );
                  },
                  delete: () async {
                    startInactivityTimer();
                    if (data.statusDone == "") {
                      LoadingWidget.showTextDialog(
                        Get.context!,
                        title: 'Warning',
                        content: 'Are you sure to delete?',
                        color: redColor,
                        txtBack: 'Cancel',
                        btnColor: secondGreyColor,
                        widget: TextButton(
                          onPressed: () async {
                            Get.back();
                            await con.removeBooking(data.id);
                          },
                          child: AppText.title(Get.context!, txt: 'Confirm'),
                        ),
                      );
                    } else {
                      LoadingWidget.showTextDialog(
                        context,
                        color: redColor,
                        title: "Warning",
                        content:
                            'Can not delete because the booking is already create Leasing',
                      );
                    }
                  },
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}
