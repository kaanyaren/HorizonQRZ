import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/app_providers.dart';
import '../../services/adif_generator.dart';
import '../../data/contest_definitions.dart';
import '../../services/adif_exporter.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';

class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  final _dateRangeController = TextEditingController();
  String _selectedContest = 'ALL';
  String _selectedBand = 'ALL';
  String _selectedMode = 'ALL';
  int _qsoCount = 0;
  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    _updateQsoCount();
  }

  @override
  void dispose() {
    _dateRangeController.dispose();
    super.dispose();
  }

  void _updateQsoCount() {
    // Ideally query database for filtered QSOs count. We will simulate/keep simple for now.
    setState(() {
      _qsoCount = 124; // Mocked matching log count
    });
  }

  Future<void> _exportAdif() async {
    setState(() {
      _isExporting = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Exporting ADIF logfile...',
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    
    try {
      final adif = AdifGenerator.generateFromQsos(
        [],
        AppSettings(),
        contestId: _selectedContest == 'ALL' ? null : _selectedContest,
      );

      final dir = await getTemporaryDirectory();
      final filename = 'HorizonQRZ_Export_${DateTime.now().toIso8601String().split('T')[0]}.adi';
      final file = File('${dir.path}/$filename');
      await file.writeAsString(adif);

      setState(() {
        _isExporting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ADIF successfully exported to temporary storage!',
            style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppTheme.tertiary,
          action: SnackBarAction(
            label: 'SHARE',
            textColor: Colors.white,
            onPressed: () {
              // Share functionality trigger
            },
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } catch (e) {
      setState(() {
        _isExporting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Export failed: $e'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('DATA EXPORT'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Instrument Card for matching QSOs
              InstrumentCard(
                padding: const EdgeInsets.all(16),
                gradientColors: const [AppTheme.primary, AppTheme.secondary],
                child: Column(
                  children: [
                    Text(
                      'LOGS MATCHING FILTERS',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                        fontSize: 9,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$_qsoCount',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'QSOs',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'ADIF 3.1.4 Compliant format',
                        style: theme.textTheme.labelMono.copyWith(
                          color: AppTheme.primary,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'FILTER CONFIGURATION',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  fontSize: 9,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 16),

              // Contest Dropdown
              DropdownButtonFormField<String>(
                value: _selectedContest,
                decoration: const InputDecoration(
                  labelText: 'Select Contest',
                  prefixIcon: Icon(Icons.emoji_events_rounded, color: AppTheme.primary),
                ),
                dropdownColor: Colors.white,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                items: [
                  const DropdownMenuItem(value: 'ALL', child: Text('All Contests & Operations')),
                  ...contestDefinitions.keys.map((k) => DropdownMenuItem(
                        value: k,
                        child: Text(
                          contestDefinitions[k]!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                ],
                onChanged: (v) {
                  setState(() => _selectedContest = v ?? 'ALL');
                  _updateQsoCount();
                },
              ),
              const SizedBox(height: 16),

              // Date Range Picker Input
              TextField(
                controller: _dateRangeController,
                readOnly: true,
                onTap: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(const Duration(days: 1)),
                    builder: (context, child) {
                      return Theme(
                        data: theme.copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppTheme.primary,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: AppTheme.onSurface,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      _dateRangeController.text =
                          '${picked.start.toIso8601String().split('T')[0]} to ${picked.end.toIso8601String().split('T')[0]}';
                    });
                    _updateQsoCount();
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Operating Date Range',
                  hintText: 'Lifetime history',
                  prefixIcon: Icon(Icons.calendar_today_rounded, color: AppTheme.primary),
                ),
              ),
              const SizedBox(height: 16),

              // Band & Mode Row
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedBand,
                      decoration: const InputDecoration(
                        labelText: 'Band Filter',
                        prefixIcon: Icon(Icons.linear_scale_rounded, color: AppTheme.secondary),
                      ),
                      dropdownColor: Colors.white,
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      items: const [
                        DropdownMenuItem(value: 'ALL', child: Text('All Bands')),
                        DropdownMenuItem(value: '160m', child: Text('160m')),
                        DropdownMenuItem(value: '80m', child: Text('80m')),
                        DropdownMenuItem(value: '40m', child: Text('40m')),
                        DropdownMenuItem(value: '20m', child: Text('20m')),
                        DropdownMenuItem(value: '15m', child: Text('15m')),
                        DropdownMenuItem(value: '10m', child: Text('10m')),
                        DropdownMenuItem(value: '6m', child: Text('6m')),
                        DropdownMenuItem(value: '2m', child: Text('2m')),
                        DropdownMenuItem(value: '70cm', child: Text('70cm')),
                      ],
                      onChanged: (v) {
                        setState(() => _selectedBand = v ?? 'ALL');
                        _updateQsoCount();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedMode,
                      decoration: const InputDecoration(
                        labelText: 'Mode Filter',
                        prefixIcon: Icon(Icons.waves_rounded, color: AppTheme.secondary),
                      ),
                      dropdownColor: Colors.white,
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      items: const [
                        DropdownMenuItem(value: 'ALL', child: Text('All Modes')),
                        DropdownMenuItem(value: 'SSB', child: Text('SSB')),
                        DropdownMenuItem(value: 'CW', child: Text('CW')),
                        DropdownMenuItem(value: 'FT8', child: Text('FT8')),
                        DropdownMenuItem(value: 'FT4', child: Text('FT4')),
                        DropdownMenuItem(value: 'FM', child: Text('FM')),
                        DropdownMenuItem(value: 'AM', child: Text('AM')),
                        DropdownMenuItem(value: 'RTTY', child: Text('RTTY')),
                      ],
                      onChanged: (v) {
                        setState(() => _selectedMode = v ?? 'ALL');
                        _updateQsoCount();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Export Button
              GestureDetector(
                onTap: _isExporting ? null : _exportAdif,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primary, AppTheme.secondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isExporting
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.file_download_rounded, color: Colors.white, size: 14),
                      const SizedBox(width: 8),
                      Text(
                        _isExporting ? 'GENERATING ADIF FILE...' : 'GENERATE ADIF LOGFILE',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 11,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

