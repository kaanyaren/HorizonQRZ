class Qso {
  final String id;
  final String userUuid;
  final String supabaseId;
  final String callsign;
  final DateTime qsoDate;
  final DateTime timeOn;
  final String band;
  final String mode;
  final String? freq;
  final String? rstSent;
  final String? rstRcvd;
  final String? name;
  final String? qth;
  final String? country;
  final String? gridsquare;
  final String? lat;
  final String? lon;
  final String? comment;
  final String? propMode;
  final String? satName;
  final String? txPwr;
  final String? mySig;
  final String? sig;
  final String? state;
  final String? cqz;
  final String? contestId;
  final String? stx;
  final String? srx;
  final String? stxString;
  final String? srxString;
  final String? stationCallsign;
  final String? stationGridsquare;
  final String? operator;
  final String syncStatus;
  final int syncVersion;

  Qso({
    required this.id,
    required this.userUuid,
    required this.supabaseId,
    required this.callsign,
    required this.qsoDate,
    required this.timeOn,
    required this.band,
    required this.mode,
    this.freq,
    this.rstSent,
    this.rstRcvd,
    this.name,
    this.qth,
    this.country,
    this.gridsquare,
    this.lat,
    this.lon,
    this.comment,
    this.propMode,
    this.satName,
    this.txPwr,
    this.mySig,
    this.sig,
    this.state,
    this.cqz,
    this.contestId,
    this.stx,
    this.srx,
    this.stxString,
    this.srxString,
    this.stationCallsign,
    this.stationGridsquare,
    this.operator,
    this.syncStatus = 'synced',
    this.syncVersion = 0,
  });

  factory Qso.fromMap(Map<String, dynamic> map) {
    return Qso(
      id: map['id'] as String,
      userUuid: map['user_id'] as String,
      supabaseId: map['id'] as String,
      callsign: map['callsign'] as String,
      qsoDate: DateTime.parse(map['qso_date'] as String),
      timeOn: DateTime.parse(map['time_on'] as String),
      band: map['band'] as String,
      mode: map['mode'] as String,
      freq: map['freq'] as String?,
      rstSent: map['rst_sent'] as String?,
      rstRcvd: map['rst_rcvd'] as String?,
      name: map['name'] as String?,
      qth: map['qth'] as String?,
      country: map['country'] as String?,
      gridsquare: map['gridsquare'] as String?,
      lat: map['lat'] as String?,
      lon: map['lon'] as String?,
      comment: map['comment'] as String?,
      propMode: map['prop_mode'] as String?,
      satName: map['sat_name'] as String?,
      txPwr: map['tx_pwr'] as String?,
      mySig: map['my_sig'] as String?,
      sig: map['sig'] as String?,
      state: map['state'] as String?,
      cqz: map['cq_zone'] as String?,
      contestId: map['contest_id'] as String?,
      stx: map['stx'] as String?,
      srx: map['srx'] as String?,
      stxString: map['stx_string'] as String?,
      srxString: map['srx_string'] as String?,
      stationCallsign: map['station_callsign'] as String?,
      stationGridsquare: map['station_gridsquare'] as String?,
      operator: map['operator'] as String?,
      syncStatus: map['sync_status'] as String? ?? 'synced',
      syncVersion: map['sync_version'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userUuid,
      'supabaseId': supabaseId,
      'callsign': callsign,
      'qso_date': qsoDate.toIso8601String(),
      'time_on': timeOn.toIso8601String(),
      'band': band,
      'mode': mode,
      'freq': freq,
      'rst_sent': rstSent,
      'rst_rcvd': rstRcvd,
      'name': name,
      'qth': qth,
      'country': country,
      'gridsquare': gridsquare,
      'lat': lat,
      'lon': lon,
      'comment': comment,
      'prop_mode': propMode,
      'sat_name': satName,
      'tx_pwr': txPwr,
      'my_sig': mySig,
      'sig': sig,
      'state': state,
      'cq_zone': cqz,
      'stx': stx,
      'srx': srx,
      'stx_string': stxString,
      'srx_string': srxString,
      'station_callsign': stationCallsign,
      'sync_status': syncStatus,
      'sync_version': syncVersion,
    };
  }
}

class AppSettings {
  final String? callsign;
  final String? operatorName;
  final String? gridSquare;
  final String? cqZone;
  final String? ituZone;
  final String? state;
  final String? country;
  final String? defaultBand;
  final String? defaultMode;
  final String? defaultPower;

  AppSettings({
    this.callsign,
    this.operatorName,
    this.gridSquare,
    this.cqZone,
    this.ituZone,
    this.state,
    this.country,
    this.defaultBand,
    this.defaultMode,
    this.defaultPower,
  });

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      callsign: map['callsign'] as String?,
      operatorName: map['operator_name'] as String?,
      gridSquare: map['station_gridsquare'] as String?,
      cqZone: map['cq_zone'] as String?,
      ituZone: map['itu_zone'] as String?,
      state: map['state'] as String?,
      country: map['country'] as String?,
      defaultBand: map['default_band'] as String?,
      defaultMode: map['default_mode'] as String?,
      defaultPower: map['default_power'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'callsign': callsign,
      'operator_name': operatorName,
      'station_gridsquare': gridSquare,
      'cq_zone': cqZone,
      'itu_zone': ituZone,
      'state': state,
      'country': country,
      'default_band': defaultBand,
      'default_mode': defaultMode,
      'default_power': defaultPower,
    };
  }
}

class AdifGenerator {
  static final String _header = 'Log Summit ADIF Export';

  static String generateQso(Qso qso, AppSettings settings) {
    final callsign = _pad(qso.callsign, 6);
    final date = _pad(qso.qsoDate.toIso8601String().substring(0, 8), 8);
    final time = _pad(qso.timeOn.toIso8601String().substring(0, 6), 6);
    final band = _pad(qso.band, 3);
    final mode = _pad(qso.mode, 2);
    final freq = _pad(qso.freq ?? '', 8);
    final rstSent = _pad(qso.rstSent ?? '', 3);
    final rstRcvd = _pad(qso.rstRcvd ?? '', 3);
    final name = _pad(qso.name ?? '', 30);
    final qth = _pad(qso.qth ?? '', 30);
    final country = _pad(qso.country ?? '', 2);
    final gridsquare = _pad(qso.gridsquare ?? '', 6);
    final cqz = _pad(qso.cqz ?? '', 2);
    final state = _pad(qso.state ?? '', 2);
    final stationCallsign = _pad(qso.stationCallsign ?? '', 6);
    final operator = _pad(qso.operator ?? '', 6);
    final stx = _pad(qso.stx ?? '', 3);
    final srx = _pad(qso.srx ?? '', 3);
    final stxString = _pad(qso.stxString ?? '', 6);
    final srxString = _pad(qso.srxString ?? '', 6);
    final contestId = _pad(qso.contestId ?? '', 8);

    final lines = [
      '<CALL:$callsign>$callsign',
      '<QSO_DATE:$date>$date',
      '<TIME_ON:$time>$time',
      '<BAND:$band>$band',
      '<MODE:$mode>$mode',
      '<FREQ:$freq>$freq',
      '<RST_SENT:$rstSent>$rstSent',
      '<RST_RCVD:$rstRcvd>$rstRcvd',
      '<NAME:$name>$name',
      '<QTH:$qth>$qth',
      '<COUNTRY:$country>$country',
      '<GRIDSQUARE:$gridsquare>$gridsquare',
      '<CQZ:$cqz>$cqz',
      '<STATE:$state>$state',
      '<STATION_CALLSIGN:$stationCallsign>$stationCallsign',
      '<OPERATOR:$operator>$operator',
      '<STX:$stx>$stx',
      '<SRX:$srx>$srx',
      '<STX_STRING:$stxString>$stxString',
      '<SRX_STRING:$srxString>$srxString',
      '<CONTEST_ID:$contestId>$contestId',
      '<EOR>',
    ];

    return lines.join('\r\n');
  }

  static String generateFromQsos(List<Qso> qsos, AppSettings settings,
      {String? contestId, String? stationCallsign, String? operator}) {
    final lines = [
      _header,
      ...qsos.map((qso) {
        final stationCallsignField = stationCallsign ?? qso.stationCallsign;
        final operatorField = operator ?? qso.operator;

        return '<STATION_CALLSIGN:${_pad(stationCallsignField, 6)}>${_pad(stationCallsignField, 6)}\r\n'
            '<OPERATOR:${_pad(operatorField, 6)}>${_pad(operatorField, 6)}\r\n'
            '${generateQso(qso, settings)}';
      }),
    ];

    return lines.join('\r\n');
  }

  static String generateContestAdif(List<Qso> qsos, AppSettings settings,
      {required String contestId, String? stationCallsign, String? operator}) {
    final lines = [
      _header,
      '<CONTEST_ID:$contestId>$contestId',
      ...qsos.map((qso) {
        final stationCallsignField = stationCallsign ?? qso.stationCallsign;
        final operatorField = operator ?? qso.operator;

        return '<STATION_CALLSIGN:${_pad(stationCallsignField, 6)}>${_pad(stationCallsignField, 6)}\r\n'
            '<OPERATOR:${_pad(operatorField, 6)}>${_pad(operatorField, 6)}\r\n'
            '${generateQso(qso, settings)}';
      }),
    ];

    return lines.join('\r\n');
  }

  static String _pad(String? value, int length) {
    return (value ?? '').padRight(length, ' ');
  }
}
