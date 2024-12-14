import 'package:get/get.dart';

class FinanceCardController extends GetxController {
  var total = '0'.obs;
  var adv = '0'.obs;
  var rent = '0'.obs;
  var salary = '0'.obs;
  var koi = '0'.obs;
  var gift = '0'.obs;
  var bonusE = '0'.obs;
  var bonusT = '0'.obs;
  var comm = '0'.obs;
  var netsale = '0'.obs;
  var saleRevenue = '0'.obs;
  var totalUnitSale = '0'.obs;
  var totalProfit = '0'.obs;
  var avgProfit = '0'.obs;

  final itemTitle = [
    {'name': 'Advertising'},
    {'name': 'Prepaid Rent'},
    {'name': 'Payable Salary'},
    {'name': 'Prepaid expense	KOI'},
    {'name': 'Free Gift'},
    {'name': 'Bonus E'},
    {'name': 'Bonus T'},
    {'name': 'Commission'},
  ];
  final financeTitle = [
    {'name': 'Net Sale'},
    {'name': 'Sale Revenue'},
    {'name': 'Total Unit Sale'},
    {'name': 'Total Profit'},
    {'name': 'Average Profit'},
  ];

  var itemValue = [].obs;
  var financeValue = [].obs;
}
