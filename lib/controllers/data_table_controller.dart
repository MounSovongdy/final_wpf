import 'package:get/get.dart';

class DataTableController extends GetxController {
  int currentPage = 0;

  void goToPreviousPage() {
    if (currentPage > 0) {
      currentPage--;
      update();
    }
  }

  void goToNextPage(int pageCount) {
    if (currentPage < pageCount - 1) {
      currentPage++;
      update();
    }
  }

  void resetPage() {
    currentPage = 0;
    update();
  }
}
