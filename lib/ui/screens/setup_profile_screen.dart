import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../providers/app_providers.dart';
import '../../services/auth_service.dart';
import '../../services/qrz_xml_service.dart';

class SetupProfileScreen extends ConsumerStatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  ConsumerState<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends ConsumerState<SetupProfileScreen> {
  final _callsignController = TextEditingController();
  final _gridSquareController = TextEditingController();
  final _cqZoneController = TextEditingController();
  final _ituZoneController = TextEditingController();
  final _stateController = TextEditingController();
  final _operatorController = TextEditingController();

  bool _isLoading = false;
  bool _gpsEnabled = false;
  double? _gpsLatitude;
  double? _gpsLongitude;

  @override
  void dispose() {
    _callsignController.dispose();
    _gridSquareController.dispose();
    _cqZoneController.dispose();
    _ituZoneController.dispose();
    _stateController.dispose();
    _operatorController.dispose();
    super.dispose();
  }

  Future<void> _requestGpsPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final permissionResult = await Geolocator.requestPermission();
      if (permissionResult == LocationPermission.denied) {
        setState(() => _gpsEnabled = false);
        return;
      }
    }
    setState(() => _gpsEnabled = true);
    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    if (!_gpsEnabled) return;

    try {
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      setState(() {
        _gpsLatitude = pos.latitude;
        _gpsLongitude = pos.longitude;
      });
    } catch (e) {
      print('GPS error: $e');
    }
  }

  Future<void> _saveProfile() async {
    if (_callsignController.text.trim().isEmpty) {
      _showDialog('Callsign is required');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Get callsign from QRZ
      final qrzXmlService = ref.read(qrzXmlServiceProvider);
      final callsignData = await qrzXmlService.lookup(
        _callsignController.text.trim(),
      );

      final profileData = {
        'id': await Supabase.instance.client.auth.currentUser?.id,
        'callsign': _callsignController.text.trim(),
        'grid_square': _gridSquareController.text.trim(),
        'cq_zone': _cqZoneController.text.trim().isEmpty ? null : int.tryParse(_cqZoneController.text.trim()),
        'itu_zone': _ituZoneController.text.trim().isEmpty ? null : int.tryParse(_ituZoneController.text.trim()),
        'state': _stateController.text.trim(),
        'country': callsignData?['c'] ?? '',
        'operator_name': _operatorController.text.trim(),
      };

      // Upload to Supabase
      await Supabase.instance.client
          .from('profiles')
          .upsert(profileData);

      if (mounted) {
        _showDialog('Profile saved successfully!');
        ref.read(notificationProvider.notifier).clear();
      }
    } catch (e) {
      print('Save error: $e');
      _showDialog('Failed to save profile: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Your Station'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              
              // Callsign
              TextField(
                controller: _callsignController,
                decoration: InputDecoration(
                  labelText: 'Callsign *',
                  hintText: 'e.g., TA1KYN',
                  prefixIcon: const Icon(Icons.business),
                  filled: true,
                  fillColor: Colors.grey[100],
                  errorText: _callsignController.text.isEmpty
                      ? 'Callsign is required'
                      : null,
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),

              // Grid Square
              TextField(
                controller: _gridSquareController,
                decoration: InputDecoration(
                  labelText: 'Grid Square',
                  hintText: 'e.g., KM60',
                  prefixIcon: const Icon(Icons.location_on),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),

              // CQ Zone
              TextField(
                controller: _cqZoneController,
                decoration: InputDecoration(
                  labelText: 'CQ Zone',
                  hintText: '1-40',
                  prefixIcon: const Icon(Icons.map),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                keyboardType: TextInputType.number,
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),

              // ITU Zone
              TextField(
                controller: _ituZoneController,
                decoration: InputDecoration(
                  labelText: 'ITU Zone',
                  hintText: '1-19',
                  prefixIcon: const Icon(Icons.local_fire_department),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                keyboardType: TextInputType.number,
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),

              // State
              TextField(
                controller: _stateController,
                decoration: InputDecoration(
                  labelText: 'State/Province',
                  hintText: 'e.g., VA',
                  prefixIcon: const Icon(Icons.location_city),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),

              // Operator
              TextField(
                controller: _operatorController,
                decoration: InputDecoration(
                  labelText: 'Operator Name',
                  hintText: 'e.g., Gurcan',
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16),

              // GPS Button
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _requestGpsPermission,
                icon: Icon(_gpsEnabled ? Icons.location_on : Icons.my_location),
                label: Text(_gpsEnabled ? 'Location: ${_gpsLatitude?.toStringAsFixed(4)}° N, ${_gpsLongitude?.toStringAsFixed(4)}° E' : 'Get Location'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveProfile,
                icon: _isLoading ? const CircularProgressIndicator() : const Icon(Icons.save),
                label: const Text('Save Profile'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
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
