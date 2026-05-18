class AdifParser {
  static List<Map<String, String>> parse(String adif) {
    print('DEBUG: ADIF length to parse: ${adif.length}');
    final List<Map<String, String>> records = [];
    final recordsRaw = adif.split(RegExp('<EOR>', caseSensitive: false));
    print('DEBUG: Found ${recordsRaw.length} raw record parts');

    for (var rawRecord in recordsRaw) {
      if (rawRecord.trim().isEmpty) continue;
      
      final Map<String, String> record = {};
      final tagRegex = RegExp('<([^:]+):(\\d+)>([^<]*)', caseSensitive: false);
      final matches = tagRegex.allMatches(rawRecord);

      for (var match in matches) {
        final tag = match.group(1)?.toUpperCase();
        final length = int.tryParse(match.group(2) ?? '0') ?? 0;
        var value = match.group(3) ?? '';
        
        if (value.length > length) {
          value = value.substring(0, length);
        }

        if (tag != null) {
          record[tag] = value.trim();
        }
      }

      if (record.containsKey('CALL')) {
        records.add(record);
      }
    }
    print('DEBUG: Successfully parsed ${records.length} records with CALL tag');
    return records;
  }

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
}
