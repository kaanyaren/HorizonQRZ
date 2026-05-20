import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_providers.dart';

class LookupScreen extends ConsumerStatefulWidget {
  const LookupScreen({super.key});

  @override
  ConsumerState<LookupScreen> createState() => _LookupScreenState();
}

class _LookupScreenState extends ConsumerState<LookupScreen> {
  final _controller = TextEditingController();
  Map<String, dynamic>? _data;
  bool _isLoading = false;

  Future<void> _search() async {
    if (_controller.text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final xmlService = ref.read(qrzXmlServiceProvider);
      final result = await xmlService.lookup(_controller.text);
      setState(() => _data = result);
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
      appBar: AppBar(title: const Text('Callsign Lookup')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Callsign',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
                border: const OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.characters,
              onSubmitted: (_) => _search(),
            ),
          ),
          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_data != null)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  if (_data!['image'] != null)
                    Image.network(_data!['image'], height: 200, fit: BoxFit.contain),
                  const SizedBox(height: 24),
                  _buildDetailRow('Callsign', _data!['call'] ?? ''),
                  _buildDetailRow('Name', '${_data!['fname'] ?? ''} ${_data!['name'] ?? ''}'),
                  _buildDetailRow('Address', '${_data!['addr1'] ?? ''}\n${_data!['addr2'] ?? ''}'),
                  _buildDetailRow('State', _data!['state'] ?? 'N/A'),
                  _buildDetailRow('Country', _data!['country'] ?? 'N/A'),
                  _buildDetailRow('QSL Manager', _data!['qslmgr'] ?? 'N/A'),
                ],
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Text('Search for a callsign to see details'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
        ],
      ),
    );
  }
}
