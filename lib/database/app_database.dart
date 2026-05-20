import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class LocalQsos extends Table {
  TextColumn get id => text()();
  TextColumn get callsign => text().withLength(min: 3, max: 20)();
  DateTimeColumn get qsoDate => dateTime()();
  TextColumn get timeOn => text()();
  TextColumn get band => text()();
  TextColumn get mode => text()();
  TextColumn get freq => text().nullable()();
  TextColumn get rstSent => text().nullable()();
  TextColumn get rstRcvd => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get qth => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get gridsquare => text().nullable()();
  TextColumn get lat => text().nullable()();
  TextColumn get lon => text().nullable()();
  TextColumn get comment => text().nullable()();
  TextColumn get propMode => text().nullable()();
  TextColumn get satName => text().nullable()();
  TextColumn get txPwr => text().nullable()();
  TextColumn get mySig => text().nullable()();
  TextColumn get sig => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get cqz => text().nullable()();
  TextColumn get contestId => text().nullable()();
  TextColumn get stx => text().nullable()();
  TextColumn get srx => text().nullable()();
  TextColumn get stxString => text().nullable()();
  TextColumn get srxString => text().nullable()();
  TextColumn get stationCallsign => text()();
  TextColumn get stationGridsquare => text().nullable()();
  TextColumn get operator => text().nullable()();
  
  // Sync tracking
  TextColumn get userUuid => text()();
  TextColumn get supabaseId => text()();
  TextColumn get qrzLogId => text().nullable()();
  IntColumn get syncVersion => integer()();
  TextColumn get syncStatus => text()();
}

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get qrzUsername => text().nullable()();
  TextColumn get logbookApiKey => text().nullable()();
  DateTimeColumn get lastSyncTimestamp => dateTime().nullable()();
  
  TextColumn get lastBand => text().nullable()();
  TextColumn get lastMode => text().nullable()();
  TextColumn get lastStationCallsign => text().nullable()();
  TextColumn get lastPower => text().nullable()();

  TextColumn get stationGridsquare => text().nullable()();
  
  TextColumn get userUuid => text()();
  DateTimeColumn get lastPushTimestamp => dateTime().nullable()();
}

class SyncMeta extends Table {
  TextColumn get key => text().withLength(min: 1, max: 50)();
  TextColumn get value => text()();
}

class SyncLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get level => text()();
  TextColumn get message => text()();
  TextColumn get details => text().nullable()();
}

@DriftDatabase(tables: [LocalQsos, AppSettings, SyncMeta, SyncLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 10) {
          // Add qrzLogId column to LocalQsos table
          await m.addColumn(localQsos, localQsos.qrzLogId);
        }
      },
      beforeOpen: (details) async {},
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
