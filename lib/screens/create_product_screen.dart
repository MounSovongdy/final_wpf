import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/create_product_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/product_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateProductScreen extends StatelessWidget {
  CreateProductScreen({super.key});

  final con = Get.put(CreateProductController());
  final conPro = Get.put(ProductController());
  final conMain = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
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
            AppText.header(context, txt: conPro.title.value),
            spacer(context),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Product Information | ព័ត៌មានផលិតផល',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDropdownSearch(
                txt: 'Brand | ម៉ាក',
                value: con.brand,
                list: con.brandList,
                onChanged: (v) {
                  if (v != null) con.brand.value = v;
                },
              ),
              widget2: AppTextField(
                txt: 'Model | ផលិតផល',
                con: con.model.value,
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
                  txt: 'Cancel | បោះបង់',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                    LoadingWidget.dialogLoading(duration: 1, isBack: true);
                    con.clearText();
                    await getAllProduct();
                    conPro.filteredProduct.value = product;
                    conPro.search.value.addListener(conPro.filterProductData);
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
                    if (conPro.title.value == 'Create Product') {
                      con.createProduct(context);
                    } else {
                      con.updateProduct(context);
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
