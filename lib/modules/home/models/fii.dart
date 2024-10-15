import 'dart:convert';

import 'package:meus_fiis/modules/home/models/operation.dart';

class Fii {
  late final String tag;
  late final List<Operation> operations;
  bool isDeleted = false;

  Fii(this.tag) : operations = <Operation>[];

  Fii.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    tag = map['tag'];
    operations = (map['operations'] as List<String>)
        .map((operationJson) => Operation.fromJson(operationJson))
        .toList();
    isDeleted = map['isDeleted'] ?? false;
  }

  String toJson() {
    return jsonEncode({
      'tag': tag,
      'operations': operations.map((operation) => operation.toJson()).toList(),
      'isDeleted': isDeleted,
    });
  }
}
