import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Qsos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get qrzLogid => text().nullable()();
  TextColumn get callsign => text().withLength(min: 3, max: 20)();
  DateTimeColumn get qsoDate => dateTime()();
  TextColumn get band => text()();
  TextColumn get freq => text().nullable()();
  TextColumn get mode => text()();
  TextColumn get rstSent => text().nullable()();
  TextColumn get rstRcvd => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))(); // pending, synced, error
  TextColumn get rawAdif => text().nullable()();

  // Details and Map
  TextColumn get name => text().nullable()();
  TextColumn get qth => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get gridsquare => text().nullable()();
  TextColumn get lat => text().nullable()();
  TextColumn get lon => text().nullable()();
  TextColumn get comment => text().nullable()();

  // Advanced fields
  TextColumn get propMode => text().nullable()();
  TextColumn get satName => text().nullable()();
  TextColumn get txPwr => text().nullable()();
  TextColumn get mySig => text().nullable()();
  TextColumn get sig => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get cqz => text().nullable()();
}

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get qrzUsername => text().nullable()();
  TextColumn get logbookApiKey => text().nullable()();
  DateTimeColumn get lastSyncTimestamp => dateTime().nullable()();
  
  // Last used settings for UX
  TextColumn get lastBand => text().nullable()();
  TextColumn get lastMode => text().nullable()();
  TextColumn get lastStationCallsign => text().nullable()();
  TextColumn get lastPower => text().nullable()();
}

class SyncLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get level => text()(); // info, warning, error
  TextColumn get message => text()();
  TextColumn get details => text().nullable()();
}

@DriftDatabase(tables: [Qsos, AppSettings, SyncLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          try { await m.addColumn(qsos, qsos.rawAdif); } catch (_) {}
        }
        if (from < 3) {
          try {
            await m.addColumn(qsos, qsos.name);
            await m.addColumn(qsos, qsos.qth);
            await m.addColumn(qsos, qsos.country);
            await m.addColumn(qsos, qsos.gridsquare);
            await m.addColumn(qsos, qsos.lat);
            await m.addColumn(qsos, qsos.lon);
            await m.addColumn(qsos, qsos.comment);
          } catch (_) {}
        }
        if (from < 4) {
          try { await m.addColumn(qsos, qsos.freq); } catch (_) {}
        }
        if (from < 5) {
          try {
            await m.addColumn(qsos, qsos.propMode as GeneratedColumn<Object>);
            await m.addColumn(qsos, qsos.satName as GeneratedColumn<Object>);
            await m.addColumn(qsos, qsos.txPwr as GeneratedColumn<Object>);
            await m.addColumn(qsos, qsos.mySig as GeneratedColumn<Object>);
            await m.addColumn(qsos, qsos.sig as GeneratedColumn<Object>);
            
            await m.addColumn(appSettings, appSettings.lastBand as GeneratedColumn<Object>);
            await m.addColumn(appSettings, appSettings.lastMode as GeneratedColumn<Object>);
            await m.addColumn(appSettings, appSettings.lastStationCallsign as GeneratedColumn<Object>);
            await m.addColumn(appSettings, appSettings.lastPower as GeneratedColumn<Object>);
          } catch (_) {}
        }
        if (from < 6) {
          await m.createTable(syncLogs);
        }
        if (from < 7) {
          try {
            await m.addColumn(qsos, qsos.state as GeneratedColumn<Object>);
            await m.addColumn(qsos, qsos.cqz as GeneratedColumn<Object>);
          } catch (_) {}
        }
      },
      beforeOpen: (details) async {
        // Enable foreign keys if needed
      },
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
