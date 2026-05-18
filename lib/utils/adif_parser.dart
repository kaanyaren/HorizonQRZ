class AdifParser {
  static List<Map<String, String>> parse(String adif) {
    print('DEBUG: ADIF length to parse: ${adif.length}');
    if (adif.length > 200) {
      print('DEBUG: ADIF Start: ${adif.substring(0, 200)}');
    } else {
      print('DEBUG: ADIF content: $adif');
    }

    // 0. Decode HTML entities if present (QRZ API sometimes returns &lt; instead of <)
    if (adif.contains('&lt;') || adif.contains('&gt;')) {
      print('DEBUG: Decoding HTML entities in ADIF');
      adif = adif
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>')
          .replaceAll('&amp;', '&')
          .replaceAll('&quot;', '"')
          .replaceAll('&#39;', "'");
    }

    print('DEBUG: ADIF length to parse: ${adif.length}');
    final List<Map<String, String>> records = [];
    
    // 1. Split by <EOR> (case-insensitive)
    var recordsRaw = adif.split(RegExp(r'<EOR>', caseSensitive: false));
    
    // 1b. If we only found 1 part for a large file, the delimiter might be missing.
    // QRZ sometimes just concatenates records. Let's try to split by <CALL:
    if (recordsRaw.length <= 1 && adif.contains(RegExp(r'<CALL:', caseSensitive: false))) {
      print('DEBUG: No <EOR> found, splitting by <CALL:');
      // We use a positive lookahead to split *before* the next <CALL:
      recordsRaw = adif.split(RegExp(r'(?=<CALL:)', caseSensitive: false));
    }
    
    print('DEBUG: Found ${recordsRaw.length} raw record parts');

    for (var rawRecord in recordsRaw) {
      if (rawRecord.trim().isEmpty) continue;
      
      final Map<String, String> record = {};
      
      // 2. Extract all tags: <TAG:LEN> or <TAG:LEN:TYPE>
      final tagRegex = RegExp(r'<([^:]+):(\d+)(?::[^>]+)?>', caseSensitive: false);
      final matches = tagRegex.allMatches(rawRecord).toList();

      for (int i = 0; i < matches.length; i++) {
        final match = matches[i];
        final tag = match.group(1)?.toUpperCase();
        final length = int.tryParse(match.group(2) ?? '0') ?? 0;
        
        final valueStart = match.end;
        String value;
        
        // Use the length explicitly as defined in ADIF standard
        if (valueStart + length <= rawRecord.length) {
          value = rawRecord.substring(valueStart, valueStart + length);
        } else {
          // Fallback if the string is shorter than expected (shouldn't happen in valid ADIF)
          value = rawRecord.substring(valueStart);
        }

        if (tag != null) {
          record[tag] = value; // Don't trim yet, ADIF values can have spaces
        }
      }

      // 3. Post-process: Trim values after extraction
      record.forEach((key, value) {
        record[key] = value.trim();
      });

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
