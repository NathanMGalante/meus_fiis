extension StringExtension on String {
  List<String> nSplitFirstWord(String word, [bool caseSensitive = false]) {
    int index = caseSensitive
        ? indexOf(word.trim())
        : nNormalize.toUpperCase().indexOf(word.trim().nNormalize.toUpperCase());
    if (index != -1) {
      return [
        substring(0, index),
        substring(index, index + word.trim().length),
        substring(index + word.trim().length),
      ];
    }
    throw 'Not found';
  }

  String get nNormalize {
    String str = this;
    var comAcento =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutAccents =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (int i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], withoutAccents[i]);
    }
    return str;
  }
}
