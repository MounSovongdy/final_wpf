import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDropdownSearch extends StatelessWidget {
  final String txt;
  final bool showSuffixIcon;
  final Widget? suffix;
  final double width, height;
  final List<String> list;
  final Rxn<String> value;
  final Function(String?)? onChanged;

  AppDropdownSearch({
    super.key,
    required this.txt,
    required this.list,
    required this.value,
    required this.onChanged,
    this.showSuffixIcon = false,
    this.suffix,
    this.width = 150,
    this.height = 40,
  });

  final dropDownKey = GlobalKey<DropdownSearchState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 20.px),
            child: AppText.title(context, txt: txt, textAlign: TextAlign.right),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: width.px,
            height: height.px,
            child: Obx(
              () => DropdownSearch<String>(
                key: dropDownKey,
                selectedItem: value.value,
                onChanged: onChanged,
                items: (filter, props) => getItems(filter, props),
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: defWebPad.px,
                    ),
                  ),
                ),
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  fit: FlexFit.loose,
                  constraints: BoxConstraints(maxHeight: 300.px),
                  scrollbarProps: const ScrollbarProps(
                    interactive: true,
                    thumbVisibility: true,
                  ),
                  suggestedItemProps: const SuggestedItemProps(),
                  searchFieldProps: TextFieldProps(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.all(8),
                      hintStyle: TextStyle(
                        fontSize: 14.px,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                dropdownBuilder: (context, selectedItem) {
                  selectedItem = value.value;
                  return AppText.title(context, txt: selectedItem ?? '');
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<List<String>> getItems(String filter, LoadProps? props) async {
    await Future.delayed(const Duration(microseconds: 100));

    List<String> allItems = list;

    if (filter.isNotEmpty) {
      return allItems
          .where((item) => item.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    }

    return allItems;
  }
}
