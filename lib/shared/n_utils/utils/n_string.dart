extension StringExtension on String {
  List<String> nSplitFirstWord(String word, [bool caseSensitive = false]) {
    String original = this;
    String normalized = nNormalize.toUpperCase();
    String wordNormalized = word.nNormalize.toUpperCase();

    int index = caseSensitive
        ? original.indexOf(word)
        : normalized.indexOf(wordNormalized);
    if (index != -1) {
      return [
        original.substring(0, index),
        original.substring(index, index + word.length),
        original.substring(index + word.length),
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
