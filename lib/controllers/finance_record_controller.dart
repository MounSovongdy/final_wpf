import 'package:get/get.dart';

class FinanceRecordController extends GetxController{
  var selectedMonth = Rxn<String>();
  var monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ].obs;
}