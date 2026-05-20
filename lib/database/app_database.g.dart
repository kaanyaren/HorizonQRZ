// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalQsosTable extends LocalQsos
    with TableInfo<$LocalQsosTable, LocalQso> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalQsosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _callsignMeta = const VerificationMeta(
    'callsign',
  );
  @override
  late final GeneratedColumn<String> callsign = GeneratedColumn<String>(
    'callsign',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qsoDateMeta = const VerificationMeta(
    'qsoDate',
  );
  @override
  late final GeneratedColumn<DateTime> qsoDate = GeneratedColumn<DateTime>(
    'qso_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeOnMeta = const VerificationMeta('timeOn');
  @override
  late final GeneratedColumn<String> timeOn = GeneratedColumn<String>(
    'time_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bandMeta = const VerificationMeta('band');
  @override
  late final GeneratedColumn<String> band = GeneratedColumn<String>(
    'band',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _freqMeta = const VerificationMeta('freq');
  @override
  late final GeneratedColumn<String> freq = GeneratedColumn<String>(
    'freq',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rstSentMeta = const VerificationMeta(
    'rstSent',
  );
  @override
  late final GeneratedColumn<String> rstSent = GeneratedColumn<String>(
    'rst_sent',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rstRcvdMeta = const VerificationMeta(
    'rstRcvd',
  );
  @override
  late final GeneratedColumn<String> rstRcvd = GeneratedColumn<String>(
    'rst_rcvd',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qthMeta = const VerificationMeta('qth');
  @override
  late final GeneratedColumn<String> qth = GeneratedColumn<String>(
    'qth',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gridsquareMeta = const VerificationMeta(
    'gridsquare',
  );
  @override
  late final GeneratedColumn<String> gridsquare = GeneratedColumn<String>(
    'gridsquare',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<String> lat = GeneratedColumn<String>(
    'lat',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<String> lon = GeneratedColumn<String>(
    'lon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _propModeMeta = const VerificationMeta(
    'propMode',
  );
  @override
  late final GeneratedColumn<String> propMode = GeneratedColumn<String>(
    'prop_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _satNameMeta = const VerificationMeta(
    'satName',
  );
  @override
  late final GeneratedColumn<String> satName = GeneratedColumn<String>(
    'sat_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _txPwrMeta = const VerificationMeta('txPwr');
  @override
  late final GeneratedColumn<String> txPwr = GeneratedColumn<String>(
    'tx_pwr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mySigMeta = const VerificationMeta('mySig');
  @override
  late final GeneratedColumn<String> mySig = GeneratedColumn<String>(
    'my_sig',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sigMeta = const VerificationMeta('sig');
  @override
  late final GeneratedColumn<String> sig = GeneratedColumn<String>(
    'sig',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cqzMeta = const VerificationMeta('cqz');
  @override
  late final GeneratedColumn<String> cqz = GeneratedColumn<String>(
    'cqz',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contestIdMeta = const VerificationMeta(
    'contestId',
  );
  @override
  late final GeneratedColumn<String> contestId = GeneratedColumn<String>(
    'contest_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stxMeta = const VerificationMeta('stx');
  @override
  late final GeneratedColumn<String> stx = GeneratedColumn<String>(
    'stx',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _srxMeta = const VerificationMeta('srx');
  @override
  late final GeneratedColumn<String> srx = GeneratedColumn<String>(
    'srx',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stxStringMeta = const VerificationMeta(
    'stxString',
  );
  @override
  late final GeneratedColumn<String> stxString = GeneratedColumn<String>(
    'stx_string',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _srxStringMeta = const VerificationMeta(
    'srxString',
  );
  @override
  late final GeneratedColumn<String> srxString = GeneratedColumn<String>(
    'srx_string',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stationCallsignMeta = const VerificationMeta(
    'stationCallsign',
  );
  @override
  late final GeneratedColumn<String> stationCallsign = GeneratedColumn<String>(
    'station_callsign',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stationGridsquareMeta = const VerificationMeta(
    'stationGridsquare',
  );
  @override
  late final GeneratedColumn<String> stationGridsquare =
      GeneratedColumn<String>(
        'station_gridsquare',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _operatorMeta = const VerificationMeta(
    'operator',
  );
  @override
  late final GeneratedColumn<String> operator = GeneratedColumn<String>(
    'operator',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userUuidMeta = const VerificationMeta(
    'userUuid',
  );
  @override
  late final GeneratedColumn<String> userUuid = GeneratedColumn<String>(
    'user_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supabaseIdMeta = const VerificationMeta(
    'supabaseId',
  );
  @override
  late final GeneratedColumn<String> supabaseId = GeneratedColumn<String>(
    'supabase_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qrzLogIdMeta = const VerificationMeta(
    'qrzLogId',
  );
  @override
  late final GeneratedColumn<String> qrzLogId = GeneratedColumn<String>(
    'qrz_log_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncVersionMeta = const VerificationMeta(
    'syncVersion',
  );
  @override
  late final GeneratedColumn<int> syncVersion = GeneratedColumn<int>(
    'sync_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    callsign,
    qsoDate,
    timeOn,
    band,
    mode,
    freq,
    rstSent,
    rstRcvd,
    name,
    qth,
    country,
    gridsquare,
    lat,
    lon,
    comment,
    propMode,
    satName,
    txPwr,
    mySig,
    sig,
    state,
    cqz,
    contestId,
    stx,
    srx,
    stxString,
    srxString,
    stationCallsign,
    stationGridsquare,
    operator,
    userUuid,
    supabaseId,
    qrzLogId,
    syncVersion,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_qsos';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalQso> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('callsign')) {
      context.handle(
        _callsignMeta,
        callsign.isAcceptableOrUnknown(data['callsign']!, _callsignMeta),
      );
    } else if (isInserting) {
      context.missing(_callsignMeta);
    }
    if (data.containsKey('qso_date')) {
      context.handle(
        _qsoDateMeta,
        qsoDate.isAcceptableOrUnknown(data['qso_date']!, _qsoDateMeta),
      );
    } else if (isInserting) {
      context.missing(_qsoDateMeta);
    }
    if (data.containsKey('time_on')) {
      context.handle(
        _timeOnMeta,
        timeOn.isAcceptableOrUnknown(data['time_on']!, _timeOnMeta),
      );
    } else if (isInserting) {
      context.missing(_timeOnMeta);
    }
    if (data.containsKey('band')) {
      context.handle(
        _bandMeta,
        band.isAcceptableOrUnknown(data['band']!, _bandMeta),
      );
    } else if (isInserting) {
      context.missing(_bandMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('freq')) {
      context.handle(
        _freqMeta,
        freq.isAcceptableOrUnknown(data['freq']!, _freqMeta),
      );
    }
    if (data.containsKey('rst_sent')) {
      context.handle(
        _rstSentMeta,
        rstSent.isAcceptableOrUnknown(data['rst_sent']!, _rstSentMeta),
      );
    }
    if (data.containsKey('rst_rcvd')) {
      context.handle(
        _rstRcvdMeta,
        rstRcvd.isAcceptableOrUnknown(data['rst_rcvd']!, _rstRcvdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('qth')) {
      context.handle(
        _qthMeta,
        qth.isAcceptableOrUnknown(data['qth']!, _qthMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('gridsquare')) {
      context.handle(
        _gridsquareMeta,
        gridsquare.isAcceptableOrUnknown(data['gridsquare']!, _gridsquareMeta),
      );
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('prop_mode')) {
      context.handle(
        _propModeMeta,
        propMode.isAcceptableOrUnknown(data['prop_mode']!, _propModeMeta),
      );
    }
    if (data.containsKey('sat_name')) {
      context.handle(
        _satNameMeta,
        satName.isAcceptableOrUnknown(data['sat_name']!, _satNameMeta),
      );
    }
    if (data.containsKey('tx_pwr')) {
      context.handle(
        _txPwrMeta,
        txPwr.isAcceptableOrUnknown(data['tx_pwr']!, _txPwrMeta),
      );
    }
    if (data.containsKey('my_sig')) {
      context.handle(
        _mySigMeta,
        mySig.isAcceptableOrUnknown(data['my_sig']!, _mySigMeta),
      );
    }
    if (data.containsKey('sig')) {
      context.handle(
        _sigMeta,
        sig.isAcceptableOrUnknown(data['sig']!, _sigMeta),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('cqz')) {
      context.handle(
        _cqzMeta,
        cqz.isAcceptableOrUnknown(data['cqz']!, _cqzMeta),
      );
    }
    if (data.containsKey('contest_id')) {
      context.handle(
        _contestIdMeta,
        contestId.isAcceptableOrUnknown(data['contest_id']!, _contestIdMeta),
      );
    }
    if (data.containsKey('stx')) {
      context.handle(
        _stxMeta,
        stx.isAcceptableOrUnknown(data['stx']!, _stxMeta),
      );
    }
    if (data.containsKey('srx')) {
      context.handle(
        _srxMeta,
        srx.isAcceptableOrUnknown(data['srx']!, _srxMeta),
      );
    }
    if (data.containsKey('stx_string')) {
      context.handle(
        _stxStringMeta,
        stxString.isAcceptableOrUnknown(data['stx_string']!, _stxStringMeta),
      );
    }
    if (data.containsKey('srx_string')) {
      context.handle(
        _srxStringMeta,
        srxString.isAcceptableOrUnknown(data['srx_string']!, _srxStringMeta),
      );
    }
    if (data.containsKey('station_callsign')) {
      context.handle(
        _stationCallsignMeta,
        stationCallsign.isAcceptableOrUnknown(
          data['station_callsign']!,
          _stationCallsignMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stationCallsignMeta);
    }
    if (data.containsKey('station_gridsquare')) {
      context.handle(
        _stationGridsquareMeta,
        stationGridsquare.isAcceptableOrUnknown(
          data['station_gridsquare']!,
          _stationGridsquareMeta,
        ),
      );
    }
    if (data.containsKey('operator')) {
      context.handle(
        _operatorMeta,
        operator.isAcceptableOrUnknown(data['operator']!, _operatorMeta),
      );
    }
    if (data.containsKey('user_uuid')) {
      context.handle(
        _userUuidMeta,
        userUuid.isAcceptableOrUnknown(data['user_uuid']!, _userUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_userUuidMeta);
    }
    if (data.containsKey('supabase_id')) {
      context.handle(
        _supabaseIdMeta,
        supabaseId.isAcceptableOrUnknown(data['supabase_id']!, _supabaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supabaseIdMeta);
    }
    if (data.containsKey('qrz_log_id')) {
      context.handle(
        _qrzLogIdMeta,
        qrzLogId.isAcceptableOrUnknown(data['qrz_log_id']!, _qrzLogIdMeta),
      );
    }
    if (data.containsKey('sync_version')) {
      context.handle(
        _syncVersionMeta,
        syncVersion.isAcceptableOrUnknown(
          data['sync_version']!,
          _syncVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_syncVersionMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LocalQso map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalQso(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      callsign: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}callsign'],
      )!,
      qsoDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}qso_date'],
      )!,
      timeOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_on'],
      )!,
      band: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}band'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      freq: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}freq'],
      ),
      rstSent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rst_sent'],
      ),
      rstRcvd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rst_rcvd'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      qth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qth'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      gridsquare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gridsquare'],
      ),
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lat'],
      ),
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lon'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      propMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prop_mode'],
      ),
      satName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sat_name'],
      ),
      txPwr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tx_pwr'],
      ),
      mySig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}my_sig'],
      ),
      sig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sig'],
      ),
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      ),
      cqz: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cqz'],
      ),
      contestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contest_id'],
      ),
      stx: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stx'],
      ),
      srx: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}srx'],
      ),
      stxString: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stx_string'],
      ),
      srxString: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}srx_string'],
      ),
      stationCallsign: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station_callsign'],
      )!,
      stationGridsquare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station_gridsquare'],
      ),
      operator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operator'],
      ),
      userUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uuid'],
      )!,
      supabaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supabase_id'],
      )!,
      qrzLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qrz_log_id'],
      ),
      syncVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalQsosTable createAlias(String alias) {
    return $LocalQsosTable(attachedDatabase, alias);
  }
}

class LocalQso extends DataClass implements Insertable<LocalQso> {
  final String id;
  final String callsign;
  final DateTime qsoDate;
  final String timeOn;
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
  final String stationCallsign;
  final String? stationGridsquare;
  final String? operator;
  final String userUuid;
  final String supabaseId;
  final String? qrzLogId;
  final int syncVersion;
  final String syncStatus;
  const LocalQso({
    required this.id,
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
    required this.stationCallsign,
    this.stationGridsquare,
    this.operator,
    required this.userUuid,
    required this.supabaseId,
    this.qrzLogId,
    required this.syncVersion,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['callsign'] = Variable<String>(callsign);
    map['qso_date'] = Variable<DateTime>(qsoDate);
    map['time_on'] = Variable<String>(timeOn);
    map['band'] = Variable<String>(band);
    map['mode'] = Variable<String>(mode);
    if (!nullToAbsent || freq != null) {
      map['freq'] = Variable<String>(freq);
    }
    if (!nullToAbsent || rstSent != null) {
      map['rst_sent'] = Variable<String>(rstSent);
    }
    if (!nullToAbsent || rstRcvd != null) {
      map['rst_rcvd'] = Variable<String>(rstRcvd);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || qth != null) {
      map['qth'] = Variable<String>(qth);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || gridsquare != null) {
      map['gridsquare'] = Variable<String>(gridsquare);
    }
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<String>(lat);
    }
    if (!nullToAbsent || lon != null) {
      map['lon'] = Variable<String>(lon);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || propMode != null) {
      map['prop_mode'] = Variable<String>(propMode);
    }
    if (!nullToAbsent || satName != null) {
      map['sat_name'] = Variable<String>(satName);
    }
    if (!nullToAbsent || txPwr != null) {
      map['tx_pwr'] = Variable<String>(txPwr);
    }
    if (!nullToAbsent || mySig != null) {
      map['my_sig'] = Variable<String>(mySig);
    }
    if (!nullToAbsent || sig != null) {
      map['sig'] = Variable<String>(sig);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || cqz != null) {
      map['cqz'] = Variable<String>(cqz);
    }
    if (!nullToAbsent || contestId != null) {
      map['contest_id'] = Variable<String>(contestId);
    }
    if (!nullToAbsent || stx != null) {
      map['stx'] = Variable<String>(stx);
    }
    if (!nullToAbsent || srx != null) {
      map['srx'] = Variable<String>(srx);
    }
    if (!nullToAbsent || stxString != null) {
      map['stx_string'] = Variable<String>(stxString);
    }
    if (!nullToAbsent || srxString != null) {
      map['srx_string'] = Variable<String>(srxString);
    }
    map['station_callsign'] = Variable<String>(stationCallsign);
    if (!nullToAbsent || stationGridsquare != null) {
      map['station_gridsquare'] = Variable<String>(stationGridsquare);
    }
    if (!nullToAbsent || operator != null) {
      map['operator'] = Variable<String>(operator);
    }
    map['user_uuid'] = Variable<String>(userUuid);
    map['supabase_id'] = Variable<String>(supabaseId);
    if (!nullToAbsent || qrzLogId != null) {
      map['qrz_log_id'] = Variable<String>(qrzLogId);
    }
    map['sync_version'] = Variable<int>(syncVersion);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalQsosCompanion toCompanion(bool nullToAbsent) {
    return LocalQsosCompanion(
      id: Value(id),
      callsign: Value(callsign),
      qsoDate: Value(qsoDate),
      timeOn: Value(timeOn),
      band: Value(band),
      mode: Value(mode),
      freq: freq == null && nullToAbsent ? const Value.absent() : Value(freq),
      rstSent: rstSent == null && nullToAbsent
          ? const Value.absent()
          : Value(rstSent),
      rstRcvd: rstRcvd == null && nullToAbsent
          ? const Value.absent()
          : Value(rstRcvd),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      qth: qth == null && nullToAbsent ? const Value.absent() : Value(qth),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      gridsquare: gridsquare == null && nullToAbsent
          ? const Value.absent()
          : Value(gridsquare),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lon: lon == null && nullToAbsent ? const Value.absent() : Value(lon),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      propMode: propMode == null && nullToAbsent
          ? const Value.absent()
          : Value(propMode),
      satName: satName == null && nullToAbsent
          ? const Value.absent()
          : Value(satName),
      txPwr: txPwr == null && nullToAbsent
          ? const Value.absent()
          : Value(txPwr),
      mySig: mySig == null && nullToAbsent
          ? const Value.absent()
          : Value(mySig),
      sig: sig == null && nullToAbsent ? const Value.absent() : Value(sig),
      state: state == null && nullToAbsent
          ? const Value.absent()
          : Value(state),
      cqz: cqz == null && nullToAbsent ? const Value.absent() : Value(cqz),
      contestId: contestId == null && nullToAbsent
          ? const Value.absent()
          : Value(contestId),
      stx: stx == null && nullToAbsent ? const Value.absent() : Value(stx),
      srx: srx == null && nullToAbsent ? const Value.absent() : Value(srx),
      stxString: stxString == null && nullToAbsent
          ? const Value.absent()
          : Value(stxString),
      srxString: srxString == null && nullToAbsent
          ? const Value.absent()
          : Value(srxString),
      stationCallsign: Value(stationCallsign),
      stationGridsquare: stationGridsquare == null && nullToAbsent
          ? const Value.absent()
          : Value(stationGridsquare),
      operator: operator == null && nullToAbsent
          ? const Value.absent()
          : Value(operator),
      userUuid: Value(userUuid),
      supabaseId: Value(supabaseId),
      qrzLogId: qrzLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(qrzLogId),
      syncVersion: Value(syncVersion),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalQso.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalQso(
      id: serializer.fromJson<String>(json['id']),
      callsign: serializer.fromJson<String>(json['callsign']),
      qsoDate: serializer.fromJson<DateTime>(json['qsoDate']),
      timeOn: serializer.fromJson<String>(json['timeOn']),
      band: serializer.fromJson<String>(json['band']),
      mode: serializer.fromJson<String>(json['mode']),
      freq: serializer.fromJson<String?>(json['freq']),
      rstSent: serializer.fromJson<String?>(json['rstSent']),
      rstRcvd: serializer.fromJson<String?>(json['rstRcvd']),
      name: serializer.fromJson<String?>(json['name']),
      qth: serializer.fromJson<String?>(json['qth']),
      country: serializer.fromJson<String?>(json['country']),
      gridsquare: serializer.fromJson<String?>(json['gridsquare']),
      lat: serializer.fromJson<String?>(json['lat']),
      lon: serializer.fromJson<String?>(json['lon']),
      comment: serializer.fromJson<String?>(json['comment']),
      propMode: serializer.fromJson<String?>(json['propMode']),
      satName: serializer.fromJson<String?>(json['satName']),
      txPwr: serializer.fromJson<String?>(json['txPwr']),
      mySig: serializer.fromJson<String?>(json['mySig']),
      sig: serializer.fromJson<String?>(json['sig']),
      state: serializer.fromJson<String?>(json['state']),
      cqz: serializer.fromJson<String?>(json['cqz']),
      contestId: serializer.fromJson<String?>(json['contestId']),
      stx: serializer.fromJson<String?>(json['stx']),
      srx: serializer.fromJson<String?>(json['srx']),
      stxString: serializer.fromJson<String?>(json['stxString']),
      srxString: serializer.fromJson<String?>(json['srxString']),
      stationCallsign: serializer.fromJson<String>(json['stationCallsign']),
      stationGridsquare: serializer.fromJson<String?>(
        json['stationGridsquare'],
      ),
      operator: serializer.fromJson<String?>(json['operator']),
      userUuid: serializer.fromJson<String>(json['userUuid']),
      supabaseId: serializer.fromJson<String>(json['supabaseId']),
      qrzLogId: serializer.fromJson<String?>(json['qrzLogId']),
      syncVersion: serializer.fromJson<int>(json['syncVersion']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'callsign': serializer.toJson<String>(callsign),
      'qsoDate': serializer.toJson<DateTime>(qsoDate),
      'timeOn': serializer.toJson<String>(timeOn),
      'band': serializer.toJson<String>(band),
      'mode': serializer.toJson<String>(mode),
      'freq': serializer.toJson<String?>(freq),
      'rstSent': serializer.toJson<String?>(rstSent),
      'rstRcvd': serializer.toJson<String?>(rstRcvd),
      'name': serializer.toJson<String?>(name),
      'qth': serializer.toJson<String?>(qth),
      'country': serializer.toJson<String?>(country),
      'gridsquare': serializer.toJson<String?>(gridsquare),
      'lat': serializer.toJson<String?>(lat),
      'lon': serializer.toJson<String?>(lon),
      'comment': serializer.toJson<String?>(comment),
      'propMode': serializer.toJson<String?>(propMode),
      'satName': serializer.toJson<String?>(satName),
      'txPwr': serializer.toJson<String?>(txPwr),
      'mySig': serializer.toJson<String?>(mySig),
      'sig': serializer.toJson<String?>(sig),
      'state': serializer.toJson<String?>(state),
      'cqz': serializer.toJson<String?>(cqz),
      'contestId': serializer.toJson<String?>(contestId),
      'stx': serializer.toJson<String?>(stx),
      'srx': serializer.toJson<String?>(srx),
      'stxString': serializer.toJson<String?>(stxString),
      'srxString': serializer.toJson<String?>(srxString),
      'stationCallsign': serializer.toJson<String>(stationCallsign),
      'stationGridsquare': serializer.toJson<String?>(stationGridsquare),
      'operator': serializer.toJson<String?>(operator),
      'userUuid': serializer.toJson<String>(userUuid),
      'supabaseId': serializer.toJson<String>(supabaseId),
      'qrzLogId': serializer.toJson<String?>(qrzLogId),
      'syncVersion': serializer.toJson<int>(syncVersion),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalQso copyWith({
    String? id,
    String? callsign,
    DateTime? qsoDate,
    String? timeOn,
    String? band,
    String? mode,
    Value<String?> freq = const Value.absent(),
    Value<String?> rstSent = const Value.absent(),
    Value<String?> rstRcvd = const Value.absent(),
    Value<String?> name = const Value.absent(),
    Value<String?> qth = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> gridsquare = const Value.absent(),
    Value<String?> lat = const Value.absent(),
    Value<String?> lon = const Value.absent(),
    Value<String?> comment = const Value.absent(),
    Value<String?> propMode = const Value.absent(),
    Value<String?> satName = const Value.absent(),
    Value<String?> txPwr = const Value.absent(),
    Value<String?> mySig = const Value.absent(),
    Value<String?> sig = const Value.absent(),
    Value<String?> state = const Value.absent(),
    Value<String?> cqz = const Value.absent(),
    Value<String?> contestId = const Value.absent(),
    Value<String?> stx = const Value.absent(),
    Value<String?> srx = const Value.absent(),
    Value<String?> stxString = const Value.absent(),
    Value<String?> srxString = const Value.absent(),
    String? stationCallsign,
    Value<String?> stationGridsquare = const Value.absent(),
    Value<String?> operator = const Value.absent(),
    String? userUuid,
    String? supabaseId,
    Value<String?> qrzLogId = const Value.absent(),
    int? syncVersion,
    String? syncStatus,
  }) => LocalQso(
    id: id ?? this.id,
    callsign: callsign ?? this.callsign,
    qsoDate: qsoDate ?? this.qsoDate,
    timeOn: timeOn ?? this.timeOn,
    band: band ?? this.band,
    mode: mode ?? this.mode,
    freq: freq.present ? freq.value : this.freq,
    rstSent: rstSent.present ? rstSent.value : this.rstSent,
    rstRcvd: rstRcvd.present ? rstRcvd.value : this.rstRcvd,
    name: name.present ? name.value : this.name,
    qth: qth.present ? qth.value : this.qth,
    country: country.present ? country.value : this.country,
    gridsquare: gridsquare.present ? gridsquare.value : this.gridsquare,
    lat: lat.present ? lat.value : this.lat,
    lon: lon.present ? lon.value : this.lon,
    comment: comment.present ? comment.value : this.comment,
    propMode: propMode.present ? propMode.value : this.propMode,
    satName: satName.present ? satName.value : this.satName,
    txPwr: txPwr.present ? txPwr.value : this.txPwr,
    mySig: mySig.present ? mySig.value : this.mySig,
    sig: sig.present ? sig.value : this.sig,
    state: state.present ? state.value : this.state,
    cqz: cqz.present ? cqz.value : this.cqz,
    contestId: contestId.present ? contestId.value : this.contestId,
    stx: stx.present ? stx.value : this.stx,
    srx: srx.present ? srx.value : this.srx,
    stxString: stxString.present ? stxString.value : this.stxString,
    srxString: srxString.present ? srxString.value : this.srxString,
    stationCallsign: stationCallsign ?? this.stationCallsign,
    stationGridsquare: stationGridsquare.present
        ? stationGridsquare.value
        : this.stationGridsquare,
    operator: operator.present ? operator.value : this.operator,
    userUuid: userUuid ?? this.userUuid,
    supabaseId: supabaseId ?? this.supabaseId,
    qrzLogId: qrzLogId.present ? qrzLogId.value : this.qrzLogId,
    syncVersion: syncVersion ?? this.syncVersion,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalQso copyWithCompanion(LocalQsosCompanion data) {
    return LocalQso(
      id: data.id.present ? data.id.value : this.id,
      callsign: data.callsign.present ? data.callsign.value : this.callsign,
      qsoDate: data.qsoDate.present ? data.qsoDate.value : this.qsoDate,
      timeOn: data.timeOn.present ? data.timeOn.value : this.timeOn,
      band: data.band.present ? data.band.value : this.band,
      mode: data.mode.present ? data.mode.value : this.mode,
      freq: data.freq.present ? data.freq.value : this.freq,
      rstSent: data.rstSent.present ? data.rstSent.value : this.rstSent,
      rstRcvd: data.rstRcvd.present ? data.rstRcvd.value : this.rstRcvd,
      name: data.name.present ? data.name.value : this.name,
      qth: data.qth.present ? data.qth.value : this.qth,
      country: data.country.present ? data.country.value : this.country,
      gridsquare: data.gridsquare.present
          ? data.gridsquare.value
          : this.gridsquare,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      comment: data.comment.present ? data.comment.value : this.comment,
      propMode: data.propMode.present ? data.propMode.value : this.propMode,
      satName: data.satName.present ? data.satName.value : this.satName,
      txPwr: data.txPwr.present ? data.txPwr.value : this.txPwr,
      mySig: data.mySig.present ? data.mySig.value : this.mySig,
      sig: data.sig.present ? data.sig.value : this.sig,
      state: data.state.present ? data.state.value : this.state,
      cqz: data.cqz.present ? data.cqz.value : this.cqz,
      contestId: data.contestId.present ? data.contestId.value : this.contestId,
      stx: data.stx.present ? data.stx.value : this.stx,
      srx: data.srx.present ? data.srx.value : this.srx,
      stxString: data.stxString.present ? data.stxString.value : this.stxString,
      srxString: data.srxString.present ? data.srxString.value : this.srxString,
      stationCallsign: data.stationCallsign.present
          ? data.stationCallsign.value
          : this.stationCallsign,
      stationGridsquare: data.stationGridsquare.present
          ? data.stationGridsquare.value
          : this.stationGridsquare,
      operator: data.operator.present ? data.operator.value : this.operator,
      userUuid: data.userUuid.present ? data.userUuid.value : this.userUuid,
      supabaseId: data.supabaseId.present
          ? data.supabaseId.value
          : this.supabaseId,
      qrzLogId: data.qrzLogId.present ? data.qrzLogId.value : this.qrzLogId,
      syncVersion: data.syncVersion.present
          ? data.syncVersion.value
          : this.syncVersion,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalQso(')
          ..write('id: $id, ')
          ..write('callsign: $callsign, ')
          ..write('qsoDate: $qsoDate, ')
          ..write('timeOn: $timeOn, ')
          ..write('band: $band, ')
          ..write('mode: $mode, ')
          ..write('freq: $freq, ')
          ..write('rstSent: $rstSent, ')
          ..write('rstRcvd: $rstRcvd, ')
          ..write('name: $name, ')
          ..write('qth: $qth, ')
          ..write('country: $country, ')
          ..write('gridsquare: $gridsquare, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('comment: $comment, ')
          ..write('propMode: $propMode, ')
          ..write('satName: $satName, ')
          ..write('txPwr: $txPwr, ')
          ..write('mySig: $mySig, ')
          ..write('sig: $sig, ')
          ..write('state: $state, ')
          ..write('cqz: $cqz, ')
          ..write('contestId: $contestId, ')
          ..write('stx: $stx, ')
          ..write('srx: $srx, ')
          ..write('stxString: $stxString, ')
          ..write('srxString: $srxString, ')
          ..write('stationCallsign: $stationCallsign, ')
          ..write('stationGridsquare: $stationGridsquare, ')
          ..write('operator: $operator, ')
          ..write('userUuid: $userUuid, ')
          ..write('supabaseId: $supabaseId, ')
          ..write('qrzLogId: $qrzLogId, ')
          ..write('syncVersion: $syncVersion, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    callsign,
    qsoDate,
    timeOn,
    band,
    mode,
    freq,
    rstSent,
    rstRcvd,
    name,
    qth,
    country,
    gridsquare,
    lat,
    lon,
    comment,
    propMode,
    satName,
    txPwr,
    mySig,
    sig,
    state,
    cqz,
    contestId,
    stx,
    srx,
    stxString,
    srxString,
    stationCallsign,
    stationGridsquare,
    operator,
    userUuid,
    supabaseId,
    qrzLogId,
    syncVersion,
    syncStatus,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalQso &&
          other.id == this.id &&
          other.callsign == this.callsign &&
          other.qsoDate == this.qsoDate &&
          other.timeOn == this.timeOn &&
          other.band == this.band &&
          other.mode == this.mode &&
          other.freq == this.freq &&
          other.rstSent == this.rstSent &&
          other.rstRcvd == this.rstRcvd &&
          other.name == this.name &&
          other.qth == this.qth &&
          other.country == this.country &&
          other.gridsquare == this.gridsquare &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.comment == this.comment &&
          other.propMode == this.propMode &&
          other.satName == this.satName &&
          other.txPwr == this.txPwr &&
          other.mySig == this.mySig &&
          other.sig == this.sig &&
          other.state == this.state &&
          other.cqz == this.cqz &&
          other.contestId == this.contestId &&
          other.stx == this.stx &&
          other.srx == this.srx &&
          other.stxString == this.stxString &&
          other.srxString == this.srxString &&
          other.stationCallsign == this.stationCallsign &&
          other.stationGridsquare == this.stationGridsquare &&
          other.operator == this.operator &&
          other.userUuid == this.userUuid &&
          other.supabaseId == this.supabaseId &&
          other.qrzLogId == this.qrzLogId &&
          other.syncVersion == this.syncVersion &&
          other.syncStatus == this.syncStatus);
}

class LocalQsosCompanion extends UpdateCompanion<LocalQso> {
  final Value<String> id;
  final Value<String> callsign;
  final Value<DateTime> qsoDate;
  final Value<String> timeOn;
  final Value<String> band;
  final Value<String> mode;
  final Value<String?> freq;
  final Value<String?> rstSent;
  final Value<String?> rstRcvd;
  final Value<String?> name;
  final Value<String?> qth;
  final Value<String?> country;
  final Value<String?> gridsquare;
  final Value<String?> lat;
  final Value<String?> lon;
  final Value<String?> comment;
  final Value<String?> propMode;
  final Value<String?> satName;
  final Value<String?> txPwr;
  final Value<String?> mySig;
  final Value<String?> sig;
  final Value<String?> state;
  final Value<String?> cqz;
  final Value<String?> contestId;
  final Value<String?> stx;
  final Value<String?> srx;
  final Value<String?> stxString;
  final Value<String?> srxString;
  final Value<String> stationCallsign;
  final Value<String?> stationGridsquare;
  final Value<String?> operator;
  final Value<String> userUuid;
  final Value<String> supabaseId;
  final Value<String?> qrzLogId;
  final Value<int> syncVersion;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalQsosCompanion({
    this.id = const Value.absent(),
    this.callsign = const Value.absent(),
    this.qsoDate = const Value.absent(),
    this.timeOn = const Value.absent(),
    this.band = const Value.absent(),
    this.mode = const Value.absent(),
    this.freq = const Value.absent(),
    this.rstSent = const Value.absent(),
    this.rstRcvd = const Value.absent(),
    this.name = const Value.absent(),
    this.qth = const Value.absent(),
    this.country = const Value.absent(),
    this.gridsquare = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.comment = const Value.absent(),
    this.propMode = const Value.absent(),
    this.satName = const Value.absent(),
    this.txPwr = const Value.absent(),
    this.mySig = const Value.absent(),
    this.sig = const Value.absent(),
    this.state = const Value.absent(),
    this.cqz = const Value.absent(),
    this.contestId = const Value.absent(),
    this.stx = const Value.absent(),
    this.srx = const Value.absent(),
    this.stxString = const Value.absent(),
    this.srxString = const Value.absent(),
    this.stationCallsign = const Value.absent(),
    this.stationGridsquare = const Value.absent(),
    this.operator = const Value.absent(),
    this.userUuid = const Value.absent(),
    this.supabaseId = const Value.absent(),
    this.qrzLogId = const Value.absent(),
    this.syncVersion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalQsosCompanion.insert({
    required String id,
    required String callsign,
    required DateTime qsoDate,
    required String timeOn,
    required String band,
    required String mode,
    this.freq = const Value.absent(),
    this.rstSent = const Value.absent(),
    this.rstRcvd = const Value.absent(),
    this.name = const Value.absent(),
    this.qth = const Value.absent(),
    this.country = const Value.absent(),
    this.gridsquare = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.comment = const Value.absent(),
    this.propMode = const Value.absent(),
    this.satName = const Value.absent(),
    this.txPwr = const Value.absent(),
    this.mySig = const Value.absent(),
    this.sig = const Value.absent(),
    this.state = const Value.absent(),
    this.cqz = const Value.absent(),
    this.contestId = const Value.absent(),
    this.stx = const Value.absent(),
    this.srx = const Value.absent(),
    this.stxString = const Value.absent(),
    this.srxString = const Value.absent(),
    required String stationCallsign,
    this.stationGridsquare = const Value.absent(),
    this.operator = const Value.absent(),
    required String userUuid,
    required String supabaseId,
    this.qrzLogId = const Value.absent(),
    required int syncVersion,
    required String syncStatus,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       callsign = Value(callsign),
       qsoDate = Value(qsoDate),
       timeOn = Value(timeOn),
       band = Value(band),
       mode = Value(mode),
       stationCallsign = Value(stationCallsign),
       userUuid = Value(userUuid),
       supabaseId = Value(supabaseId),
       syncVersion = Value(syncVersion),
       syncStatus = Value(syncStatus);
  static Insertable<LocalQso> custom({
    Expression<String>? id,
    Expression<String>? callsign,
    Expression<DateTime>? qsoDate,
    Expression<String>? timeOn,
    Expression<String>? band,
    Expression<String>? mode,
    Expression<String>? freq,
    Expression<String>? rstSent,
    Expression<String>? rstRcvd,
    Expression<String>? name,
    Expression<String>? qth,
    Expression<String>? country,
    Expression<String>? gridsquare,
    Expression<String>? lat,
    Expression<String>? lon,
    Expression<String>? comment,
    Expression<String>? propMode,
    Expression<String>? satName,
    Expression<String>? txPwr,
    Expression<String>? mySig,
    Expression<String>? sig,
    Expression<String>? state,
    Expression<String>? cqz,
    Expression<String>? contestId,
    Expression<String>? stx,
    Expression<String>? srx,
    Expression<String>? stxString,
    Expression<String>? srxString,
    Expression<String>? stationCallsign,
    Expression<String>? stationGridsquare,
    Expression<String>? operator,
    Expression<String>? userUuid,
    Expression<String>? supabaseId,
    Expression<String>? qrzLogId,
    Expression<int>? syncVersion,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (callsign != null) 'callsign': callsign,
      if (qsoDate != null) 'qso_date': qsoDate,
      if (timeOn != null) 'time_on': timeOn,
      if (band != null) 'band': band,
      if (mode != null) 'mode': mode,
      if (freq != null) 'freq': freq,
      if (rstSent != null) 'rst_sent': rstSent,
      if (rstRcvd != null) 'rst_rcvd': rstRcvd,
      if (name != null) 'name': name,
      if (qth != null) 'qth': qth,
      if (country != null) 'country': country,
      if (gridsquare != null) 'gridsquare': gridsquare,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (comment != null) 'comment': comment,
      if (propMode != null) 'prop_mode': propMode,
      if (satName != null) 'sat_name': satName,
      if (txPwr != null) 'tx_pwr': txPwr,
      if (mySig != null) 'my_sig': mySig,
      if (sig != null) 'sig': sig,
      if (state != null) 'state': state,
      if (cqz != null) 'cqz': cqz,
      if (contestId != null) 'contest_id': contestId,
      if (stx != null) 'stx': stx,
      if (srx != null) 'srx': srx,
      if (stxString != null) 'stx_string': stxString,
      if (srxString != null) 'srx_string': srxString,
      if (stationCallsign != null) 'station_callsign': stationCallsign,
      if (stationGridsquare != null) 'station_gridsquare': stationGridsquare,
      if (operator != null) 'operator': operator,
      if (userUuid != null) 'user_uuid': userUuid,
      if (supabaseId != null) 'supabase_id': supabaseId,
      if (qrzLogId != null) 'qrz_log_id': qrzLogId,
      if (syncVersion != null) 'sync_version': syncVersion,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalQsosCompanion copyWith({
    Value<String>? id,
    Value<String>? callsign,
    Value<DateTime>? qsoDate,
    Value<String>? timeOn,
    Value<String>? band,
    Value<String>? mode,
    Value<String?>? freq,
    Value<String?>? rstSent,
    Value<String?>? rstRcvd,
    Value<String?>? name,
    Value<String?>? qth,
    Value<String?>? country,
    Value<String?>? gridsquare,
    Value<String?>? lat,
    Value<String?>? lon,
    Value<String?>? comment,
    Value<String?>? propMode,
    Value<String?>? satName,
    Value<String?>? txPwr,
    Value<String?>? mySig,
    Value<String?>? sig,
    Value<String?>? state,
    Value<String?>? cqz,
    Value<String?>? contestId,
    Value<String?>? stx,
    Value<String?>? srx,
    Value<String?>? stxString,
    Value<String?>? srxString,
    Value<String>? stationCallsign,
    Value<String?>? stationGridsquare,
    Value<String?>? operator,
    Value<String>? userUuid,
    Value<String>? supabaseId,
    Value<String?>? qrzLogId,
    Value<int>? syncVersion,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalQsosCompanion(
      id: id ?? this.id,
      callsign: callsign ?? this.callsign,
      qsoDate: qsoDate ?? this.qsoDate,
      timeOn: timeOn ?? this.timeOn,
      band: band ?? this.band,
      mode: mode ?? this.mode,
      freq: freq ?? this.freq,
      rstSent: rstSent ?? this.rstSent,
      rstRcvd: rstRcvd ?? this.rstRcvd,
      name: name ?? this.name,
      qth: qth ?? this.qth,
      country: country ?? this.country,
      gridsquare: gridsquare ?? this.gridsquare,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      comment: comment ?? this.comment,
      propMode: propMode ?? this.propMode,
      satName: satName ?? this.satName,
      txPwr: txPwr ?? this.txPwr,
      mySig: mySig ?? this.mySig,
      sig: sig ?? this.sig,
      state: state ?? this.state,
      cqz: cqz ?? this.cqz,
      contestId: contestId ?? this.contestId,
      stx: stx ?? this.stx,
      srx: srx ?? this.srx,
      stxString: stxString ?? this.stxString,
      srxString: srxString ?? this.srxString,
      stationCallsign: stationCallsign ?? this.stationCallsign,
      stationGridsquare: stationGridsquare ?? this.stationGridsquare,
      operator: operator ?? this.operator,
      userUuid: userUuid ?? this.userUuid,
      supabaseId: supabaseId ?? this.supabaseId,
      qrzLogId: qrzLogId ?? this.qrzLogId,
      syncVersion: syncVersion ?? this.syncVersion,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (callsign.present) {
      map['callsign'] = Variable<String>(callsign.value);
    }
    if (qsoDate.present) {
      map['qso_date'] = Variable<DateTime>(qsoDate.value);
    }
    if (timeOn.present) {
      map['time_on'] = Variable<String>(timeOn.value);
    }
    if (band.present) {
      map['band'] = Variable<String>(band.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (freq.present) {
      map['freq'] = Variable<String>(freq.value);
    }
    if (rstSent.present) {
      map['rst_sent'] = Variable<String>(rstSent.value);
    }
    if (rstRcvd.present) {
      map['rst_rcvd'] = Variable<String>(rstRcvd.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (qth.present) {
      map['qth'] = Variable<String>(qth.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (gridsquare.present) {
      map['gridsquare'] = Variable<String>(gridsquare.value);
    }
    if (lat.present) {
      map['lat'] = Variable<String>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<String>(lon.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (propMode.present) {
      map['prop_mode'] = Variable<String>(propMode.value);
    }
    if (satName.present) {
      map['sat_name'] = Variable<String>(satName.value);
    }
    if (txPwr.present) {
      map['tx_pwr'] = Variable<String>(txPwr.value);
    }
    if (mySig.present) {
      map['my_sig'] = Variable<String>(mySig.value);
    }
    if (sig.present) {
      map['sig'] = Variable<String>(sig.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (cqz.present) {
      map['cqz'] = Variable<String>(cqz.value);
    }
    if (contestId.present) {
      map['contest_id'] = Variable<String>(contestId.value);
    }
    if (stx.present) {
      map['stx'] = Variable<String>(stx.value);
    }
    if (srx.present) {
      map['srx'] = Variable<String>(srx.value);
    }
    if (stxString.present) {
      map['stx_string'] = Variable<String>(stxString.value);
    }
    if (srxString.present) {
      map['srx_string'] = Variable<String>(srxString.value);
    }
    if (stationCallsign.present) {
      map['station_callsign'] = Variable<String>(stationCallsign.value);
    }
    if (stationGridsquare.present) {
      map['station_gridsquare'] = Variable<String>(stationGridsquare.value);
    }
    if (operator.present) {
      map['operator'] = Variable<String>(operator.value);
    }
    if (userUuid.present) {
      map['user_uuid'] = Variable<String>(userUuid.value);
    }
    if (supabaseId.present) {
      map['supabase_id'] = Variable<String>(supabaseId.value);
    }
    if (qrzLogId.present) {
      map['qrz_log_id'] = Variable<String>(qrzLogId.value);
    }
    if (syncVersion.present) {
      map['sync_version'] = Variable<int>(syncVersion.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalQsosCompanion(')
          ..write('id: $id, ')
          ..write('callsign: $callsign, ')
          ..write('qsoDate: $qsoDate, ')
          ..write('timeOn: $timeOn, ')
          ..write('band: $band, ')
          ..write('mode: $mode, ')
          ..write('freq: $freq, ')
          ..write('rstSent: $rstSent, ')
          ..write('rstRcvd: $rstRcvd, ')
          ..write('name: $name, ')
          ..write('qth: $qth, ')
          ..write('country: $country, ')
          ..write('gridsquare: $gridsquare, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('comment: $comment, ')
          ..write('propMode: $propMode, ')
          ..write('satName: $satName, ')
          ..write('txPwr: $txPwr, ')
          ..write('mySig: $mySig, ')
          ..write('sig: $sig, ')
          ..write('state: $state, ')
          ..write('cqz: $cqz, ')
          ..write('contestId: $contestId, ')
          ..write('stx: $stx, ')
          ..write('srx: $srx, ')
          ..write('stxString: $stxString, ')
          ..write('srxString: $srxString, ')
          ..write('stationCallsign: $stationCallsign, ')
          ..write('stationGridsquare: $stationGridsquare, ')
          ..write('operator: $operator, ')
          ..write('userUuid: $userUuid, ')
          ..write('supabaseId: $supabaseId, ')
          ..write('qrzLogId: $qrzLogId, ')
          ..write('syncVersion: $syncVersion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _qrzUsernameMeta = const VerificationMeta(
    'qrzUsername',
  );
  @override
  late final GeneratedColumn<String> qrzUsername = GeneratedColumn<String>(
    'qrz_username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logbookApiKeyMeta = const VerificationMeta(
    'logbookApiKey',
  );
  @override
  late final GeneratedColumn<String> logbookApiKey = GeneratedColumn<String>(
    'logbook_api_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncTimestampMeta = const VerificationMeta(
    'lastSyncTimestamp',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncTimestamp =
      GeneratedColumn<DateTime>(
        'last_sync_timestamp',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastBandMeta = const VerificationMeta(
    'lastBand',
  );
  @override
  late final GeneratedColumn<String> lastBand = GeneratedColumn<String>(
    'last_band',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastModeMeta = const VerificationMeta(
    'lastMode',
  );
  @override
  late final GeneratedColumn<String> lastMode = GeneratedColumn<String>(
    'last_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastStationCallsignMeta =
      const VerificationMeta('lastStationCallsign');
  @override
  late final GeneratedColumn<String> lastStationCallsign =
      GeneratedColumn<String>(
        'last_station_callsign',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastPowerMeta = const VerificationMeta(
    'lastPower',
  );
  @override
  late final GeneratedColumn<String> lastPower = GeneratedColumn<String>(
    'last_power',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stationGridsquareMeta = const VerificationMeta(
    'stationGridsquare',
  );
  @override
  late final GeneratedColumn<String> stationGridsquare =
      GeneratedColumn<String>(
        'station_gridsquare',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _userUuidMeta = const VerificationMeta(
    'userUuid',
  );
  @override
  late final GeneratedColumn<String> userUuid = GeneratedColumn<String>(
    'user_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastPushTimestampMeta = const VerificationMeta(
    'lastPushTimestamp',
  );
  @override
  late final GeneratedColumn<DateTime> lastPushTimestamp =
      GeneratedColumn<DateTime>(
        'last_push_timestamp',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    qrzUsername,
    logbookApiKey,
    lastSyncTimestamp,
    lastBand,
    lastMode,
    lastStationCallsign,
    lastPower,
    stationGridsquare,
    userUuid,
    lastPushTimestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('qrz_username')) {
      context.handle(
        _qrzUsernameMeta,
        qrzUsername.isAcceptableOrUnknown(
          data['qrz_username']!,
          _qrzUsernameMeta,
        ),
      );
    }
    if (data.containsKey('logbook_api_key')) {
      context.handle(
        _logbookApiKeyMeta,
        logbookApiKey.isAcceptableOrUnknown(
          data['logbook_api_key']!,
          _logbookApiKeyMeta,
        ),
      );
    }
    if (data.containsKey('last_sync_timestamp')) {
      context.handle(
        _lastSyncTimestampMeta,
        lastSyncTimestamp.isAcceptableOrUnknown(
          data['last_sync_timestamp']!,
          _lastSyncTimestampMeta,
        ),
      );
    }
    if (data.containsKey('last_band')) {
      context.handle(
        _lastBandMeta,
        lastBand.isAcceptableOrUnknown(data['last_band']!, _lastBandMeta),
      );
    }
    if (data.containsKey('last_mode')) {
      context.handle(
        _lastModeMeta,
        lastMode.isAcceptableOrUnknown(data['last_mode']!, _lastModeMeta),
      );
    }
    if (data.containsKey('last_station_callsign')) {
      context.handle(
        _lastStationCallsignMeta,
        lastStationCallsign.isAcceptableOrUnknown(
          data['last_station_callsign']!,
          _lastStationCallsignMeta,
        ),
      );
    }
    if (data.containsKey('last_power')) {
      context.handle(
        _lastPowerMeta,
        lastPower.isAcceptableOrUnknown(data['last_power']!, _lastPowerMeta),
      );
    }
    if (data.containsKey('station_gridsquare')) {
      context.handle(
        _stationGridsquareMeta,
        stationGridsquare.isAcceptableOrUnknown(
          data['station_gridsquare']!,
          _stationGridsquareMeta,
        ),
      );
    }
    if (data.containsKey('user_uuid')) {
      context.handle(
        _userUuidMeta,
        userUuid.isAcceptableOrUnknown(data['user_uuid']!, _userUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_userUuidMeta);
    }
    if (data.containsKey('last_push_timestamp')) {
      context.handle(
        _lastPushTimestampMeta,
        lastPushTimestamp.isAcceptableOrUnknown(
          data['last_push_timestamp']!,
          _lastPushTimestampMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      qrzUsername: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qrz_username'],
      ),
      logbookApiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logbook_api_key'],
      ),
      lastSyncTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_timestamp'],
      ),
      lastBand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_band'],
      ),
      lastMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_mode'],
      ),
      lastStationCallsign: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_station_callsign'],
      ),
      lastPower: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_power'],
      ),
      stationGridsquare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station_gridsquare'],
      ),
      userUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uuid'],
      )!,
      lastPushTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_push_timestamp'],
      ),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String? qrzUsername;
  final String? logbookApiKey;
  final DateTime? lastSyncTimestamp;
  final String? lastBand;
  final String? lastMode;
  final String? lastStationCallsign;
  final String? lastPower;
  final String? stationGridsquare;
  final String userUuid;
  final DateTime? lastPushTimestamp;
  const AppSetting({
    required this.id,
    this.qrzUsername,
    this.logbookApiKey,
    this.lastSyncTimestamp,
    this.lastBand,
    this.lastMode,
    this.lastStationCallsign,
    this.lastPower,
    this.stationGridsquare,
    required this.userUuid,
    this.lastPushTimestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || qrzUsername != null) {
      map['qrz_username'] = Variable<String>(qrzUsername);
    }
    if (!nullToAbsent || logbookApiKey != null) {
      map['logbook_api_key'] = Variable<String>(logbookApiKey);
    }
    if (!nullToAbsent || lastSyncTimestamp != null) {
      map['last_sync_timestamp'] = Variable<DateTime>(lastSyncTimestamp);
    }
    if (!nullToAbsent || lastBand != null) {
      map['last_band'] = Variable<String>(lastBand);
    }
    if (!nullToAbsent || lastMode != null) {
      map['last_mode'] = Variable<String>(lastMode);
    }
    if (!nullToAbsent || lastStationCallsign != null) {
      map['last_station_callsign'] = Variable<String>(lastStationCallsign);
    }
    if (!nullToAbsent || lastPower != null) {
      map['last_power'] = Variable<String>(lastPower);
    }
    if (!nullToAbsent || stationGridsquare != null) {
      map['station_gridsquare'] = Variable<String>(stationGridsquare);
    }
    map['user_uuid'] = Variable<String>(userUuid);
    if (!nullToAbsent || lastPushTimestamp != null) {
      map['last_push_timestamp'] = Variable<DateTime>(lastPushTimestamp);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      qrzUsername: qrzUsername == null && nullToAbsent
          ? const Value.absent()
          : Value(qrzUsername),
      logbookApiKey: logbookApiKey == null && nullToAbsent
          ? const Value.absent()
          : Value(logbookApiKey),
      lastSyncTimestamp: lastSyncTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncTimestamp),
      lastBand: lastBand == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBand),
      lastMode: lastMode == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMode),
      lastStationCallsign: lastStationCallsign == null && nullToAbsent
          ? const Value.absent()
          : Value(lastStationCallsign),
      lastPower: lastPower == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPower),
      stationGridsquare: stationGridsquare == null && nullToAbsent
          ? const Value.absent()
          : Value(stationGridsquare),
      userUuid: Value(userUuid),
      lastPushTimestamp: lastPushTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPushTimestamp),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      qrzUsername: serializer.fromJson<String?>(json['qrzUsername']),
      logbookApiKey: serializer.fromJson<String?>(json['logbookApiKey']),
      lastSyncTimestamp: serializer.fromJson<DateTime?>(
        json['lastSyncTimestamp'],
      ),
      lastBand: serializer.fromJson<String?>(json['lastBand']),
      lastMode: serializer.fromJson<String?>(json['lastMode']),
      lastStationCallsign: serializer.fromJson<String?>(
        json['lastStationCallsign'],
      ),
      lastPower: serializer.fromJson<String?>(json['lastPower']),
      stationGridsquare: serializer.fromJson<String?>(
        json['stationGridsquare'],
      ),
      userUuid: serializer.fromJson<String>(json['userUuid']),
      lastPushTimestamp: serializer.fromJson<DateTime?>(
        json['lastPushTimestamp'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'qrzUsername': serializer.toJson<String?>(qrzUsername),
      'logbookApiKey': serializer.toJson<String?>(logbookApiKey),
      'lastSyncTimestamp': serializer.toJson<DateTime?>(lastSyncTimestamp),
      'lastBand': serializer.toJson<String?>(lastBand),
      'lastMode': serializer.toJson<String?>(lastMode),
      'lastStationCallsign': serializer.toJson<String?>(lastStationCallsign),
      'lastPower': serializer.toJson<String?>(lastPower),
      'stationGridsquare': serializer.toJson<String?>(stationGridsquare),
      'userUuid': serializer.toJson<String>(userUuid),
      'lastPushTimestamp': serializer.toJson<DateTime?>(lastPushTimestamp),
    };
  }

  AppSetting copyWith({
    int? id,
    Value<String?> qrzUsername = const Value.absent(),
    Value<String?> logbookApiKey = const Value.absent(),
    Value<DateTime?> lastSyncTimestamp = const Value.absent(),
    Value<String?> lastBand = const Value.absent(),
    Value<String?> lastMode = const Value.absent(),
    Value<String?> lastStationCallsign = const Value.absent(),
    Value<String?> lastPower = const Value.absent(),
    Value<String?> stationGridsquare = const Value.absent(),
    String? userUuid,
    Value<DateTime?> lastPushTimestamp = const Value.absent(),
  }) => AppSetting(
    id: id ?? this.id,
    qrzUsername: qrzUsername.present ? qrzUsername.value : this.qrzUsername,
    logbookApiKey: logbookApiKey.present
        ? logbookApiKey.value
        : this.logbookApiKey,
    lastSyncTimestamp: lastSyncTimestamp.present
        ? lastSyncTimestamp.value
        : this.lastSyncTimestamp,
    lastBand: lastBand.present ? lastBand.value : this.lastBand,
    lastMode: lastMode.present ? lastMode.value : this.lastMode,
    lastStationCallsign: lastStationCallsign.present
        ? lastStationCallsign.value
        : this.lastStationCallsign,
    lastPower: lastPower.present ? lastPower.value : this.lastPower,
    stationGridsquare: stationGridsquare.present
        ? stationGridsquare.value
        : this.stationGridsquare,
    userUuid: userUuid ?? this.userUuid,
    lastPushTimestamp: lastPushTimestamp.present
        ? lastPushTimestamp.value
        : this.lastPushTimestamp,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      qrzUsername: data.qrzUsername.present
          ? data.qrzUsername.value
          : this.qrzUsername,
      logbookApiKey: data.logbookApiKey.present
          ? data.logbookApiKey.value
          : this.logbookApiKey,
      lastSyncTimestamp: data.lastSyncTimestamp.present
          ? data.lastSyncTimestamp.value
          : this.lastSyncTimestamp,
      lastBand: data.lastBand.present ? data.lastBand.value : this.lastBand,
      lastMode: data.lastMode.present ? data.lastMode.value : this.lastMode,
      lastStationCallsign: data.lastStationCallsign.present
          ? data.lastStationCallsign.value
          : this.lastStationCallsign,
      lastPower: data.lastPower.present ? data.lastPower.value : this.lastPower,
      stationGridsquare: data.stationGridsquare.present
          ? data.stationGridsquare.value
          : this.stationGridsquare,
      userUuid: data.userUuid.present ? data.userUuid.value : this.userUuid,
      lastPushTimestamp: data.lastPushTimestamp.present
          ? data.lastPushTimestamp.value
          : this.lastPushTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('qrzUsername: $qrzUsername, ')
          ..write('logbookApiKey: $logbookApiKey, ')
          ..write('lastSyncTimestamp: $lastSyncTimestamp, ')
          ..write('lastBand: $lastBand, ')
          ..write('lastMode: $lastMode, ')
          ..write('lastStationCallsign: $lastStationCallsign, ')
          ..write('lastPower: $lastPower, ')
          ..write('stationGridsquare: $stationGridsquare, ')
          ..write('userUuid: $userUuid, ')
          ..write('lastPushTimestamp: $lastPushTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    qrzUsername,
    logbookApiKey,
    lastSyncTimestamp,
    lastBand,
    lastMode,
    lastStationCallsign,
    lastPower,
    stationGridsquare,
    userUuid,
    lastPushTimestamp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.qrzUsername == this.qrzUsername &&
          other.logbookApiKey == this.logbookApiKey &&
          other.lastSyncTimestamp == this.lastSyncTimestamp &&
          other.lastBand == this.lastBand &&
          other.lastMode == this.lastMode &&
          other.lastStationCallsign == this.lastStationCallsign &&
          other.lastPower == this.lastPower &&
          other.stationGridsquare == this.stationGridsquare &&
          other.userUuid == this.userUuid &&
          other.lastPushTimestamp == this.lastPushTimestamp);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String?> qrzUsername;
  final Value<String?> logbookApiKey;
  final Value<DateTime?> lastSyncTimestamp;
  final Value<String?> lastBand;
  final Value<String?> lastMode;
  final Value<String?> lastStationCallsign;
  final Value<String?> lastPower;
  final Value<String?> stationGridsquare;
  final Value<String> userUuid;
  final Value<DateTime?> lastPushTimestamp;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.qrzUsername = const Value.absent(),
    this.logbookApiKey = const Value.absent(),
    this.lastSyncTimestamp = const Value.absent(),
    this.lastBand = const Value.absent(),
    this.lastMode = const Value.absent(),
    this.lastStationCallsign = const Value.absent(),
    this.lastPower = const Value.absent(),
    this.stationGridsquare = const Value.absent(),
    this.userUuid = const Value.absent(),
    this.lastPushTimestamp = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.qrzUsername = const Value.absent(),
    this.logbookApiKey = const Value.absent(),
    this.lastSyncTimestamp = const Value.absent(),
    this.lastBand = const Value.absent(),
    this.lastMode = const Value.absent(),
    this.lastStationCallsign = const Value.absent(),
    this.lastPower = const Value.absent(),
    this.stationGridsquare = const Value.absent(),
    required String userUuid,
    this.lastPushTimestamp = const Value.absent(),
  }) : userUuid = Value(userUuid);
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? qrzUsername,
    Expression<String>? logbookApiKey,
    Expression<DateTime>? lastSyncTimestamp,
    Expression<String>? lastBand,
    Expression<String>? lastMode,
    Expression<String>? lastStationCallsign,
    Expression<String>? lastPower,
    Expression<String>? stationGridsquare,
    Expression<String>? userUuid,
    Expression<DateTime>? lastPushTimestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (qrzUsername != null) 'qrz_username': qrzUsername,
      if (logbookApiKey != null) 'logbook_api_key': logbookApiKey,
      if (lastSyncTimestamp != null) 'last_sync_timestamp': lastSyncTimestamp,
      if (lastBand != null) 'last_band': lastBand,
      if (lastMode != null) 'last_mode': lastMode,
      if (lastStationCallsign != null)
        'last_station_callsign': lastStationCallsign,
      if (lastPower != null) 'last_power': lastPower,
      if (stationGridsquare != null) 'station_gridsquare': stationGridsquare,
      if (userUuid != null) 'user_uuid': userUuid,
      if (lastPushTimestamp != null) 'last_push_timestamp': lastPushTimestamp,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String?>? qrzUsername,
    Value<String?>? logbookApiKey,
    Value<DateTime?>? lastSyncTimestamp,
    Value<String?>? lastBand,
    Value<String?>? lastMode,
    Value<String?>? lastStationCallsign,
    Value<String?>? lastPower,
    Value<String?>? stationGridsquare,
    Value<String>? userUuid,
    Value<DateTime?>? lastPushTimestamp,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      qrzUsername: qrzUsername ?? this.qrzUsername,
      logbookApiKey: logbookApiKey ?? this.logbookApiKey,
      lastSyncTimestamp: lastSyncTimestamp ?? this.lastSyncTimestamp,
      lastBand: lastBand ?? this.lastBand,
      lastMode: lastMode ?? this.lastMode,
      lastStationCallsign: lastStationCallsign ?? this.lastStationCallsign,
      lastPower: lastPower ?? this.lastPower,
      stationGridsquare: stationGridsquare ?? this.stationGridsquare,
      userUuid: userUuid ?? this.userUuid,
      lastPushTimestamp: lastPushTimestamp ?? this.lastPushTimestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (qrzUsername.present) {
      map['qrz_username'] = Variable<String>(qrzUsername.value);
    }
    if (logbookApiKey.present) {
      map['logbook_api_key'] = Variable<String>(logbookApiKey.value);
    }
    if (lastSyncTimestamp.present) {
      map['last_sync_timestamp'] = Variable<DateTime>(lastSyncTimestamp.value);
    }
    if (lastBand.present) {
      map['last_band'] = Variable<String>(lastBand.value);
    }
    if (lastMode.present) {
      map['last_mode'] = Variable<String>(lastMode.value);
    }
    if (lastStationCallsign.present) {
      map['last_station_callsign'] = Variable<String>(
        lastStationCallsign.value,
      );
    }
    if (lastPower.present) {
      map['last_power'] = Variable<String>(lastPower.value);
    }
    if (stationGridsquare.present) {
      map['station_gridsquare'] = Variable<String>(stationGridsquare.value);
    }
    if (userUuid.present) {
      map['user_uuid'] = Variable<String>(userUuid.value);
    }
    if (lastPushTimestamp.present) {
      map['last_push_timestamp'] = Variable<DateTime>(lastPushTimestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('qrzUsername: $qrzUsername, ')
          ..write('logbookApiKey: $logbookApiKey, ')
          ..write('lastSyncTimestamp: $lastSyncTimestamp, ')
          ..write('lastBand: $lastBand, ')
          ..write('lastMode: $lastMode, ')
          ..write('lastStationCallsign: $lastStationCallsign, ')
          ..write('lastPower: $lastPower, ')
          ..write('stationGridsquare: $stationGridsquare, ')
          ..write('userUuid: $userUuid, ')
          ..write('lastPushTimestamp: $lastPushTimestamp')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTable extends SyncMeta
    with TableInfo<$SyncMetaTable, SyncMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SyncMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SyncMetaTable createAlias(String alias) {
    return $SyncMetaTable(attachedDatabase, alias);
  }
}

class SyncMetaData extends DataClass implements Insertable<SyncMetaData> {
  final String key;
  final String value;
  const SyncMetaData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(key: Value(key), value: Value(value));
  }

  factory SyncMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SyncMetaData copyWith({String? key, String? value}) =>
      SyncMetaData(key: key ?? this.key, value: value ?? this.value);
  SyncMetaData copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaData &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SyncMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SyncMetaData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SyncMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncLogsTable extends SyncLogs with TableInfo<$SyncLogsTable, SyncLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    level,
    message,
    details,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
    );
  }

  @override
  $SyncLogsTable createAlias(String alias) {
    return $SyncLogsTable(attachedDatabase, alias);
  }
}

class SyncLog extends DataClass implements Insertable<SyncLog> {
  final int id;
  final DateTime timestamp;
  final String level;
  final String message;
  final String? details;
  const SyncLog({
    required this.id,
    required this.timestamp,
    required this.level,
    required this.message,
    this.details,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['level'] = Variable<String>(level);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    return map;
  }

  SyncLogsCompanion toCompanion(bool nullToAbsent) {
    return SyncLogsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      level: Value(level),
      message: Value(message),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
    );
  }

  factory SyncLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLog(
      id: serializer.fromJson<int>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      level: serializer.fromJson<String>(json['level']),
      message: serializer.fromJson<String>(json['message']),
      details: serializer.fromJson<String?>(json['details']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'level': serializer.toJson<String>(level),
      'message': serializer.toJson<String>(message),
      'details': serializer.toJson<String?>(details),
    };
  }

  SyncLog copyWith({
    int? id,
    DateTime? timestamp,
    String? level,
    String? message,
    Value<String?> details = const Value.absent(),
  }) => SyncLog(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    level: level ?? this.level,
    message: message ?? this.message,
    details: details.present ? details.value : this.details,
  );
  SyncLog copyWithCompanion(SyncLogsCompanion data) {
    return SyncLog(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      level: data.level.present ? data.level.value : this.level,
      message: data.message.present ? data.message.value : this.message,
      details: data.details.present ? data.details.value : this.details,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLog(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('level: $level, ')
          ..write('message: $message, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, timestamp, level, message, details);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLog &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.level == this.level &&
          other.message == this.message &&
          other.details == this.details);
}

class SyncLogsCompanion extends UpdateCompanion<SyncLog> {
  final Value<int> id;
  final Value<DateTime> timestamp;
  final Value<String> level;
  final Value<String> message;
  final Value<String?> details;
  const SyncLogsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.level = const Value.absent(),
    this.message = const Value.absent(),
    this.details = const Value.absent(),
  });
  SyncLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime timestamp,
    required String level,
    required String message,
    this.details = const Value.absent(),
  }) : timestamp = Value(timestamp),
       level = Value(level),
       message = Value(message);
  static Insertable<SyncLog> custom({
    Expression<int>? id,
    Expression<DateTime>? timestamp,
    Expression<String>? level,
    Expression<String>? message,
    Expression<String>? details,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (level != null) 'level': level,
      if (message != null) 'message': message,
      if (details != null) 'details': details,
    });
  }

  SyncLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? timestamp,
    Value<String>? level,
    Value<String>? message,
    Value<String?>? details,
  }) {
    return SyncLogsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      level: level ?? this.level,
      message: message ?? this.message,
      details: details ?? this.details,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('level: $level, ')
          ..write('message: $message, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalQsosTable localQsos = $LocalQsosTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $SyncMetaTable syncMeta = $SyncMetaTable(this);
  late final $SyncLogsTable syncLogs = $SyncLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localQsos,
    appSettings,
    syncMeta,
    syncLogs,
  ];
}

typedef $$LocalQsosTableCreateCompanionBuilder =
    LocalQsosCompanion Function({
      required String id,
      required String callsign,
      required DateTime qsoDate,
      required String timeOn,
      required String band,
      required String mode,
      Value<String?> freq,
      Value<String?> rstSent,
      Value<String?> rstRcvd,
      Value<String?> name,
      Value<String?> qth,
      Value<String?> country,
      Value<String?> gridsquare,
      Value<String?> lat,
      Value<String?> lon,
      Value<String?> comment,
      Value<String?> propMode,
      Value<String?> satName,
      Value<String?> txPwr,
      Value<String?> mySig,
      Value<String?> sig,
      Value<String?> state,
      Value<String?> cqz,
      Value<String?> contestId,
      Value<String?> stx,
      Value<String?> srx,
      Value<String?> stxString,
      Value<String?> srxString,
      required String stationCallsign,
      Value<String?> stationGridsquare,
      Value<String?> operator,
      required String userUuid,
      required String supabaseId,
      Value<String?> qrzLogId,
      required int syncVersion,
      required String syncStatus,
      Value<int> rowid,
    });
typedef $$LocalQsosTableUpdateCompanionBuilder =
    LocalQsosCompanion Function({
      Value<String> id,
      Value<String> callsign,
      Value<DateTime> qsoDate,
      Value<String> timeOn,
      Value<String> band,
      Value<String> mode,
      Value<String?> freq,
      Value<String?> rstSent,
      Value<String?> rstRcvd,
      Value<String?> name,
      Value<String?> qth,
      Value<String?> country,
      Value<String?> gridsquare,
      Value<String?> lat,
      Value<String?> lon,
      Value<String?> comment,
      Value<String?> propMode,
      Value<String?> satName,
      Value<String?> txPwr,
      Value<String?> mySig,
      Value<String?> sig,
      Value<String?> state,
      Value<String?> cqz,
      Value<String?> contestId,
      Value<String?> stx,
      Value<String?> srx,
      Value<String?> stxString,
      Value<String?> srxString,
      Value<String> stationCallsign,
      Value<String?> stationGridsquare,
      Value<String?> operator,
      Value<String> userUuid,
      Value<String> supabaseId,
      Value<String?> qrzLogId,
      Value<int> syncVersion,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$LocalQsosTableFilterComposer
    extends Composer<_$AppDatabase, $LocalQsosTable> {
  $$LocalQsosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get callsign => $composableBuilder(
    column: $table.callsign,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get qsoDate => $composableBuilder(
    column: $table.qsoDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOn => $composableBuilder(
    column: $table.timeOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get band => $composableBuilder(
    column: $table.band,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get freq => $composableBuilder(
    column: $table.freq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rstSent => $composableBuilder(
    column: $table.rstSent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rstRcvd => $composableBuilder(
    column: $table.rstRcvd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qth => $composableBuilder(
    column: $table.qth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gridsquare => $composableBuilder(
    column: $table.gridsquare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get propMode => $composableBuilder(
    column: $table.propMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get satName => $composableBuilder(
    column: $table.satName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get txPwr => $composableBuilder(
    column: $table.txPwr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mySig => $composableBuilder(
    column: $table.mySig,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sig => $composableBuilder(
    column: $table.sig,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cqz => $composableBuilder(
    column: $table.cqz,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contestId => $composableBuilder(
    column: $table.contestId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stx => $composableBuilder(
    column: $table.stx,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get srx => $composableBuilder(
    column: $table.srx,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stxString => $composableBuilder(
    column: $table.stxString,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get srxString => $composableBuilder(
    column: $table.srxString,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stationCallsign => $composableBuilder(
    column: $table.stationCallsign,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stationGridsquare => $composableBuilder(
    column: $table.stationGridsquare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operator => $composableBuilder(
    column: $table.operator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUuid => $composableBuilder(
    column: $table.userUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supabaseId => $composableBuilder(
    column: $table.supabaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrzLogId => $composableBuilder(
    column: $table.qrzLogId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncVersion => $composableBuilder(
    column: $table.syncVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalQsosTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalQsosTable> {
  $$LocalQsosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get callsign => $composableBuilder(
    column: $table.callsign,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get qsoDate => $composableBuilder(
    column: $table.qsoDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOn => $composableBuilder(
    column: $table.timeOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get band => $composableBuilder(
    column: $table.band,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get freq => $composableBuilder(
    column: $table.freq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rstSent => $composableBuilder(
    column: $table.rstSent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rstRcvd => $composableBuilder(
    column: $table.rstRcvd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qth => $composableBuilder(
    column: $table.qth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gridsquare => $composableBuilder(
    column: $table.gridsquare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get propMode => $composableBuilder(
    column: $table.propMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get satName => $composableBuilder(
    column: $table.satName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get txPwr => $composableBuilder(
    column: $table.txPwr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mySig => $composableBuilder(
    column: $table.mySig,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sig => $composableBuilder(
    column: $table.sig,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cqz => $composableBuilder(
    column: $table.cqz,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contestId => $composableBuilder(
    column: $table.contestId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stx => $composableBuilder(
    column: $table.stx,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get srx => $composableBuilder(
    column: $table.srx,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stxString => $composableBuilder(
    column: $table.stxString,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get srxString => $composableBuilder(
    column: $table.srxString,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stationCallsign => $composableBuilder(
    column: $table.stationCallsign,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stationGridsquare => $composableBuilder(
    column: $table.stationGridsquare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operator => $composableBuilder(
    column: $table.operator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUuid => $composableBuilder(
    column: $table.userUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supabaseId => $composableBuilder(
    column: $table.supabaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrzLogId => $composableBuilder(
    column: $table.qrzLogId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncVersion => $composableBuilder(
    column: $table.syncVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalQsosTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalQsosTable> {
  $$LocalQsosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get callsign =>
      $composableBuilder(column: $table.callsign, builder: (column) => column);

  GeneratedColumn<DateTime> get qsoDate =>
      $composableBuilder(column: $table.qsoDate, builder: (column) => column);

  GeneratedColumn<String> get timeOn =>
      $composableBuilder(column: $table.timeOn, builder: (column) => column);

  GeneratedColumn<String> get band =>
      $composableBuilder(column: $table.band, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get freq =>
      $composableBuilder(column: $table.freq, builder: (column) => column);

  GeneratedColumn<String> get rstSent =>
      $composableBuilder(column: $table.rstSent, builder: (column) => column);

  GeneratedColumn<String> get rstRcvd =>
      $composableBuilder(column: $table.rstRcvd, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get qth =>
      $composableBuilder(column: $table.qth, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get gridsquare => $composableBuilder(
    column: $table.gridsquare,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<String> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<String> get propMode =>
      $composableBuilder(column: $table.propMode, builder: (column) => column);

  GeneratedColumn<String> get satName =>
      $composableBuilder(column: $table.satName, builder: (column) => column);

  GeneratedColumn<String> get txPwr =>
      $composableBuilder(column: $table.txPwr, builder: (column) => column);

  GeneratedColumn<String> get mySig =>
      $composableBuilder(column: $table.mySig, builder: (column) => column);

  GeneratedColumn<String> get sig =>
      $composableBuilder(column: $table.sig, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get cqz =>
      $composableBuilder(column: $table.cqz, builder: (column) => column);

  GeneratedColumn<String> get contestId =>
      $composableBuilder(column: $table.contestId, builder: (column) => column);

  GeneratedColumn<String> get stx =>
      $composableBuilder(column: $table.stx, builder: (column) => column);

  GeneratedColumn<String> get srx =>
      $composableBuilder(column: $table.srx, builder: (column) => column);

  GeneratedColumn<String> get stxString =>
      $composableBuilder(column: $table.stxString, builder: (column) => column);

  GeneratedColumn<String> get srxString =>
      $composableBuilder(column: $table.srxString, builder: (column) => column);

  GeneratedColumn<String> get stationCallsign => $composableBuilder(
    column: $table.stationCallsign,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stationGridsquare => $composableBuilder(
    column: $table.stationGridsquare,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operator =>
      $composableBuilder(column: $table.operator, builder: (column) => column);

  GeneratedColumn<String> get userUuid =>
      $composableBuilder(column: $table.userUuid, builder: (column) => column);

  GeneratedColumn<String> get supabaseId => $composableBuilder(
    column: $table.supabaseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qrzLogId =>
      $composableBuilder(column: $table.qrzLogId, builder: (column) => column);

  GeneratedColumn<int> get syncVersion => $composableBuilder(
    column: $table.syncVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$LocalQsosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalQsosTable,
          LocalQso,
          $$LocalQsosTableFilterComposer,
          $$LocalQsosTableOrderingComposer,
          $$LocalQsosTableAnnotationComposer,
          $$LocalQsosTableCreateCompanionBuilder,
          $$LocalQsosTableUpdateCompanionBuilder,
          (LocalQso, BaseReferences<_$AppDatabase, $LocalQsosTable, LocalQso>),
          LocalQso,
          PrefetchHooks Function()
        > {
  $$LocalQsosTableTableManager(_$AppDatabase db, $LocalQsosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalQsosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalQsosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalQsosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> callsign = const Value.absent(),
                Value<DateTime> qsoDate = const Value.absent(),
                Value<String> timeOn = const Value.absent(),
                Value<String> band = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String?> freq = const Value.absent(),
                Value<String?> rstSent = const Value.absent(),
                Value<String?> rstRcvd = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> qth = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> gridsquare = const Value.absent(),
                Value<String?> lat = const Value.absent(),
                Value<String?> lon = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<String?> propMode = const Value.absent(),
                Value<String?> satName = const Value.absent(),
                Value<String?> txPwr = const Value.absent(),
                Value<String?> mySig = const Value.absent(),
                Value<String?> sig = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> cqz = const Value.absent(),
                Value<String?> contestId = const Value.absent(),
                Value<String?> stx = const Value.absent(),
                Value<String?> srx = const Value.absent(),
                Value<String?> stxString = const Value.absent(),
                Value<String?> srxString = const Value.absent(),
                Value<String> stationCallsign = const Value.absent(),
                Value<String?> stationGridsquare = const Value.absent(),
                Value<String?> operator = const Value.absent(),
                Value<String> userUuid = const Value.absent(),
                Value<String> supabaseId = const Value.absent(),
                Value<String?> qrzLogId = const Value.absent(),
                Value<int> syncVersion = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalQsosCompanion(
                id: id,
                callsign: callsign,
                qsoDate: qsoDate,
                timeOn: timeOn,
                band: band,
                mode: mode,
                freq: freq,
                rstSent: rstSent,
                rstRcvd: rstRcvd,
                name: name,
                qth: qth,
                country: country,
                gridsquare: gridsquare,
                lat: lat,
                lon: lon,
                comment: comment,
                propMode: propMode,
                satName: satName,
                txPwr: txPwr,
                mySig: mySig,
                sig: sig,
                state: state,
                cqz: cqz,
                contestId: contestId,
                stx: stx,
                srx: srx,
                stxString: stxString,
                srxString: srxString,
                stationCallsign: stationCallsign,
                stationGridsquare: stationGridsquare,
                operator: operator,
                userUuid: userUuid,
                supabaseId: supabaseId,
                qrzLogId: qrzLogId,
                syncVersion: syncVersion,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String callsign,
                required DateTime qsoDate,
                required String timeOn,
                required String band,
                required String mode,
                Value<String?> freq = const Value.absent(),
                Value<String?> rstSent = const Value.absent(),
                Value<String?> rstRcvd = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> qth = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> gridsquare = const Value.absent(),
                Value<String?> lat = const Value.absent(),
                Value<String?> lon = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<String?> propMode = const Value.absent(),
                Value<String?> satName = const Value.absent(),
                Value<String?> txPwr = const Value.absent(),
                Value<String?> mySig = const Value.absent(),
                Value<String?> sig = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> cqz = const Value.absent(),
                Value<String?> contestId = const Value.absent(),
                Value<String?> stx = const Value.absent(),
                Value<String?> srx = const Value.absent(),
                Value<String?> stxString = const Value.absent(),
                Value<String?> srxString = const Value.absent(),
                required String stationCallsign,
                Value<String?> stationGridsquare = const Value.absent(),
                Value<String?> operator = const Value.absent(),
                required String userUuid,
                required String supabaseId,
                Value<String?> qrzLogId = const Value.absent(),
                required int syncVersion,
                required String syncStatus,
                Value<int> rowid = const Value.absent(),
              }) => LocalQsosCompanion.insert(
                id: id,
                callsign: callsign,
                qsoDate: qsoDate,
                timeOn: timeOn,
                band: band,
                mode: mode,
                freq: freq,
                rstSent: rstSent,
                rstRcvd: rstRcvd,
                name: name,
                qth: qth,
                country: country,
                gridsquare: gridsquare,
                lat: lat,
                lon: lon,
                comment: comment,
                propMode: propMode,
                satName: satName,
                txPwr: txPwr,
                mySig: mySig,
                sig: sig,
                state: state,
                cqz: cqz,
                contestId: contestId,
                stx: stx,
                srx: srx,
                stxString: stxString,
                srxString: srxString,
                stationCallsign: stationCallsign,
                stationGridsquare: stationGridsquare,
                operator: operator,
                userUuid: userUuid,
                supabaseId: supabaseId,
                qrzLogId: qrzLogId,
                syncVersion: syncVersion,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalQsosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalQsosTable,
      LocalQso,
      $$LocalQsosTableFilterComposer,
      $$LocalQsosTableOrderingComposer,
      $$LocalQsosTableAnnotationComposer,
      $$LocalQsosTableCreateCompanionBuilder,
      $$LocalQsosTableUpdateCompanionBuilder,
      (LocalQso, BaseReferences<_$AppDatabase, $LocalQsosTable, LocalQso>),
      LocalQso,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String?> qrzUsername,
      Value<String?> logbookApiKey,
      Value<DateTime?> lastSyncTimestamp,
      Value<String?> lastBand,
      Value<String?> lastMode,
      Value<String?> lastStationCallsign,
      Value<String?> lastPower,
      Value<String?> stationGridsquare,
      required String userUuid,
      Value<DateTime?> lastPushTimestamp,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String?> qrzUsername,
      Value<String?> logbookApiKey,
      Value<DateTime?> lastSyncTimestamp,
      Value<String?> lastBand,
      Value<String?> lastMode,
      Value<String?> lastStationCallsign,
      Value<String?> lastPower,
      Value<String?> stationGridsquare,
      Value<String> userUuid,
      Value<DateTime?> lastPushTimestamp,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrzUsername => $composableBuilder(
    column: $table.qrzUsername,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logbookApiKey => $composableBuilder(
    column: $table.logbookApiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncTimestamp => $composableBuilder(
    column: $table.lastSyncTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastBand => $composableBuilder(
    column: $table.lastBand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMode => $composableBuilder(
    column: $table.lastMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastStationCallsign => $composableBuilder(
    column: $table.lastStationCallsign,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastPower => $composableBuilder(
    column: $table.lastPower,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stationGridsquare => $composableBuilder(
    column: $table.stationGridsquare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUuid => $composableBuilder(
    column: $table.userUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPushTimestamp => $composableBuilder(
    column: $table.lastPushTimestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrzUsername => $composableBuilder(
    column: $table.qrzUsername,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logbookApiKey => $composableBuilder(
    column: $table.logbookApiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncTimestamp => $composableBuilder(
    column: $table.lastSyncTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastBand => $composableBuilder(
    column: $table.lastBand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMode => $composableBuilder(
    column: $table.lastMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastStationCallsign => $composableBuilder(
    column: $table.lastStationCallsign,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastPower => $composableBuilder(
    column: $table.lastPower,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stationGridsquare => $composableBuilder(
    column: $table.stationGridsquare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUuid => $composableBuilder(
    column: $table.userUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPushTimestamp => $composableBuilder(
    column: $table.lastPushTimestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get qrzUsername => $composableBuilder(
    column: $table.qrzUsername,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logbookApiKey => $composableBuilder(
    column: $table.logbookApiKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncTimestamp => $composableBuilder(
    column: $table.lastSyncTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastBand =>
      $composableBuilder(column: $table.lastBand, builder: (column) => column);

  GeneratedColumn<String> get lastMode =>
      $composableBuilder(column: $table.lastMode, builder: (column) => column);

  GeneratedColumn<String> get lastStationCallsign => $composableBuilder(
    column: $table.lastStationCallsign,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastPower =>
      $composableBuilder(column: $table.lastPower, builder: (column) => column);

  GeneratedColumn<String> get stationGridsquare => $composableBuilder(
    column: $table.stationGridsquare,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userUuid =>
      $composableBuilder(column: $table.userUuid, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPushTimestamp => $composableBuilder(
    column: $table.lastPushTimestamp,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> qrzUsername = const Value.absent(),
                Value<String?> logbookApiKey = const Value.absent(),
                Value<DateTime?> lastSyncTimestamp = const Value.absent(),
                Value<String?> lastBand = const Value.absent(),
                Value<String?> lastMode = const Value.absent(),
                Value<String?> lastStationCallsign = const Value.absent(),
                Value<String?> lastPower = const Value.absent(),
                Value<String?> stationGridsquare = const Value.absent(),
                Value<String> userUuid = const Value.absent(),
                Value<DateTime?> lastPushTimestamp = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                qrzUsername: qrzUsername,
                logbookApiKey: logbookApiKey,
                lastSyncTimestamp: lastSyncTimestamp,
                lastBand: lastBand,
                lastMode: lastMode,
                lastStationCallsign: lastStationCallsign,
                lastPower: lastPower,
                stationGridsquare: stationGridsquare,
                userUuid: userUuid,
                lastPushTimestamp: lastPushTimestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> qrzUsername = const Value.absent(),
                Value<String?> logbookApiKey = const Value.absent(),
                Value<DateTime?> lastSyncTimestamp = const Value.absent(),
                Value<String?> lastBand = const Value.absent(),
                Value<String?> lastMode = const Value.absent(),
                Value<String?> lastStationCallsign = const Value.absent(),
                Value<String?> lastPower = const Value.absent(),
                Value<String?> stationGridsquare = const Value.absent(),
                required String userUuid,
                Value<DateTime?> lastPushTimestamp = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                qrzUsername: qrzUsername,
                logbookApiKey: logbookApiKey,
                lastSyncTimestamp: lastSyncTimestamp,
                lastBand: lastBand,
                lastMode: lastMode,
                lastStationCallsign: lastStationCallsign,
                lastPower: lastPower,
                stationGridsquare: stationGridsquare,
                userUuid: userUuid,
                lastPushTimestamp: lastPushTimestamp,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$SyncMetaTableCreateCompanionBuilder =
    SyncMetaCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SyncMetaTableUpdateCompanionBuilder =
    SyncMetaCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SyncMetaTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SyncMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetaTable,
          SyncMetaData,
          $$SyncMetaTableFilterComposer,
          $$SyncMetaTableOrderingComposer,
          $$SyncMetaTableAnnotationComposer,
          $$SyncMetaTableCreateCompanionBuilder,
          $$SyncMetaTableUpdateCompanionBuilder,
          (
            SyncMetaData,
            BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>,
          ),
          SyncMetaData,
          PrefetchHooks Function()
        > {
  $$SyncMetaTableTableManager(_$AppDatabase db, $SyncMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetaTable,
      SyncMetaData,
      $$SyncMetaTableFilterComposer,
      $$SyncMetaTableOrderingComposer,
      $$SyncMetaTableAnnotationComposer,
      $$SyncMetaTableCreateCompanionBuilder,
      $$SyncMetaTableUpdateCompanionBuilder,
      (
        SyncMetaData,
        BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>,
      ),
      SyncMetaData,
      PrefetchHooks Function()
    >;
typedef $$SyncLogsTableCreateCompanionBuilder =
    SyncLogsCompanion Function({
      Value<int> id,
      required DateTime timestamp,
      required String level,
      required String message,
      Value<String?> details,
    });
typedef $$SyncLogsTableUpdateCompanionBuilder =
    SyncLogsCompanion Function({
      Value<int> id,
      Value<DateTime> timestamp,
      Value<String> level,
      Value<String> message,
      Value<String?> details,
    });

class $$SyncLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);
}

class $$SyncLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncLogsTable,
          SyncLog,
          $$SyncLogsTableFilterComposer,
          $$SyncLogsTableOrderingComposer,
          $$SyncLogsTableAnnotationComposer,
          $$SyncLogsTableCreateCompanionBuilder,
          $$SyncLogsTableUpdateCompanionBuilder,
          (SyncLog, BaseReferences<_$AppDatabase, $SyncLogsTable, SyncLog>),
          SyncLog,
          PrefetchHooks Function()
        > {
  $$SyncLogsTableTableManager(_$AppDatabase db, $SyncLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> details = const Value.absent(),
              }) => SyncLogsCompanion(
                id: id,
                timestamp: timestamp,
                level: level,
                message: message,
                details: details,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime timestamp,
                required String level,
                required String message,
                Value<String?> details = const Value.absent(),
              }) => SyncLogsCompanion.insert(
                id: id,
                timestamp: timestamp,
                level: level,
                message: message,
                details: details,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncLogsTable,
      SyncLog,
      $$SyncLogsTableFilterComposer,
      $$SyncLogsTableOrderingComposer,
      $$SyncLogsTableAnnotationComposer,
      $$SyncLogsTableCreateCompanionBuilder,
      $$SyncLogsTableUpdateCompanionBuilder,
      (SyncLog, BaseReferences<_$AppDatabase, $SyncLogsTable, SyncLog>),
      SyncLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalQsosTableTableManager get localQsos =>
      $$LocalQsosTableTableManager(_db, _db.localQsos);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db, _db.syncMeta);
  $$SyncLogsTableTableManager get syncLogs =>
      $$SyncLogsTableTableManager(_db, _db.syncLogs);
}
