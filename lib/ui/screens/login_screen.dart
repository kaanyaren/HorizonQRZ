import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../../providers/app_providers.dart';
import '../../providers/sync_provider.dart';
import '../../database/app_database.dart';
import 'package:drift/drift.dart' as drift;
import '../widgets/banner_ad_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'ta1kyn');
  final _passwordController = TextEditingController(text: 'gurcan');
  final _apiKeyController = TextEditingController(text: '4641-A08E-BE39-4503');
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

      // Fetch all logs from QRZ after successful login
      ref.read(syncProvider.notifier).fetchAndSyncAllLogs();

      ref.read(authStateProvider.notifier).setAuthenticated(true);
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
    final isMobile = SizerUtil.deviceType == DeviceType.mobile;

    return Scaffold(
      body: Column(
        children: [
          const BannerAdWidget(),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 6.w : 2.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isMobile ? 100.w : 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('HorizonQRZLogo_Transparent.png', height: isMobile ? 15.h : 20.h),
                        SizedBox(height: 3.h),
                        Text(
                          'HorizonQRZ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6.h),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'QRZ Username',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        SizedBox(height: 2.h),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'QRZ Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        SizedBox(height: 2.h),
                        TextFormField(
                          controller: _apiKeyController,
                          decoration: const InputDecoration(
                            labelText: 'Logbook API Key',
                            prefixIcon: Icon(Icons.vpn_key),
                            helperText: 'Found in QRZ Logbook Settings',
                          ),
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        SizedBox(height: 4.h),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          child: _isLoading
                              ? SizedBox(
                                  width: 2.h,
                                  height: 2.h,
                                  child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : const Text('Connect to QRZ'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

