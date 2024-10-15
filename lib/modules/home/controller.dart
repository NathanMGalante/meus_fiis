import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meus_fiis/shared/n_utils/utils/durations.dart';
import 'package:meus_fiis/shared/storage.dart';

class HomeController extends GetxController {
  final PageController viewController = PageController(initialPage: 0);
  final RxInt currentIndex = 0.obs;

  void changeView(int index) {
    currentIndex.value = index;
    if (index != currentIndex.value) {
      viewController.animateToPage(
        index,
        duration: Durations.n100Millis,
        curve: Curves.easeInOutCubic,
      );
      Storage.instance.setInt(StorageKeys.homeViewIndex.name, index);
    }
  }

  @override
  void onInit() {
    final savedIndex = Storage.instance.getInt(StorageKeys.homeViewIndex.name);
    currentIndex.value = savedIndex ?? 0;
    viewController.jumpToPage(savedIndex ?? 0);
    super.onInit();
  }
}
