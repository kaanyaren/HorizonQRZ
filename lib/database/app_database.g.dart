// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $QsosTable extends Qsos with TableInfo<$QsosTable, Qso> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QsosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _qrzLogidMeta = const VerificationMeta(
    'qrzLogid',
  );
  @override
  late final GeneratedColumn<String> qrzLogid = GeneratedColumn<String>(
    'qrz_logid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _rawAdifMeta = const VerificationMeta(
    'rawAdif',
  );
  @override
  late final GeneratedColumn<String> rawAdif = GeneratedColumn<String>(
    'raw_adif',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    qrzLogid,
    callsign,
    qsoDate,
    band,
    mode,
    rstSent,
    rstRcvd,
    syncStatus,
    rawAdif,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'qsos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Qso> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('qrz_logid')) {
      context.handle(
        _qrzLogidMeta,
        qrzLogid.isAcceptableOrUnknown(data['qrz_logid']!, _qrzLogidMeta),
      );
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
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('raw_adif')) {
      context.handle(
        _rawAdifMeta,
        rawAdif.isAcceptableOrUnknown(data['raw_adif']!, _rawAdifMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Qso map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Qso(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      qrzLogid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qrz_logid'],
      ),
      callsign: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}callsign'],
      )!,
      qsoDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}qso_date'],
      )!,
      band: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}band'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      rstSent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rst_sent'],
      ),
      rstRcvd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rst_rcvd'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      rawAdif: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_adif'],
      ),
    );
  }

  @override
  $QsosTable createAlias(String alias) {
    return $QsosTable(attachedDatabase, alias);
  }
}

class Qso extends DataClass implements Insertable<Qso> {
  final int id;
  final String? qrzLogid;
  final String callsign;
  final DateTime qsoDate;
  final String band;
  final String mode;
  final String? rstSent;
  final String? rstRcvd;
  final String syncStatus;
  final String? rawAdif;
  const Qso({
    required this.id,
    this.qrzLogid,
    required this.callsign,
    required this.qsoDate,
    required this.band,
    required this.mode,
    this.rstSent,
    this.rstRcvd,
    required this.syncStatus,
    this.rawAdif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || qrzLogid != null) {
      map['qrz_logid'] = Variable<String>(qrzLogid);
    }
    map['callsign'] = Variable<String>(callsign);
    map['qso_date'] = Variable<DateTime>(qsoDate);
    map['band'] = Variable<String>(band);
    map['mode'] = Variable<String>(mode);
    if (!nullToAbsent || rstSent != null) {
      map['rst_sent'] = Variable<String>(rstSent);
    }
    if (!nullToAbsent || rstRcvd != null) {
      map['rst_rcvd'] = Variable<String>(rstRcvd);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || rawAdif != null) {
      map['raw_adif'] = Variable<String>(rawAdif);
    }
    return map;
  }

  QsosCompanion toCompanion(bool nullToAbsent) {
    return QsosCompanion(
      id: Value(id),
      qrzLogid: qrzLogid == null && nullToAbsent
          ? const Value.absent()
          : Value(qrzLogid),
      callsign: Value(callsign),
      qsoDate: Value(qsoDate),
      band: Value(band),
      mode: Value(mode),
      rstSent: rstSent == null && nullToAbsent
          ? const Value.absent()
          : Value(rstSent),
      rstRcvd: rstRcvd == null && nullToAbsent
          ? const Value.absent()
          : Value(rstRcvd),
      syncStatus: Value(syncStatus),
      rawAdif: rawAdif == null && nullToAbsent
          ? const Value.absent()
          : Value(rawAdif),
    );
  }

  factory Qso.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Qso(
      id: serializer.fromJson<int>(json['id']),
      qrzLogid: serializer.fromJson<String?>(json['qrzLogid']),
      callsign: serializer.fromJson<String>(json['callsign']),
      qsoDate: serializer.fromJson<DateTime>(json['qsoDate']),
      band: serializer.fromJson<String>(json['band']),
      mode: serializer.fromJson<String>(json['mode']),
      rstSent: serializer.fromJson<String?>(json['rstSent']),
      rstRcvd: serializer.fromJson<String?>(json['rstRcvd']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      rawAdif: serializer.fromJson<String?>(json['rawAdif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'qrzLogid': serializer.toJson<String?>(qrzLogid),
      'callsign': serializer.toJson<String>(callsign),
      'qsoDate': serializer.toJson<DateTime>(qsoDate),
      'band': serializer.toJson<String>(band),
      'mode': serializer.toJson<String>(mode),
      'rstSent': serializer.toJson<String?>(rstSent),
      'rstRcvd': serializer.toJson<String?>(rstRcvd),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'rawAdif': serializer.toJson<String?>(rawAdif),
    };
  }

  Qso copyWith({
    int? id,
    Value<String?> qrzLogid = const Value.absent(),
    String? callsign,
    DateTime? qsoDate,
    String? band,
    String? mode,
    Value<String?> rstSent = const Value.absent(),
    Value<String?> rstRcvd = const Value.absent(),
    String? syncStatus,
    Value<String?> rawAdif = const Value.absent(),
  }) => Qso(
    id: id ?? this.id,
    qrzLogid: qrzLogid.present ? qrzLogid.value : this.qrzLogid,
    callsign: callsign ?? this.callsign,
    qsoDate: qsoDate ?? this.qsoDate,
    band: band ?? this.band,
    mode: mode ?? this.mode,
    rstSent: rstSent.present ? rstSent.value : this.rstSent,
    rstRcvd: rstRcvd.present ? rstRcvd.value : this.rstRcvd,
    syncStatus: syncStatus ?? this.syncStatus,
    rawAdif: rawAdif.present ? rawAdif.value : this.rawAdif,
  );
  Qso copyWithCompanion(QsosCompanion data) {
    return Qso(
      id: data.id.present ? data.id.value : this.id,
      qrzLogid: data.qrzLogid.present ? data.qrzLogid.value : this.qrzLogid,
      callsign: data.callsign.present ? data.callsign.value : this.callsign,
      qsoDate: data.qsoDate.present ? data.qsoDate.value : this.qsoDate,
      band: data.band.present ? data.band.value : this.band,
      mode: data.mode.present ? data.mode.value : this.mode,
      rstSent: data.rstSent.present ? data.rstSent.value : this.rstSent,
      rstRcvd: data.rstRcvd.present ? data.rstRcvd.value : this.rstRcvd,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      rawAdif: data.rawAdif.present ? data.rawAdif.value : this.rawAdif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Qso(')
          ..write('id: $id, ')
          ..write('qrzLogid: $qrzLogid, ')
          ..write('callsign: $callsign, ')
          ..write('qsoDate: $qsoDate, ')
          ..write('band: $band, ')
          ..write('mode: $mode, ')
          ..write('rstSent: $rstSent, ')
          ..write('rstRcvd: $rstRcvd, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rawAdif: $rawAdif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    qrzLogid,
    callsign,
    qsoDate,
    band,
    mode,
    rstSent,
    rstRcvd,
    syncStatus,
    rawAdif,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Qso &&
          other.id == this.id &&
          other.qrzLogid == this.qrzLogid &&
          other.callsign == this.callsign &&
          other.qsoDate == this.qsoDate &&
          other.band == this.band &&
          other.mode == this.mode &&
          other.rstSent == this.rstSent &&
          other.rstRcvd == this.rstRcvd &&
          other.syncStatus == this.syncStatus &&
          other.rawAdif == this.rawAdif);
}

class QsosCompanion extends UpdateCompanion<Qso> {
  final Value<int> id;
  final Value<String?> qrzLogid;
  final Value<String> callsign;
  final Value<DateTime> qsoDate;
  final Value<String> band;
  final Value<String> mode;
  final Value<String?> rstSent;
  final Value<String?> rstRcvd;
  final Value<String> syncStatus;
  final Value<String?> rawAdif;
  const QsosCompanion({
    this.id = const Value.absent(),
    this.qrzLogid = const Value.absent(),
    this.callsign = const Value.absent(),
    this.qsoDate = const Value.absent(),
    this.band = const Value.absent(),
    this.mode = const Value.absent(),
    this.rstSent = const Value.absent(),
    this.rstRcvd = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rawAdif = const Value.absent(),
  });
  QsosCompanion.insert({
    this.id = const Value.absent(),
    this.qrzLogid = const Value.absent(),
    required String callsign,
    required DateTime qsoDate,
    required String band,
    required String mode,
    this.rstSent = const Value.absent(),
    this.rstRcvd = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rawAdif = const Value.absent(),
  }) : callsign = Value(callsign),
       qsoDate = Value(qsoDate),
       band = Value(band),
       mode = Value(mode);
  static Insertable<Qso> custom({
    Expression<int>? id,
    Expression<String>? qrzLogid,
    Expression<String>? callsign,
    Expression<DateTime>? qsoDate,
    Expression<String>? band,
    Expression<String>? mode,
    Expression<String>? rstSent,
    Expression<String>? rstRcvd,
    Expression<String>? syncStatus,
    Expression<String>? rawAdif,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (qrzLogid != null) 'qrz_logid': qrzLogid,
      if (callsign != null) 'callsign': callsign,
      if (qsoDate != null) 'qso_date': qsoDate,
      if (band != null) 'band': band,
      if (mode != null) 'mode': mode,
      if (rstSent != null) 'rst_sent': rstSent,
      if (rstRcvd != null) 'rst_rcvd': rstRcvd,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rawAdif != null) 'raw_adif': rawAdif,
    });
  }

  QsosCompanion copyWith({
    Value<int>? id,
    Value<String?>? qrzLogid,
    Value<String>? callsign,
    Value<DateTime>? qsoDate,
    Value<String>? band,
    Value<String>? mode,
    Value<String?>? rstSent,
    Value<String?>? rstRcvd,
    Value<String>? syncStatus,
    Value<String?>? rawAdif,
  }) {
    return QsosCompanion(
      id: id ?? this.id,
      qrzLogid: qrzLogid ?? this.qrzLogid,
      callsign: callsign ?? this.callsign,
      qsoDate: qsoDate ?? this.qsoDate,
      band: band ?? this.band,
      mode: mode ?? this.mode,
      rstSent: rstSent ?? this.rstSent,
      rstRcvd: rstRcvd ?? this.rstRcvd,
      syncStatus: syncStatus ?? this.syncStatus,
      rawAdif: rawAdif ?? this.rawAdif,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (qrzLogid.present) {
      map['qrz_logid'] = Variable<String>(qrzLogid.value);
    }
    if (callsign.present) {
      map['callsign'] = Variable<String>(callsign.value);
    }
    if (qsoDate.present) {
      map['qso_date'] = Variable<DateTime>(qsoDate.value);
    }
    if (band.present) {
      map['band'] = Variable<String>(band.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (rstSent.present) {
      map['rst_sent'] = Variable<String>(rstSent.value);
    }
    if (rstRcvd.present) {
      map['rst_rcvd'] = Variable<String>(rstRcvd.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rawAdif.present) {
      map['raw_adif'] = Variable<String>(rawAdif.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QsosCompanion(')
          ..write('id: $id, ')
          ..write('qrzLogid: $qrzLogid, ')
          ..write('callsign: $callsign, ')
          ..write('qsoDate: $qsoDate, ')
          ..write('band: $band, ')
          ..write('mode: $mode, ')
          ..write('rstSent: $rstSent, ')
          ..write('rstRcvd: $rstRcvd, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rawAdif: $rawAdif')
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    qrzUsername,
    logbookApiKey,
    lastSyncTimestamp,
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
  const AppSetting({
    required this.id,
    this.qrzUsername,
    this.logbookApiKey,
    this.lastSyncTimestamp,
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
    };
  }

  AppSetting copyWith({
    int? id,
    Value<String?> qrzUsername = const Value.absent(),
    Value<String?> logbookApiKey = const Value.absent(),
    Value<DateTime?> lastSyncTimestamp = const Value.absent(),
  }) => AppSetting(
    id: id ?? this.id,
    qrzUsername: qrzUsername.present ? qrzUsername.value : this.qrzUsername,
    logbookApiKey: logbookApiKey.present
        ? logbookApiKey.value
        : this.logbookApiKey,
    lastSyncTimestamp: lastSyncTimestamp.present
        ? lastSyncTimestamp.value
        : this.lastSyncTimestamp,
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
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('qrzUsername: $qrzUsername, ')
          ..write('logbookApiKey: $logbookApiKey, ')
          ..write('lastSyncTimestamp: $lastSyncTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, qrzUsername, logbookApiKey, lastSyncTimestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.qrzUsername == this.qrzUsername &&
          other.logbookApiKey == this.logbookApiKey &&
          other.lastSyncTimestamp == this.lastSyncTimestamp);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String?> qrzUsername;
  final Value<String?> logbookApiKey;
  final Value<DateTime?> lastSyncTimestamp;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.qrzUsername = const Value.absent(),
    this.logbookApiKey = const Value.absent(),
    this.lastSyncTimestamp = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.qrzUsername = const Value.absent(),
    this.logbookApiKey = const Value.absent(),
    this.lastSyncTimestamp = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? qrzUsername,
    Expression<String>? logbookApiKey,
    Expression<DateTime>? lastSyncTimestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (qrzUsername != null) 'qrz_username': qrzUsername,
      if (logbookApiKey != null) 'logbook_api_key': logbookApiKey,
      if (lastSyncTimestamp != null) 'last_sync_timestamp': lastSyncTimestamp,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String?>? qrzUsername,
    Value<String?>? logbookApiKey,
    Value<DateTime?>? lastSyncTimestamp,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      qrzUsername: qrzUsername ?? this.qrzUsername,
      logbookApiKey: logbookApiKey ?? this.logbookApiKey,
      lastSyncTimestamp: lastSyncTimestamp ?? this.lastSyncTimestamp,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('qrzUsername: $qrzUsername, ')
          ..write('logbookApiKey: $logbookApiKey, ')
          ..write('lastSyncTimestamp: $lastSyncTimestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QsosTable qsos = $QsosTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [qsos, appSettings];
}

typedef $$QsosTableCreateCompanionBuilder =
    QsosCompanion Function({
      Value<int> id,
      Value<String?> qrzLogid,
      required String callsign,
      required DateTime qsoDate,
      required String band,
      required String mode,
      Value<String?> rstSent,
      Value<String?> rstRcvd,
      Value<String> syncStatus,
      Value<String?> rawAdif,
    });
typedef $$QsosTableUpdateCompanionBuilder =
    QsosCompanion Function({
      Value<int> id,
      Value<String?> qrzLogid,
      Value<String> callsign,
      Value<DateTime> qsoDate,
      Value<String> band,
      Value<String> mode,
      Value<String?> rstSent,
      Value<String?> rstRcvd,
      Value<String> syncStatus,
      Value<String?> rawAdif,
    });

class $$QsosTableFilterComposer extends Composer<_$AppDatabase, $QsosTable> {
  $$QsosTableFilterComposer({
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

  ColumnFilters<String> get qrzLogid => $composableBuilder(
    column: $table.qrzLogid,
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

  ColumnFilters<String> get band => $composableBuilder(
    column: $table.band,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
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

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawAdif => $composableBuilder(
    column: $table.rawAdif,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QsosTableOrderingComposer extends Composer<_$AppDatabase, $QsosTable> {
  $$QsosTableOrderingComposer({
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

  ColumnOrderings<String> get qrzLogid => $composableBuilder(
    column: $table.qrzLogid,
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

  ColumnOrderings<String> get band => $composableBuilder(
    column: $table.band,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
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

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawAdif => $composableBuilder(
    column: $table.rawAdif,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QsosTableAnnotationComposer
    extends Composer<_$AppDatabase, $QsosTable> {
  $$QsosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get qrzLogid =>
      $composableBuilder(column: $table.qrzLogid, builder: (column) => column);

  GeneratedColumn<String> get callsign =>
      $composableBuilder(column: $table.callsign, builder: (column) => column);

  GeneratedColumn<DateTime> get qsoDate =>
      $composableBuilder(column: $table.qsoDate, builder: (column) => column);

  GeneratedColumn<String> get band =>
      $composableBuilder(column: $table.band, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get rstSent =>
      $composableBuilder(column: $table.rstSent, builder: (column) => column);

  GeneratedColumn<String> get rstRcvd =>
      $composableBuilder(column: $table.rstRcvd, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawAdif =>
      $composableBuilder(column: $table.rawAdif, builder: (column) => column);
}

class $$QsosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QsosTable,
          Qso,
          $$QsosTableFilterComposer,
          $$QsosTableOrderingComposer,
          $$QsosTableAnnotationComposer,
          $$QsosTableCreateCompanionBuilder,
          $$QsosTableUpdateCompanionBuilder,
          (Qso, BaseReferences<_$AppDatabase, $QsosTable, Qso>),
          Qso,
          PrefetchHooks Function()
        > {
  $$QsosTableTableManager(_$AppDatabase db, $QsosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QsosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QsosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QsosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> qrzLogid = const Value.absent(),
                Value<String> callsign = const Value.absent(),
                Value<DateTime> qsoDate = const Value.absent(),
                Value<String> band = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String?> rstSent = const Value.absent(),
                Value<String?> rstRcvd = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> rawAdif = const Value.absent(),
              }) => QsosCompanion(
                id: id,
                qrzLogid: qrzLogid,
                callsign: callsign,
                qsoDate: qsoDate,
                band: band,
                mode: mode,
                rstSent: rstSent,
                rstRcvd: rstRcvd,
                syncStatus: syncStatus,
                rawAdif: rawAdif,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> qrzLogid = const Value.absent(),
                required String callsign,
                required DateTime qsoDate,
                required String band,
                required String mode,
                Value<String?> rstSent = const Value.absent(),
                Value<String?> rstRcvd = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> rawAdif = const Value.absent(),
              }) => QsosCompanion.insert(
                id: id,
                qrzLogid: qrzLogid,
                callsign: callsign,
                qsoDate: qsoDate,
                band: band,
                mode: mode,
                rstSent: rstSent,
                rstRcvd: rstRcvd,
                syncStatus: syncStatus,
                rawAdif: rawAdif,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QsosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QsosTable,
      Qso,
      $$QsosTableFilterComposer,
      $$QsosTableOrderingComposer,
      $$QsosTableAnnotationComposer,
      $$QsosTableCreateCompanionBuilder,
      $$QsosTableUpdateCompanionBuilder,
      (Qso, BaseReferences<_$AppDatabase, $QsosTable, Qso>),
      Qso,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String?> qrzUsername,
      Value<String?> logbookApiKey,
      Value<DateTime?> lastSyncTimestamp,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String?> qrzUsername,
      Value<String?> logbookApiKey,
      Value<DateTime?> lastSyncTimestamp,
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
              }) => AppSettingsCompanion(
                id: id,
                qrzUsername: qrzUsername,
                logbookApiKey: logbookApiKey,
                lastSyncTimestamp: lastSyncTimestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> qrzUsername = const Value.absent(),
                Value<String?> logbookApiKey = const Value.absent(),
                Value<DateTime?> lastSyncTimestamp = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                qrzUsername: qrzUsername,
                logbookApiKey: logbookApiKey,
                lastSyncTimestamp: lastSyncTimestamp,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QsosTableTableManager get qsos => $$QsosTableTableManager(_db, _db.qsos);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
