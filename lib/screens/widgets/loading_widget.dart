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
    value,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // No rounded corners
          ),
          title: AppText.header(context, txt: title,),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText.title(context, txt: txtBack, color: bgColor),
            ),
            widget ?? Container(), // Optional widget
          ],
          content: SizedBox(
            height: 100.px,
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(value: value, onChanged: onChanged),
                    spacer(context),
                    spacer(context),
                    AppText.title(context, txt: "Approved"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: value, onChanged: onChanged),
                    spacer(context),
                    spacer(context),
                    AppText.title(context, txt: "Rejected"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: value, onChanged: onChanged),
                    spacer(context),
                    spacer(context),
                    AppText.title(context, txt: "Cancel"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
