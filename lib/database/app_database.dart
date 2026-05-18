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
  TextColumn get mode => text()();
  TextColumn get rstSent => text().nullable()();
  TextColumn get rstRcvd => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))(); // pending, synced, error
  TextColumn get rawAdif => text().nullable()();
}

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get qrzUsername => text().nullable()();
  TextColumn get logbookApiKey => text().nullable()();
  DateTimeColumn get lastSyncTimestamp => dateTime().nullable()();
}

@DriftDatabase(tables: [Qsos, AppSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
