import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/app_providers.dart';
import '../../database/app_database.dart';
import 'package:drift/drift.dart' as drift;

class LoggerScreen extends ConsumerStatefulWidget {
  const LoggerScreen({super.key});

  @override
  ConsumerState<LoggerScreen> createState() => _LoggerScreenState();
}

class _LoggerScreenState extends ConsumerState<LoggerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _callsignController = TextEditingController();
  final _rstSentController = TextEditingController(text: '59');
  final _rstRcvdController = TextEditingController(text: '59');
  
  String _selectedBand = '20m';
  String _selectedMode = 'SSB';
  Map<String, dynamic>? _lookupData;
  bool _isLookingUp = false;

  final List<String> _bands = ['160m', '80m', '60m', '40m', '30m', '20m', '17m', '15m', '12m', '10m', '6m', '2m', '70cm'];
  final List<String> _modes = ['SSB', 'CW', 'FT8', 'FT4', 'FM', 'AM', 'RTTY'];

  Future<void> _doLookup(String call) async {
    if (call.length < 3) return;
    setState(() => _isLookingUp = true);
    try {
      final xmlService = ref.read(qrzXmlServiceProvider);
      final result = await xmlService.lookup(call);
      setState(() => _lookupData = result);
    } catch (e) {
      // Handle lookup error
    } finally {
      setState(() => _isLookingUp = false);
    }
  }

  Future<void> _saveQso() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);
    await db.into(db.qsos).insert(
      QsosCompanion.insert(
        callsign: _callsignController.text.toUpperCase(),
        qsoDate: DateTime.now().toUtc(),
        band: _selectedBand,
        mode: _selectedMode,
        rstSent: drift.Value(_rstSentController.text),
        rstRcvd: drift.Value(_rstRcvdController.text),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('QSO Logged Locally')),
    );

    _callsignController.clear();
    setState(() => _lookupData = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log New QSO')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _callsignController,
                decoration: InputDecoration(
                  labelText: 'Callsign',
                  suffixIcon: _isLookingUp ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ) : null,
                ),
                textCapitalization: TextCapitalization.characters,
                onChanged: (val) => _doLookup(val),
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
              if (_lookupData != null) ...[
                const SizedBox(height: 8),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: ListTile(
                    leading: _lookupData!['image'] != null 
                      ? Image.network(_lookupData!['image'], width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.person),
                    title: Text('${_lookupData!['fname'] ?? ''} ${_lookupData!['name'] ?? ''}'),
                    subtitle: Text('${_lookupData!['addr2'] ?? ''}, ${_lookupData!['country'] ?? ''}'),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedBand,
                      decoration: const InputDecoration(labelText: 'Band'),
                      items: _bands.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                      onChanged: (val) => setState(() => _selectedBand = val!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedMode,
                      decoration: const InputDecoration(labelText: 'Mode'),
                      items: _modes.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                      onChanged: (val) => setState(() => _selectedMode = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _rstSentController,
                      decoration: const InputDecoration(labelText: 'RST Sent'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _rstRcvdController,
                      decoration: const InputDecoration(labelText: 'RST Rcvd'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _saveQso,
                icon: const Icon(Icons.add),
                label: const Text('Log QSO'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
