import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_providers.dart';
import '../../database/app_database.dart';
import 'package:drift/drift.dart' as drift;

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiKeyController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final xmlService = ref.read(qrzXmlServiceProvider);
      final logbookService = ref.read(qrzLogbookServiceProvider);
      final db = ref.read(databaseProvider);

      // 1. Validate XML Auth
      await xmlService.login(_usernameController.text, _passwordController.text);

      // 2. Validate Logbook API Key
      final status = await logbookService.getStatus(_apiKeyController.text);
      if (status['RESULT'] != 'OK') {
        throw Exception(status['REASON'] ?? 'Invalid API Key');
      }

      // 3. Save Settings
      await db.into(db.appSettings).insert(
        AppSettingsCompanion.insert(
          qrzUsername: drift.Value(_usernameController.text),
          logbookApiKey: drift.Value(_apiKeyController.text),
        ),
      );

      ref.read(authStateProvider.notifier).state = true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.radio, size: 80, color: Colors.blueGrey),
                const SizedBox(height: 24),
                const Text(
                  'HorizonQRZ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'QRZ Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'QRZ Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _apiKeyController,
                  decoration: const InputDecoration(
                    labelText: 'Logbook API Key',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.vpn_key),
                    helperText: 'Found in QRZ Logbook Settings',
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Connect to QRZ'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
