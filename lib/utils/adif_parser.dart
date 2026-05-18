class AdifParser {
  static Map<String, int> countByField(String adif, String field) {
    final Map<String, int> counts = {};
    final regex = RegExp('<$field:\\d+>([^<]+)', caseSensitive: false);
    final matches = regex.allMatches(adif);

    for (var match in matches) {
      final value = match.group(1)?.trim().toUpperCase();
      if (value != null) {
        counts[value] = (counts[value] ?? 0) + 1;
      }
    }
    return counts;
  }

  static int countConfirmed(String adif) {
    // QRZ uses APP_QRZLOG_STATUS or QSL_RCVD
    final regex = RegExp('<QSL_RCVD:1>Y', caseSensitive: false);
    return regex.allMatches(adif).length;
  }
}
