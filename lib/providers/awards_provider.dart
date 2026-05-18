import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import 'app_providers.dart';

class AwardData {
  final String code;
  final String title;
  final String subtitle;
  final String unitLabel;
  final int current;
  final int total;
  final List<String> stats;
  final List<String> labels;
  final Color accent;
  final bool completed;

  const AwardData({
    required this.code,
    required this.title,
    required this.subtitle,
    required this.unitLabel,
    required this.current,
    required this.total,
    required this.stats,
    required this.labels,
    required this.accent,
    this.completed = false,
  });
}

final awardsProvider = FutureProvider<List<AwardData>>((ref) async {
  final db = ref.watch(databaseProvider);

  final allQsos = await (db.select(db.qsos)
    ..where((t) => t.syncStatus.equals('synced'))
  ).get();

  // DXCC: distinct countries
  final countries = allQsos
    .map((q) => q.country?.trim().toUpperCase())
    .where((c) => c != null && c.isNotEmpty)
    .toSet()
    .cast<String>()
    .toList()
    ..sort();
  final dxccCount = countries.length;

  // WAS: distinct states (US only)
  final usQsos = allQsos
    .where((q) => q.country?.toUpperCase().contains('UNITED STATES') == true)
    .toList();
  final usStates = usQsos
    .map((q) => q.state?.trim().toUpperCase())
    .where((s) => s != null && s.isNotEmpty)
    .toSet()
    .cast<String>()
    .toList()
    ..sort();
  final wasCount = usStates.length;

  // WAZ: distinct CQ zones
  final zones = allQsos
    .map((q) => q.cqz?.trim())
    .where((z) => z != null && z.isNotEmpty)
    .toSet()
    .cast<String>()
    .toList()
    ..sort();
  final wazCount = zones.length;

  // VUCC: distinct 2-char grid squares
  final grids = allQsos
    .map((q) => q.gridsquare?.trim().toUpperCase().substring(0, 2))
    .where((g) => g != null && g.isNotEmpty && RegExp(r'^[A-R]{2}$').hasMatch(g))
    .toSet()
    .cast<String>()
    .toList()
    ..sort();
  final vuccCount = grids.length;

  return [
    AwardData(
      code: 'DXCC',
      title: 'DXCC',
      subtitle: 'DX CENTURY CLUB',
      unitLabel: 'Entities',
      current: dxccCount,
      total: dxccCount >= 340 ? dxccCount : (dxccCount >= 100 ? 340 : 100),
      stats: ['$dxccCount', '${countries.length}', '-'],
      labels: ['WORKED', 'CONFIRMED', 'VERIFIED'],
      accent: const Color(0xFF303E51),
      completed: dxccCount >= 100,
    ),
    AwardData(
      code: 'WAS',
      title: 'WAS',
      subtitle: 'WORKED ALL STATES',
      unitLabel: 'States',
      current: wasCount,
      total: 50,
      stats: ['$wasCount', '-', '-'],
      labels: ['WORKED', 'CONFIRMED', 'ISSUED'],
      accent: const Color(0xFF004633),
      completed: wasCount >= 50,
    ),
    AwardData(
      code: 'WAZ',
      title: 'WAZ',
      subtitle: 'WORKED ALL ZONES',
      unitLabel: 'Zones',
      current: wazCount,
      total: 40,
      stats: ['$wazCount', '-', '-'],
      labels: ['WORKED', 'CONFIRMED', 'MISSING'],
      accent: const Color(0xFF303E51),
      completed: wazCount >= 40,
    ),
    AwardData(
      code: 'VUCC',
      title: 'VUCC',
      subtitle: 'VHF/UHF CENTURY CLUB',
      unitLabel: 'Grids',
      current: vuccCount,
      total: 100,
      stats: ['$vuccCount', '-', '-'],
      labels: ['WORKED', 'CONFIRMED', 'VERIFIED'],
      accent: const Color(0xFF004633),
      completed: vuccCount >= 100,
    ),
  ];
});
