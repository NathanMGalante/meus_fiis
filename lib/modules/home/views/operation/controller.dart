import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:meus_fiis/modules/home/controller.dart';
import 'package:meus_fiis/modules/home/models/operation.dart';
import 'package:meus_fiis/modules/home/models/operation_type.dart';
import 'package:meus_fiis/shared/custom_dio.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_base64.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_debounce.dart';

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

  Future<List<String>> search({
    required String searchText,
    required int page,
    required int pageSize,
  }) async {
    return NDebounce.run<List<String>>('searchNewFii', () async {
      final map = {
        "typeFund": 7,
        "pageNumber": page,
        "pageSize": pageSize,
        "keyword": searchText
      };
      final response = await CustomDio.public.get(
        'https://sistemaswebb3-listados.b3.com.br/fundsProxy/fundsCall/GetListedFundsSIG/${mapToBase64(map)}',
      );
      final results = response.data['results'] as List;
      return results.map((map) => '${map['acronym']}11').toList();
    });
  }
}
