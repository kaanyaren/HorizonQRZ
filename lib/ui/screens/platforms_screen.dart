import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:drift/drift.dart' as drift;
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';
import '../../providers/app_providers.dart';
import '../../database/app_database.dart';

const _secureStorage = FlutterSecureStorage();

class PlatformsScreen extends ConsumerStatefulWidget {
  const PlatformsScreen({super.key});

  @override
  ConsumerState<PlatformsScreen> createState() => _PlatformsScreenState();
}

class _PlatformsScreenState extends ConsumerState<PlatformsScreen> {
  bool _isSyncing = false;
  bool _qrzConfigured = false;
  bool _clublogConfigured = false;
  bool _eqslConfigured = false;

  @override
  void initState() {
    super.initState();
    _loadPlatformStatus();
  }

  Future<void> _loadPlatformStatus() async {
    final qrzKey = await _secureStorage.read(key: 'qrz_logbook_api_key');
    final qrzUser = await _secureStorage.read(key: 'qrz_username');
    final clublogEmail = await _secureStorage.read(key: 'clublog_email');
    final clublogPassword = await _secureStorage.read(key: 'clublog_password');
    final eqslUser = await _secureStorage.read(key: 'eqsl_username');
    final eqslPassword = await _secureStorage.read(key: 'eqsl_password');

    // Also check AppSettings as fallback for QRZ
    final db = ref.read(databaseProvider);
    final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();

    if (mounted) {
      setState(() {
        _qrzConfigured = (qrzKey != null && qrzKey.isNotEmpty && qrzUser != null && qrzUser.isNotEmpty) ||
            (settings?.logbookApiKey != null && settings!.logbookApiKey!.isNotEmpty);
        _clublogConfigured = clublogEmail != null && clublogEmail.isNotEmpty && clublogPassword != null && clublogPassword.isNotEmpty;
        _eqslConfigured = eqslUser != null && eqslUser.isNotEmpty && eqslPassword != null && eqslPassword.isNotEmpty;
      });
    }
  }

  void _showQrzSetupSheet() {
    final qrzUserCtrl = TextEditingController();
    final qrzKeyCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool obscureKey = true;

    _secureStorage.read(key: 'qrz_username').then((v) { if (v != null) qrzUserCtrl.text = v; });
    _secureStorage.read(key: 'qrz_logbook_api_key').then((v) { if (v != null) qrzKeyCtrl.text = v; });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          height: MediaQuery.of(ctx).viewInsets.bottom + 380,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.language_rounded, color: AppTheme.primary, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Text('QRZ.com Logbook Setup',
                          style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Enter your QRZ.com credentials to sync your logbook.',
                      style: GoogleFonts.spaceGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: qrzUserCtrl,
                      decoration: const InputDecoration(
                        labelText: 'QRZ USERNAME (CALLSIGN)',
                        hintText: 'e.g. W1AW',
                        prefixIcon: Icon(Icons.person_outline, color: AppTheme.primary),
                      ),
                      style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: qrzKeyCtrl,
                      obscureText: obscureKey,
                      decoration: InputDecoration(
                        labelText: 'LOGBOOK API KEY',
                        hintText: 'Find in QRZ.com Settings → Logbook',
                        prefixIcon: const Icon(Icons.vpn_key_outlined, color: AppTheme.primary),
                        suffixIcon: IconButton(
                          icon: Icon(obscureKey ? Icons.visibility_off : Icons.visibility, color: AppTheme.outline),
                          onPressed: () => setSheetState(() => obscureKey = !obscureKey),
                        ),
                      ),
                      style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) return;
                          await _secureStorage.write(key: 'qrz_username', value: qrzUserCtrl.text.trim());
                          await _secureStorage.write(key: 'qrz_logbook_api_key', value: qrzKeyCtrl.text.trim());
                          // Also save to AppSettings for backward compatibility
                          final db = ref.read(databaseProvider);
                          final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
                          if (settings != null) {
                            await (db.update(db.appSettings)..where((t) => t.id.equals(settings.id)))
                                .write(AppSettingsCompanion(
                              qrzUsername: drift.Value(qrzUserCtrl.text.trim()),
                              logbookApiKey: drift.Value(qrzKeyCtrl.text.trim()),
                            ));
                          }
                          await _loadPlatformStatus();
                          if (ctx.mounted) Navigator.pop(ctx);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('QRZ.com configured successfully!', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                                backgroundColor: AppTheme.tertiary, behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text('SAVE & CONNECT', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, letterSpacing: 1)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          await _secureStorage.delete(key: 'qrz_username');
                          await _secureStorage.delete(key: 'qrz_logbook_api_key');
                          await _loadPlatformStatus();
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: Text('Disconnect', style: GoogleFonts.spaceGrotesk(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showClublogSetupSheet() {
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final callsignCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool obscurePw = true;

    _secureStorage.read(key: 'clublog_email').then((v) { if (v != null) emailCtrl.text = v; });
    _secureStorage.read(key: 'clublog_callsign').then((v) { if (v != null) callsignCtrl.text = v; });
    _secureStorage.read(key: 'clublog_password').then((v) { if (v != null) passwordCtrl.text = v; });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          height: MediaQuery.of(ctx).viewInsets.bottom + 460,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.secondary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.cloud_done_rounded, color: AppTheme.secondary, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Text('Club Log Setup',
                          style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Upload your QSOs to Club Log for advanced analysis and league tables.',
                      style: GoogleFonts.spaceGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'EMAIL',
                        hintText: 'Your Club Log account email',
                        prefixIcon: Icon(Icons.email_outlined, color: AppTheme.secondary),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: callsignCtrl,
                      decoration: const InputDecoration(
                        labelText: 'CALLSIGN',
                        hintText: 'Your callsign registered with Club Log',
                        prefixIcon: Icon(Icons.abc, color: AppTheme.secondary),
                      ),
                      style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordCtrl,
                      obscureText: obscurePw,
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        hintText: 'Your Club Log password',
                        prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.secondary),
                        suffixIcon: IconButton(
                          icon: Icon(obscurePw ? Icons.visibility_off : Icons.visibility, color: AppTheme.outline),
                          onPressed: () => setSheetState(() => obscurePw = !obscurePw),
                        ),
                      ),
                      style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) return;
                          await _secureStorage.write(key: 'clublog_email', value: emailCtrl.text.trim());
                          await _secureStorage.write(key: 'clublog_callsign', value: callsignCtrl.text.trim().toUpperCase());
                          await _secureStorage.write(key: 'clublog_password', value: passwordCtrl.text);
                          await _loadPlatformStatus();
                          if (ctx.mounted) Navigator.pop(ctx);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Club Log configured successfully!', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                                backgroundColor: AppTheme.tertiary, behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text('SAVE & CONNECT', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, letterSpacing: 1)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          await _secureStorage.delete(key: 'clublog_email');
                          await _secureStorage.delete(key: 'clublog_callsign');
                          await _secureStorage.delete(key: 'clublog_password');
                          await _loadPlatformStatus();
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: Text('Disconnect', style: GoogleFonts.spaceGrotesk(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEqslSetupSheet() {
    final userCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool obscurePw = true;

    _secureStorage.read(key: 'eqsl_username').then((v) { if (v != null) userCtrl.text = v; });
    _secureStorage.read(key: 'eqsl_password').then((v) { if (v != null) passwordCtrl.text = v; });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          height: MediaQuery.of(ctx).viewInsets.bottom + 380,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.tertiary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.mark_email_read_rounded, color: AppTheme.tertiary, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Text('eQSL.cc Setup',
                          style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Automatically send and receive digital QSL cards via eQSL.cc.',
                      style: GoogleFonts.spaceGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: userCtrl,
                      decoration: const InputDecoration(
                        labelText: 'USERNAME (CALLSIGN)',
                        hintText: 'Your eQSL.cc username',
                        prefixIcon: Icon(Icons.person_outline, color: AppTheme.tertiary),
                      ),
                      style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordCtrl,
                      obscureText: obscurePw,
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        hintText: 'Your eQSL.cc password',
                        prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.tertiary),
                        suffixIcon: IconButton(
                          icon: Icon(obscurePw ? Icons.visibility_off : Icons.visibility, color: AppTheme.outline),
                          onPressed: () => setSheetState(() => obscurePw = !obscurePw),
                        ),
                      ),
                      style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) return;
                          await _secureStorage.write(key: 'eqsl_username', value: userCtrl.text.trim());
                          await _secureStorage.write(key: 'eqsl_password', value: passwordCtrl.text);
                          await _loadPlatformStatus();
                          if (ctx.mounted) Navigator.pop(ctx);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('eQSL.cc configured successfully!', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                                backgroundColor: AppTheme.tertiary, behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.tertiary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text('SAVE & CONNECT', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, letterSpacing: 1)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          await _secureStorage.delete(key: 'eqsl_username');
                          await _secureStorage.delete(key: 'eqsl_password');
                          await _loadPlatformStatus();
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: Text('Disconnect', style: GoogleFonts.spaceGrotesk(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _triggerSync() async {
    final importService = ref.read(qrzImportServiceProvider);

    final logbookKey = await _secureStorage.read(key: 'qrz_logbook_api_key');
    if (logbookKey == null || logbookKey.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please configure your QRZ Logbook API Key first.'),
            backgroundColor: Colors.orangeAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    setState(() => _isSyncing = true);

    try {
      final result = await importService.importFromQrz(logbookKey);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.success
                ? 'Sync complete! Imported: ${result.importedCount}, Duplicates: ${result.duplicateCount}'
                : 'Sync failed: ${result.error}',
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
            ),
            backgroundColor: result.success ? AppTheme.tertiary : Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error during sync: $e'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('INTEGRATIONS'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary.withOpacity(0.08), AppTheme.secondary.withOpacity(0.08)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primary.withOpacity(0.15), width: 1.2),
              ),
              child: Row(
                children: [
                  const Icon(Icons.sync_alt_rounded, color: AppTheme.primary, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cloud Synchronization',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Automatically sync QSOs to your favorite online logbooks and platform accounts.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                            fontSize: 9.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Platform Card: QRZ
            _buildPlatformCard(
              context,
              'QRZ.com Logbook',
              'Connect your logs to QRZ Database for award tracking and verification.',
              Icons.language_rounded,
              _qrzConfigured,
              [AppTheme.primary, AppTheme.primary.withOpacity(0.6)],
              onTap: _showQrzSetupSheet,
            ),
            const SizedBox(height: 16),

            // Platform Card: Club Log
            _buildPlatformCard(
              context,
              'Club Log',
              'Upload and analyze your radio operations on Club Log\'s advanced charts.',
              Icons.cloud_done_rounded,
              _clublogConfigured,
              [AppTheme.secondary, AppTheme.secondary.withOpacity(0.6)],
              onTap: _showClublogSetupSheet,
            ),
            const SizedBox(height: 16),

            // Platform Card: eQSL.cc
            _buildPlatformCard(
              context,
              'eQSL.cc Exchange',
              'Send and receive digital QSL cards instantly over the internet.',
              Icons.mark_email_read_rounded,
              _eqslConfigured,
              [AppTheme.tertiary, AppTheme.tertiary.withOpacity(0.6)],
              onTap: _showEqslSetupSheet,
            ),
            const SizedBox(height: 32),

            // Sync All Button
            GestureDetector(
              onTap: _isSyncing ? null : _triggerSync,
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
                    _isSyncing
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.sync_rounded, color: Colors.white, size: 14),
                    const SizedBox(width: 8),
                    Text(
                      _isSyncing ? 'SYNCING LOGBOOKS...' : 'SYNC ALL PLATFORMS',
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
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformCard(
    BuildContext context,
    String name,
    String description,
    IconData icon,
    bool active,
    List<Color> activeGradient, {
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    if (active) {
      return InstrumentCard(
        padding: const EdgeInsets.all(16),
        gradientColors: activeGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: activeGradient[0].withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: activeGradient[0], size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Connected & Fully Synchronized',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: activeGradient[0],
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.tertiary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.tertiary.withOpacity(0.4), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppTheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'ACTIVE',
                        style: theme.textTheme.labelMono.copyWith(
                          color: AppTheme.tertiary,
                          fontSize: 7.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
                fontSize: 9.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LAST SYNC: TODAY',
                  style: theme.textTheme.labelMono.copyWith(
                    fontSize: 8,
                    color: AppTheme.outline,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Configure',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.keyboard_arrow_right_rounded, size: 12, color: AppTheme.primary),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.outlineVariant,
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.outlineVariant.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppTheme.outline, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Not Configured',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.outline,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.outline,
                fontSize: 9.5,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.primary.withOpacity(0.15), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_circle_outline_rounded, size: 10, color: AppTheme.primary),
                      const SizedBox(width: 6),
                      Text(
                        'SETUP PLATFORM',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: 8,
                          color: AppTheme.primary,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
