import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/add_stock_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/total_stock_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_date_text_field.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddStockScreen extends StatelessWidget {
  AddStockScreen({super.key});

  final con = Get.put(AddStockController());
  final conTS = Get.put(TotalStockController());
  final conMain = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    final condition = ['New', 'Used'];
    var isModel = false.obs;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: conTS.title.value),
            spacer(context),
            TitleUnderline(spacer: spacer(context), txt: 'Stock Information | ព័ត៌មានស្តុក'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Model | ម៉ូដែល',
                value: con.model,
                list: con.listModel,
                onChanged: (v) async {
                  if (v != null) {
                    con.model.value = v;
                    isModel.value = true;
                    for (var data in product) {
                      if (con.model == data.model) {
                        con.brand.value.text = data.brand;
                        await con.getDataByModel();
                      }
                    }
                  }
                },
              ),
              widget2: AppTextField(
                txt: 'Brand | ម៉ាក',
                con: con.brand.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Year | ឆ្នាំ',
                con: con.proYear.value,
                readOnly: con.isRead.value,
                isNumber: true,
                digit: 4,
                onChanged: (v) => con.getDataByModel(),
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: Obx(
                () => AppDropdownSearch(
                  txt: 'Condition | លក្ខខណ្ឌ',
                  value: con.condition,
                  enable: !con.isRead.value,
                  list: isModel.value ? condition : [],
                  onChanged: (v) async {
                    if (v != null) {
                      con.condition.value = v;
                      con.getDataByModel();
                    }
                  },
                ),
              ),
              widget2: AppTextField(
                txt: 'Date In | កាលបរិច្ឆេទចូល',
                con: con.dateIn.value,
                readOnly: true,
              ),
              widget3: AppTextField(
                txt: 'Q Begin | ចំនួនដើម',
                con: con.qBegin.value,
                readOnly: true,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Price | តម្លៃ',
                con: con.priceQBegin.value,
                readOnly: true,
              ),
              widget2: AppTextField(
                txt: 'Total Price | តម្លៃសរុប',
                con: con.totalPriceQBegin.value,
                readOnly: true,
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Add | បន្ថែម',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDateTextField(
                txt: 'Date In | កាលបរិច្ឆេទចូល',
                con: con.date.value,
                readOnly: con.isRead.value,
              ),
              widget2: AppTextField(
                txt: 'Qty | ចំនួន',
                con: con.qty.value,
                isNumber: true,
                readOnly: con.isRead.value,
                onChanged: (v) {
                  if (con.price.value.text != '' && con.qty.value.text != '') {
                    var num = int.parse(con.qty.value.text) *
                        int.parse(con.price.value.text);
                    con.totalPrice.value.text = '$num';
                  } else {
                    con.totalPrice.value.clear();
                  }
                },
              ),
              widget3: AppTextField(
                txt: 'Price | តម្លៃ',
                con: con.price.value,
                readOnly: con.isRead.value,
                isNumber: true,
                digit: 5,
                onChanged: (v) {
                  if (con.qty.value.text != '' && con.price.value.text != '') {
                    var num = int.parse(con.qty.value.text) *
                        int.parse(con.price.value.text);
                    con.totalPrice.value.text = '$num';
                  } else {
                    con.totalPrice.value.clear();
                  }
                },
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Total Price | តម្លៃសរុប',
                con: con.totalPrice.value,
                readOnly: true,
              ),
            ),
            spacer(context),
            spacer(context),
            spacer(context),
            const UnderLine(color: secondGreyColor),
            spacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButtonSubmit(
                  txt: 'Back | ត្រលប់ក្រោយ',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                    LoadingWidget.dialogLoading(duration: 1, isBack: true);
                    con.clearText();
                    await getAllStock();
                    conTS.filteredTotalStock.value = totalStock;
                    conTS.search.value.addListener(conTS.filterTotalStockData);
                    Get.back();
                    conMain.index.value = conMain.index.value - 1;
                  },
                ),
                spacer(context),
                spacer(context),
                AppButtonSubmit(
                  txt: 'Save | រក្សាទុក',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                    if (conTS.title.value == 'Add Stock') {
                      con.createAddStock(context);
                    } else {
                      con.updateStock(context);
                    }
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
