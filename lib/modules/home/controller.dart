import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final PageController viewController = PageController(initialPage: 0);
  final RxInt currentIndex = 0.obs;

  void changeView(int index) {
    currentIndex.value = index;
    viewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOutCubic,
    );
  }
}
