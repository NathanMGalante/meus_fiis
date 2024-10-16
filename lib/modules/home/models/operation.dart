import 'dart:convert';

import 'package:meus_fiis/modules/home/models/operation_type.dart';

class Operation {
  late final String tag;
  late final OperationType operationType;
  late final DateTime operationDateTime;
  late final num quantity;
  late final num price;
  late final DateTime creationDateTime;

  Operation({
    required this.tag,
    required this.operationType,
    required this.operationDateTime,
    required this.quantity,
    required this.price,
  }) : creationDateTime = DateTime.now();

  Operation.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    tag = map['tag'];
    operationType = OperationType.values.byName(map['operationType']);
    operationDateTime = DateTime.parse(map['operationDateTime']);
    quantity = map['quantity'];
    price = map['price'];
    creationDateTime = DateTime.parse(map['creationDateTime']);
  }

  String toJson() {
    return jsonEncode({
      'tag': tag,
      'operationType': operationType.name,
      'operationDateTime': operationDateTime.toIso8601String(),
      'quantity': quantity,
      'price': price,
      'creationDateTime': creationDateTime.toIso8601String(),
    });
  }
}
