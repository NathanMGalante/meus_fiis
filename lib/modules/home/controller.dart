import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meus_fiis/shared/n_utils/utils/durations.dart';
import 'package:meus_fiis/shared/storage.dart';

class HomeController extends GetxController {
  late final PageController viewController;
  late final RxInt currentIndex;

  @override
  void onInit() {
    final savedIndex = Storage.instance.getInt(StorageKeys.homeViewIndex.name);
    final initialPage = savedIndex ?? 0;
    viewController = PageController(initialPage: initialPage);
    currentIndex = initialPage.obs;
    super.onInit();
  }

  void changeView(int index) {
    if (index != currentIndex.value) {
      viewController.animateToPage(
        index,
        duration: Durations.n100Millis,
        curve: Curves.easeInOutCubic,
      );
      Storage.instance.setInt(StorageKeys.homeViewIndex.name, index);
    }
    currentIndex.value = index;
  }
}
