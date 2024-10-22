import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingWidget {
  static Widget get loading {
    return const Center(child: CircularProgressIndicator());
  }

  static Widget get error {
    var txt = 'Error while loading data from server.';

    return Center(child: AppText.title(Get.context!, txt: txt));
  }

  static void dialogLoading({
    required int duration,
  }) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: 30.px,
            height: 30.px,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: duration), () {
      Get.back();
    });
  }

  static void showTextDialog(
    BuildContext context, {
    required title,
    required content,
    Color color = redColor,
    Color btnColor = blackColor,
    String txtBack = 'Confirm',
    Widget? widget,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppText.header(context, txt: title, color: color),
          content: AppText.title(context, txt: content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText.title(context, txt: txtBack, color: btnColor),
            ),
            widget ?? Container(),
          ],
        );
      },
    );
  }

  static void showEditStatusDialog(
    BuildContext context, {
    required title,
    Color color = redColor,
    Color btnColor = blackColor,
    String txtBack = 'Confirm',
    Widget? widget,
        onChanged,
  }) {
    bool isChecked = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // No rounded corners
          ),
          title: title,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText.title(context, txt: txtBack, color: bgColor),
            ),
            widget ?? Container(), // Optional widget
          ],
          content: SizedBox(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: bgColor),
                  ),
                  height: 40,
                  child: Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: onChanged,
                      ),
                      const Spacer(),
                      const Text("Padding"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
