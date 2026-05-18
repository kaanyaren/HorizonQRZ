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
  static const VerificationMeta _freqMeta = const VerificationMeta('freq');
  @override
  late final GeneratedColumn<String> freq = GeneratedColumn<String>(
    'freq',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    qrzLogid,
    callsign,
    qsoDate,
    band,
    freq,
    mode,
    rstSent,
    rstRcvd,
    syncStatus,
    rawAdif,
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
    if (data.containsKey('freq')) {
      context.handle(
        _freqMeta,
        freq.isAcceptableOrUnknown(data['freq']!, _freqMeta),
      );
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
      freq: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}freq'],
      ),
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
  final String? freq;
  final String mode;
  final String? rstSent;
  final String? rstRcvd;
  final String syncStatus;
  final String? rawAdif;
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
  const Qso({
    required this.id,
    this.qrzLogid,
    required this.callsign,
    required this.qsoDate,
    required this.band,
    this.freq,
    required this.mode,
    this.rstSent,
    this.rstRcvd,
    required this.syncStatus,
    this.rawAdif,
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
    if (!nullToAbsent || freq != null) {
      map['freq'] = Variable<String>(freq);
    }
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
      freq: freq == null && nullToAbsent ? const Value.absent() : Value(freq),
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
      freq: serializer.fromJson<String?>(json['freq']),
      mode: serializer.fromJson<String>(json['mode']),
      rstSent: serializer.fromJson<String?>(json['rstSent']),
      rstRcvd: serializer.fromJson<String?>(json['rstRcvd']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      rawAdif: serializer.fromJson<String?>(json['rawAdif']),
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
      'freq': serializer.toJson<String?>(freq),
      'mode': serializer.toJson<String>(mode),
      'rstSent': serializer.toJson<String?>(rstSent),
      'rstRcvd': serializer.toJson<String?>(rstRcvd),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'rawAdif': serializer.toJson<String?>(rawAdif),
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
    };
  }

  Qso copyWith({
    int? id,
    Value<String?> qrzLogid = const Value.absent(),
    String? callsign,
    DateTime? qsoDate,
    String? band,
    Value<String?> freq = const Value.absent(),
    String? mode,
    Value<String?> rstSent = const Value.absent(),
    Value<String?> rstRcvd = const Value.absent(),
    String? syncStatus,
    Value<String?> rawAdif = const Value.absent(),
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
  }) => Qso(
    id: id ?? this.id,
    qrzLogid: qrzLogid.present ? qrzLogid.value : this.qrzLogid,
    callsign: callsign ?? this.callsign,
    qsoDate: qsoDate ?? this.qsoDate,
    band: band ?? this.band,
    freq: freq.present ? freq.value : this.freq,
    mode: mode ?? this.mode,
    rstSent: rstSent.present ? rstSent.value : this.rstSent,
    rstRcvd: rstRcvd.present ? rstRcvd.value : this.rstRcvd,
    syncStatus: syncStatus ?? this.syncStatus,
    rawAdif: rawAdif.present ? rawAdif.value : this.rawAdif,
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
  );
  Qso copyWithCompanion(QsosCompanion data) {
    return Qso(
      id: data.id.present ? data.id.value : this.id,
      qrzLogid: data.qrzLogid.present ? data.qrzLogid.value : this.qrzLogid,
      callsign: data.callsign.present ? data.callsign.value : this.callsign,
      qsoDate: data.qsoDate.present ? data.qsoDate.value : this.qsoDate,
      band: data.band.present ? data.band.value : this.band,
      freq: data.freq.present ? data.freq.value : this.freq,
      mode: data.mode.present ? data.mode.value : this.mode,
      rstSent: data.rstSent.present ? data.rstSent.value : this.rstSent,
      rstRcvd: data.rstRcvd.present ? data.rstRcvd.value : this.rstRcvd,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      rawAdif: data.rawAdif.present ? data.rawAdif.value : this.rawAdif,
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
          ..write('freq: $freq, ')
          ..write('mode: $mode, ')
          ..write('rstSent: $rstSent, ')
          ..write('rstRcvd: $rstRcvd, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rawAdif: $rawAdif, ')
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
          ..write('cqz: $cqz')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    qrzLogid,
    callsign,
    qsoDate,
    band,
    freq,
    mode,
    rstSent,
    rstRcvd,
    syncStatus,
    rawAdif,
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
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Qso &&
          other.id == this.id &&
          other.qrzLogid == this.qrzLogid &&
          other.callsign == this.callsign &&
          other.qsoDate == this.qsoDate &&
          other.band == this.band &&
          other.freq == this.freq &&
          other.mode == this.mode &&
          other.rstSent == this.rstSent &&
          other.rstRcvd == this.rstRcvd &&
          other.syncStatus == this.syncStatus &&
          other.rawAdif == this.rawAdif &&
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
          other.cqz == this.cqz);
}

class QsosCompanion extends UpdateCompanion<Qso> {
  final Value<int> id;
  final Value<String?> qrzLogid;
  final Value<String> callsign;
  final Value<DateTime> qsoDate;
  final Value<String> band;
  final Value<String?> freq;
  final Value<String> mode;
  final Value<String?> rstSent;
  final Value<String?> rstRcvd;
  final Value<String> syncStatus;
  final Value<String?> rawAdif;
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
  const QsosCompanion({
    this.id = const Value.absent(),
    this.qrzLogid = const Value.absent(),
    this.callsign = const Value.absent(),
    this.qsoDate = const Value.absent(),
    this.band = const Value.absent(),
    this.freq = const Value.absent(),
    this.mode = const Value.absent(),
    this.rstSent = const Value.absent(),
    this.rstRcvd = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rawAdif = const Value.absent(),
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
  });
  QsosCompanion.insert({
    this.id = const Value.absent(),
    this.qrzLogid = const Value.absent(),
    required String callsign,
    required DateTime qsoDate,
    required String band,
    this.freq = const Value.absent(),
    required String mode,
    this.rstSent = const Value.absent(),
    this.rstRcvd = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rawAdif = const Value.absent(),
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
    Expression<String>? freq,
    Expression<String>? mode,
    Expression<String>? rstSent,
    Expression<String>? rstRcvd,
    Expression<String>? syncStatus,
    Expression<String>? rawAdif,
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
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (qrzLogid != null) 'qrz_logid': qrzLogid,
      if (callsign != null) 'callsign': callsign,
      if (qsoDate != null) 'qso_date': qsoDate,
      if (band != null) 'band': band,
      if (freq != null) 'freq': freq,
      if (mode != null) 'mode': mode,
      if (rstSent != null) 'rst_sent': rstSent,
      if (rstRcvd != null) 'rst_rcvd': rstRcvd,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rawAdif != null) 'raw_adif': rawAdif,
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
    });
  }

  QsosCompanion copyWith({
    Value<int>? id,
    Value<String?>? qrzLogid,
    Value<String>? callsign,
    Value<DateTime>? qsoDate,
    Value<String>? band,
    Value<String?>? freq,
    Value<String>? mode,
    Value<String?>? rstSent,
    Value<String?>? rstRcvd,
    Value<String>? syncStatus,
    Value<String?>? rawAdif,
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
  }) {
    return QsosCompanion(
      id: id ?? this.id,
      qrzLogid: qrzLogid ?? this.qrzLogid,
      callsign: callsign ?? this.callsign,
      qsoDate: qsoDate ?? this.qsoDate,
      band: band ?? this.band,
      freq: freq ?? this.freq,
      mode: mode ?? this.mode,
      rstSent: rstSent ?? this.rstSent,
      rstRcvd: rstRcvd ?? this.rstRcvd,
      syncStatus: syncStatus ?? this.syncStatus,
      rawAdif: rawAdif ?? this.rawAdif,
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
    if (freq.present) {
      map['freq'] = Variable<String>(freq.value);
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
          ..write('freq: $freq, ')
          ..write('mode: $mode, ')
          ..write('rstSent: $rstSent, ')
          ..write('rstRcvd: $rstRcvd, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rawAdif: $rawAdif, ')
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
          ..write('cqz: $cqz')
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
  const AppSetting({
    required this.id,
    this.qrzUsername,
    this.logbookApiKey,
    this.lastSyncTimestamp,
    this.lastBand,
    this.lastMode,
    this.lastStationCallsign,
    this.lastPower,
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
          ..write('lastPower: $lastPower')
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
          other.lastPower == this.lastPower);
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
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.qrzUsername = const Value.absent(),
    this.logbookApiKey = const Value.absent(),
    this.lastSyncTimestamp = const Value.absent(),
    this.lastBand = const Value.absent(),
    this.lastMode = const Value.absent(),
    this.lastStationCallsign = const Value.absent(),
    this.lastPower = const Value.absent(),
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
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? qrzUsername,
    Expression<String>? logbookApiKey,
    Expression<DateTime>? lastSyncTimestamp,
    Expression<String>? lastBand,
    Expression<String>? lastMode,
    Expression<String>? lastStationCallsign,
    Expression<String>? lastPower,
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
          ..write('lastPower: $lastPower')
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
  late final $QsosTable qsos = $QsosTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $SyncLogsTable syncLogs = $SyncLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    qsos,
    appSettings,
    syncLogs,
  ];
}

typedef $$QsosTableCreateCompanionBuilder =
    QsosCompanion Function({
      Value<int> id,
      Value<String?> qrzLogid,
      required String callsign,
      required DateTime qsoDate,
      required String band,
      Value<String?> freq,
      required String mode,
      Value<String?> rstSent,
      Value<String?> rstRcvd,
      Value<String> syncStatus,
      Value<String?> rawAdif,
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
    });
typedef $$QsosTableUpdateCompanionBuilder =
    QsosCompanion Function({
      Value<int> id,
      Value<String?> qrzLogid,
      Value<String> callsign,
      Value<DateTime> qsoDate,
      Value<String> band,
      Value<String?> freq,
      Value<String> mode,
      Value<String?> rstSent,
      Value<String?> rstRcvd,
      Value<String> syncStatus,
      Value<String?> rawAdif,
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

  ColumnFilters<String> get freq => $composableBuilder(
    column: $table.freq,
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

  ColumnOrderings<String> get freq => $composableBuilder(
    column: $table.freq,
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

  GeneratedColumn<String> get freq =>
      $composableBuilder(column: $table.freq, builder: (column) => column);

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
                Value<String?> freq = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String?> rstSent = const Value.absent(),
                Value<String?> rstRcvd = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> rawAdif = const Value.absent(),
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
              }) => QsosCompanion(
                id: id,
                qrzLogid: qrzLogid,
                callsign: callsign,
                qsoDate: qsoDate,
                band: band,
                freq: freq,
                mode: mode,
                rstSent: rstSent,
                rstRcvd: rstRcvd,
                syncStatus: syncStatus,
                rawAdif: rawAdif,
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
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> qrzLogid = const Value.absent(),
                required String callsign,
                required DateTime qsoDate,
                required String band,
                Value<String?> freq = const Value.absent(),
                required String mode,
                Value<String?> rstSent = const Value.absent(),
                Value<String?> rstRcvd = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> rawAdif = const Value.absent(),
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
              }) => QsosCompanion.insert(
                id: id,
                qrzLogid: qrzLogid,
                callsign: callsign,
                qsoDate: qsoDate,
                band: band,
                freq: freq,
                mode: mode,
                rstSent: rstSent,
                rstRcvd: rstRcvd,
                syncStatus: syncStatus,
                rawAdif: rawAdif,
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
      Value<String?> lastBand,
      Value<String?> lastMode,
      Value<String?> lastStationCallsign,
      Value<String?> lastPower,
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
              }) => AppSettingsCompanion(
                id: id,
                qrzUsername: qrzUsername,
                logbookApiKey: logbookApiKey,
                lastSyncTimestamp: lastSyncTimestamp,
                lastBand: lastBand,
                lastMode: lastMode,
                lastStationCallsign: lastStationCallsign,
                lastPower: lastPower,
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
              }) => AppSettingsCompanion.insert(
                id: id,
                qrzUsername: qrzUsername,
                logbookApiKey: logbookApiKey,
                lastSyncTimestamp: lastSyncTimestamp,
                lastBand: lastBand,
                lastMode: lastMode,
                lastStationCallsign: lastStationCallsign,
                lastPower: lastPower,
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
  $$QsosTableTableManager get qsos => $$QsosTableTableManager(_db, _db.qsos);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$SyncLogsTableTableManager get syncLogs =>
      $$SyncLogsTableTableManager(_db, _db.syncLogs);
}
