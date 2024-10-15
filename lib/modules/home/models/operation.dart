import 'dart:convert';

class Operation {
  late final String tag;
  late final num quantity;
  late final num price;
  late final DateTime date;

  Operation.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    tag = map['tag'];
    quantity = map['quantity'];
    price = map['price'];
    date = DateTime.parse(map['date']);
  }

  String toJson() {
    return jsonEncode({
      'tag': tag,
      'quantity': quantity,
      'price': price,
      'date': date.toIso8601String(),
    });
  }
}
