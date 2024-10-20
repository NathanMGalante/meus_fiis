import 'dart:convert';

String mapToBase64<KeyType, ValueType>(Map<KeyType, ValueType> map) {
  String jsonString = jsonEncode(map);
  List<int> jsonBytes = utf8.encode(jsonString);
  return base64Encode(jsonBytes);
}

Map<KeyType, ValueType> base64ToMap<KeyType, ValueType>(String base64String) {
  List<int> decodedBytes = base64Decode(base64String);
  String jsonString = utf8.decode(decodedBytes);
  return jsonDecode(jsonString);
}
