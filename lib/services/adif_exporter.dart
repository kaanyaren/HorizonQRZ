import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../services/adif_generator.dart';

class AdifExporter {
  /// Export a list of QSOs as an ADIF file
  static Future<void> exportAndShare({
    required List<Qso> qsos,
    required AppSettings settings,
    String? contestId,
    String? stationCallsign,
  }) async {
    final adif = AdifGenerator.generateFromQsos(qsos, settings,
        contestId: contestId);

    // Write to temp file
    final dir = await getTemporaryDirectory();
    final filename = _generateFilename(stationCallsign ?? 'log', contestId);
    final file = File('${dir.path}/$filename.adi');
    await file.writeAsString(adif);

    // TODO: Share via system share sheet (requires share_plus package)
    // await Share.shareXFiles([XFile(file.path)], text: 'Log Summit ADIF Export');
  }

  static String _generateFilename(String callsign, String? contestId) {
    final date = DateTime.now().toUtc().toIso8601String().split('T')[0];
    final contest = contestId ?? 'ALL';
    final safeCallsign = callsign.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toUpperCase();
    return '${safeCallsign}_${contest}_$date';
  }
}
