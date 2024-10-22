import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:meus_fiis/modules/home/controller.dart';
import 'package:meus_fiis/modules/home/models/operation.dart';
import 'package:meus_fiis/modules/home/models/operation_type.dart';
import 'package:meus_fiis/shared/custom_dio.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_base64.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_debounce.dart';
import 'package:meus_fiis/shared/storage.dart';

enum OperationIds { view }

class OperationController extends GetxController {
  List<Operation> get operations => Get.find<HomeController>().operations;

  Future<void> addOperation({
    required String tag,
    required OperationType type,
    required DateTime operationTime,
    required num quantity,
    required num price,
  }) async {
    final operation = Operation(
      tag: tag,
      operationType: type,
      operationDateTime: operationTime,
      quantity: quantity,
      price: price,
    );
    operations.add(operation);

    await _save();

    Get.back();
    update([OperationIds.view.name]);
  }

  Future<void> removeOperation(Operation operation) async {
    operations.remove(operation);
    await _save();
    update([OperationIds.view.name]);
  }

  Future<void> _save() async {
    await Storage.instance.setStringList(
      StorageKeys.operations.name,
      operations.map((operation) => operation.toJson()).toList(),
    );
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
        "keyword": searchText.trim().toUpperCase()
      };
      final response = await CustomDio.public.get(
        'https://sistemaswebb3-listados.b3.com.br/fundsProxy/fundsCall/GetListedFundsSIG/${mapToBase64(map)}',
      );
      final results = response.data['results'] as List;
      return results.map((map) => '${map['acronym']}11').toList();
    });
  }
}
