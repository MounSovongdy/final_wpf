import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DataTableWidget {
  static DataColumn column(
    BuildContext context,
    String label,
  ) {
    return DataColumn(
      label: AppText.title(
        context,
        txt: label,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
    );
  }

  static DataCell cell(
    BuildContext context,
    String txt,
  ) {
    return DataCell(
      AppText.title(context, txt: txt),
    );
  }

  static DataCell cellBtn(
    BuildContext context, {
    bool btnEdit = true,
    bool btnDelete = true,
    bool btnUpdate = false,
    Function()? edit,
    Function()? delete,
    Function()? update,
  }) {
    return DataCell(
      Row(
        children: [
          btnEdit
              ? InkWell(
                  onTap: edit,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: defWebPad.px,
                      vertical: defWebPad.px / 6,
                    ),
                    color: greenColor,
                    child: AppText.subTitle(
                      context,
                      txt: 'Edit',
                      color: whiteColor,
                    ),
                  ),
                )
              : Container(),
          btnDelete
              ? Row(
                  children: [
                    spacer(context),
                    InkWell(
                      onTap: delete,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: defWebPad.px / 2,
                          vertical: defWebPad.px / 6,
                        ),
                        color: redColor,
                        child: AppText.subTitle(
                          context,
                          txt: 'Delete',
                          color: whiteColor,
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
          btnUpdate
              ? Row(
                  children: [
                    spacer(context),
                    InkWell(
                      onTap: update,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: defWebPad.px / 2,
                          vertical: defWebPad.px / 6,
                        ),
                        color: updateColor,
                        child: AppText.subTitle(
                          context,
                          txt: 'Update',
                          color: whiteColor,
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
