import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../providers/app_providers.dart';
import '../../database/app_database.dart';
import '../theme.dart';
import 'sync_log_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _apiKeyController = TextEditingController();
  bool _isLoading = true;
  AppSetting? _settings;

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
        _usernameController.text = settings?.qrzUsername ?? '';
        _apiKeyController.text = settings?.logbookApiKey ?? '';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);
    final companion = AppSettingsCompanion(
      qrzUsername: drift.Value(_usernameController.text),
      logbookApiKey: drift.Value(_apiKeyController.text),
    );

    if (_settings == null) {
      await db.into(db.appSettings).insert(companion);
    } else {
      await (db.update(db.appSettings)..where((t) => t.id.equals(_settings!.id)))
          .write(companion);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved successfully')),
      );
      _loadSettings();
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'QRZ.COM CONFIGURATION',
                      style: theme.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'QRZ USERNAME',
                        hintText: 'Enter your callsign',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _apiKeyController,
                      decoration: const InputDecoration(
                        labelText: 'LOGBOOK API KEY',
                        hintText: 'Enter your QRZ Logbook API Key',
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                      ),
                      obscureText: true,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _saveSettings,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('SAVE SETTINGS'),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: AppTheme.outlineVariant),
                    const SizedBox(height: 24),
                    Text(
                      'APP INFORMATION',
                      style: theme.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('Version', '1.0.0'),
                    _buildInfoRow('Database Schema', 'v4'),
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
                        child: Text(
                          'HORIZON QRZ',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppTheme.outline,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  int _tapCount = 0;

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant)),
          Text(value, style: Theme.of(context).textTheme.labelMono),
        ],
      ),
    );
  }
}
