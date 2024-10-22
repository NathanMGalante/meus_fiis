import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:meus_fiis/modules/home/models/operation.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_durations.dart';
import 'package:meus_fiis/shared/storage.dart';

class HomeController extends GetxController {
  late final PageController viewController;
  late final RxInt currentIndex;
  final RxList<Operation> operations = <Operation>[].obs;

  RxMap<String, List<Operation>> get wallet {
    RxMap<String, List<Operation>> map = <String, List<Operation>>{}.obs;
    for (var operation in operations) {
      if (map[operation.tag] == null) {
        map[operation.tag] = [operation];
      } else {
        map[operation.tag]!.add(operation);
      }
    }
    return map;
  }

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
    final savedOperations = Storage.instance.getStringList(
      StorageKeys.operations.name,
    );
    if (savedOperations != null && savedOperations.isNotEmpty) {
      operations.clear();
      operations.addAll(
        savedOperations.map((json) => Operation.fromJson(json)).toList(),
      );
    }
  }

  void changeView(int index) {
    if (index != currentIndex.value) {
      viewController.animateToPage(
        index,
        duration: NDurations.n100Millis,
        curve: Curves.easeInOutCubic,
      );
      Storage.instance.setInt(StorageKeys.homeView.name, index);
    }
    currentIndex.value = index;
  }
}
