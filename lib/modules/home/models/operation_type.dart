import 'package:get/get.dart';
import 'package:meus_fiis/shared/in18.dart';

enum OperationType { buy, sell }

extension OperationTypeExtension on OperationType {
  String get text {
    return {
      OperationType.buy.name: In18.operationTypeBuyText.name.tr,
      OperationType.sell.name: In18.operationTypeSellText.name.tr,
    }[name]!;
  }
}
