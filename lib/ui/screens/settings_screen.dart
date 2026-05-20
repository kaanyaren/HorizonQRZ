import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../providers/app_providers.dart';
import '../../database/app_database.dart';
import '../../utils/distance.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';
import 'sync_log_screen.dart';
import 'export_screen.dart';
import 'platforms_screen.dart';
import '../../services/auth_service.dart';
import 'login_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _gridsquareController = TextEditingController();
  bool _isLoading = true;
  bool _isLocating = false;
  bool _isSaving = false;
  bool _isSyncing = false;
  AppSetting? _settings;

  Future<void> _signOut() async {
    await AuthService.signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Future<void> _syncWithSupabase() async {
    setState(() => _isSyncing = true);
    try {
      final syncService = ref.read(supabaseSyncServiceProvider);
      final result = await syncService.pushLocalChanges();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.success 
                ? 'Synced successfully! Pushed: ${result.pushedCount}' 
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
            content: Text('Error during sync: $e', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final db = ref.read(databaseProvider);
    final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
    
    if (mounted) {
      setState(() {
        _settings = settings;
        _gridsquareController.text = settings?.stationGridsquare ?? '';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final db = ref.read(databaseProvider);
      final userUuid = Supabase.instance.client.auth.currentUser?.id ?? 'guest';
      final companion = AppSettingsCompanion(
        stationGridsquare: drift.Value(_gridsquareController.text.toUpperCase()),
        userUuid: drift.Value(userUuid),
      );

      if (_settings == null) {
        await db.into(db.appSettings).insert(companion);
      } else {
        await (db.update(db.appSettings)..where((t) => t.id.equals(_settings!.id)))
            .write(companion);
      }

      if (mounted) {
        setState(() {
          _isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Settings saved successfully!',
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppTheme.tertiary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        _loadSettings();
      }
    } catch (e, stack) {
      debugPrint('Error saving settings: $e\n$stack');
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to save settings: $e',
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  Future<void> _fillFromLocation() async {
    setState(() => _isLocating = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location services are disabled'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Location permission denied'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permission permanently denied. Enable in Settings.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
      );
      final grid = latLonToGrid(pos.latitude, pos.longitude);
      _gridsquareController.text = grid.substring(0, 6);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to get location: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  @override
  void dispose() {
    _gridsquareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('STATION SETTINGS'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primary,
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'STATION CONFIG',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                        fontSize: 9,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    InstrumentCard(
                      padding: const EdgeInsets.all(16),
                      gradientColors: const [AppTheme.primary, AppTheme.secondary],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _gridsquareController,
                            decoration: InputDecoration(
                              labelText: 'STATION GRID SQUARE',
                              hintText: 'e.g. FN42',
                              prefixIcon: const Icon(Icons.map_outlined, color: AppTheme.primary),
                              suffixIcon: _isLocating
                                  ? const Padding(
                                      padding: EdgeInsets.all(12),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.my_location, color: AppTheme.secondary),
                                      onPressed: _fillFromLocation,
                                      tooltip: 'Auto-fill from GPS',
                                    ),
                            ),
                            style: theme.textTheme.labelMono.copyWith(color: AppTheme.onSurface),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Save Button
                    GestureDetector(
                      onTap: _isSaving ? null : _saveSettings,
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
                            _isSaving
                                ? const SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.save_rounded, color: Colors.white, size: 14),
                            const SizedBox(width: 8),
                            Text(
                              _isSaving ? 'SAVING DATA...' : 'SAVE SETTINGS',
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

                    Text(
                      'STATION TOOLS & UTILITIES',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                        fontSize: 9,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ExportScreen()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppTheme.outlineVariant, width: 1.2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.upload_file_rounded,
                                      color: AppTheme.primary,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'DATA EXPORT',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.onSurface,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'ADIF & contest logging export tools',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppTheme.onSurfaceVariant,
                                      fontSize: 10.5,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PlatformsScreen()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppTheme.outlineVariant, width: 1.2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppTheme.secondary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.cloud_upload_rounded,
                                      color: AppTheme.secondary,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'INTEGRATIONS',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.onSurface,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Connect QRZ, eQSL, & ClubLog sync',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppTheme.onSurfaceVariant,
                                      fontSize: 10.5,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    const Divider(color: AppTheme.outlineVariant),
                    const SizedBox(height: 24),

                    Text(
                      'ACCOUNT & CLOUD SYNC',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                        fontSize: 9,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.outlineVariant, width: 1.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _isSyncing ? null : _syncWithSupabase,
                            icon: _isSyncing 
                                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                : const Icon(Icons.sync),
                            label: Text(_isSyncing ? 'SYNCING...' : 'SYNC LOG DATA', style: const TextStyle(fontWeight: FontWeight.w600)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: _signOut,
                            icon: const Icon(Icons.logout),
                            label: const Text('SIGN OUT', style: TextStyle(fontWeight: FontWeight.w600)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                              side: const BorderSide(color: Colors.redAccent),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    const Divider(color: AppTheme.outlineVariant),
                    const SizedBox(height: 24),

                    Text(
                      'APP INFORMATION',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                        fontSize: 9,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.outlineVariant, width: 1.2),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow('Software Version', '1.0.0'),
                          const Divider(height: 16, color: AppTheme.outlineVariant),
                          _buildInfoRow('Database Engine', 'Drift / SQLite'),
                          const Divider(height: 16, color: AppTheme.outlineVariant),
                          _buildInfoRow('Database Schema', 'v4'),
                          const Divider(height: 16, color: AppTheme.outlineVariant),
                          _buildInfoRow('Status', 'Operational'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _tapCount++;
                          if (_tapCount >= 6) {
                            _tapCount = 0;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SyncLogScreen(),
                              ),
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Text(
                              'HORIZON QRZ',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: AppTheme.outline,
                                letterSpacing: 6,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'TRANSCEIVER COMMAND v1.0.0',
                              style: theme.textTheme.labelMono.copyWith(
                                color: AppTheme.outline.withOpacity(0.6),
                                fontSize: 7.5,
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
            ),
    );
  }

  int _tapCount = 0;

  Widget _buildInfoRow(String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.labelMono.copyWith(
              color: AppTheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
