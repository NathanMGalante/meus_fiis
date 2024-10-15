import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meus_fiis/modules/home/models/fii.dart';
import 'package:meus_fiis/shared/n_utils/utils/durations.dart';
import 'package:meus_fiis/shared/storage.dart';

class HomeController extends GetxController {
  late final PageController viewController;
  late final RxInt currentIndex;
  final RxList<Fii> wallet = <Fii>[].obs;

  @override
  void onInit() {
    _loadInitialView();
    _loadWallet();
    super.onInit();
  }

  void _loadInitialView() {
    final savedIndex = Storage.instance.getInt(StorageKeys.homeView.name);
    final initialPage = savedIndex ?? 0;
    viewController = PageController(initialPage: initialPage);
    currentIndex = initialPage.obs;
  }

  void _loadWallet() {
    final savedWallet = Storage.instance.getStringList(StorageKeys.wallet.name);
    if (savedWallet != null && savedWallet.isNotEmpty) {
      wallet.addAll(savedWallet.map((json) => Fii.fromJson(json)).toList());
    }
  }

  void changeView(int index) {
    if (index != currentIndex.value) {
      viewController.animateToPage(
        index,
        duration: Durations.n100Millis,
        curve: Curves.easeInOutCubic,
      );
      Storage.instance.setInt(StorageKeys.homeView.name, index);
    }
    currentIndex.value = index;
  }
}
