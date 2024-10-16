import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:meus_fiis/modules/home/models/operation.dart';
import 'package:meus_fiis/modules/home/models/operation_type.dart';
import 'package:meus_fiis/shared/custom_dio.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_durations.dart';
import 'package:meus_fiis/shared/storage.dart';

class HomeController extends GetxController {
  late final PageController viewController;
  late final RxInt currentIndex;
  final RxList<Operation> _operations = <Operation>[
    Operation(
      tag: 'BIME11',
      operationType: OperationType.buy,
      operationDateTime: DateTime.now(),
      quantity: 452,
      price: 7.26,
    ),
  ].obs;

  RxList<Operation> get operations => _operations;

  RxMap<String, List<Operation>> get wallet {
    RxMap<String, List<Operation>> map = <String, List<Operation>>{}.obs;
    for (var operation in _operations) {
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
      _operations.clear();
      _operations.addAll(
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

  Future<List<String>> search(String searchText) async {
    final response = await CustomDio.public.post(
      "https://www.infomoney.com.br/wp-admin/admin-ajax.php",
      data: FormData.fromMap({
        "search[term]": searchText,
        "action": "archive_cotacoes_by_search",
        "quotes_archive_nonce": "7abafe716d"
      }),
    );
    final list = <String>[];
    final data = response.data as List<Map<String, dynamic>>;
    for (var map in data) {
      final text = map['text'] as String;
      if (text.toUpperCase().contains(searchText.toUpperCase())) {
        final link = map['link'] as String;
        final split = link.split('/');
        final tag = split[split.length - 2].split('-').last.toUpperCase();
        list.add(tag);
      }
    }
    return list;
  }
}
