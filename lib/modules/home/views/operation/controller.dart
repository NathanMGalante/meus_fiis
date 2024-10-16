import 'package:dio/dio.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:meus_fiis/modules/home/controller.dart';
import 'package:meus_fiis/modules/home/models/operation.dart';
import 'package:meus_fiis/modules/home/models/operation_type.dart';
import 'package:meus_fiis/shared/custom_dio.dart';

class OperationController extends GetxController {
  List<Operation> get operations => Get.find<HomeController>().operations;

  final RxString tag = ''.obs;
  final Rx<OperationType?> type = null.obs;
  final Rx<DateTime?> operationTime = null.obs;
  final Rx<num> quantity = 0.obs;
  final Rx<num> price = 0.obs;

  void addOperation() {
    final operation = Operation(
      tag: tag.value,
      operationType: type.value!,
      operationDateTime: operationTime.value!,
      quantity: quantity.value,
      price: price.value,
    );
    Get.find<HomeController>().operations.add(operation);
    Get.back();
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
