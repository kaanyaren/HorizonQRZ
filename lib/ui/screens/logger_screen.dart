import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../providers/app_providers.dart';
import '../../database/app_database.dart';
import 'package:drift/drift.dart' as drift;
import '../theme.dart';
import '../widgets/instrument_card.dart';

class LoggerScreen extends ConsumerStatefulWidget {
  const LoggerScreen({super.key});

  @override
  ConsumerState<LoggerScreen> createState() => _LoggerScreenState();
}

class _LoggerScreenState extends ConsumerState<LoggerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _callsignController = TextEditingController();
  final _freqController = TextEditingController();
  final _nameController = TextEditingController();
  final _commentsController = TextEditingController();
  final _rstSentController = TextEditingController(text: '59');
  final _rstRcvdController = TextEditingController(text: '59');
  
  String _selectedBand = '20m';
  String _selectedMode = 'SSB';
  bool _showAllModes = false;
  bool _isLookingUp = false;
  Map<String, dynamic>? _lookupData;
  
  late Timer _timer;
  DateTime _utcTime = DateTime.now().toUtc();

  final List<String> _bands = ['160m', '80m', '60m', '40m', '30m', '20m', '17m', '15m', '12m', '10m', '6m', '2m', '70cm'];
  final List<String> _mainModes = ['SSB', 'CW', 'FT8', 'FT4', 'FM', 'AM', 'RTTY'];
  final List<String> _extraModes = ['JT65', 'JT9', 'PSK31', 'PSK63', 'VARA', 'ARDOP', 'OLIVIA', 'THOR', 'MFSK', 'SSTV'];
  final List<String> _rstValues = ['59', '58', '57', '56', '55', '53', '51', '599', '579', '559'];
  final List<String> _ft8RstValues = List.generate(48, (index) => (index - 23).toString());

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _utcTime = DateTime.now().toUtc());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _callsignController.dispose();
    _freqController.dispose();
    _nameController.dispose();
    _commentsController.dispose();
    _rstSentController.dispose();
    _rstRcvdController.dispose();
    super.dispose();
  }

  Future<void> _doLookup(String call) async {
    if (call.length < 3) return;
    setState(() => _isLookingUp = true);
    try {
      final xmlService = ref.read(qrzXmlServiceProvider);
      final result = await xmlService.lookup(call);
      if (mounted) {
        setState(() {
          _lookupData = result;
          if (result != null) {
            if (_nameController.text.isEmpty) {
              _nameController.text = '${result['fname'] ?? ''} ${result['name'] ?? ''}'.trim();
            }
            if (_commentsController.text.isEmpty) {
              _commentsController.text = result['qth'] ?? '';
            }
          }
        });
      }
    } catch (e) {
      // Quietly fail lookup
    } finally {
      if (mounted) setState(() => _isLookingUp = false);
    }
  }

  Future<void> _saveQso() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);
    await db.into(db.localQsos).insert(
      LocalQsosCompanion.insert(
        id: DateTime.now().toIso8601String(),
        callsign: _callsignController.text.toUpperCase(),
        userUuid: '',
        supabaseId: DateTime.now().toIso8601String(),
        qsoDate: DateTime.now().toUtc(),
        timeOn: DateFormat('HHmmss').format(DateTime.now().toUtc()),
        band: _selectedBand,
        mode: _selectedMode,
        stationCallsign: '',
        syncStatus: 'pending_upload',
        syncVersion: 0,
        freq: drift.Value(_freqController.text),
        rstSent: drift.Value(_rstSentController.text),
        rstRcvd: drift.Value(_rstRcvdController.text),
        name: drift.Value(_nameController.text),
        comment: drift.Value(_commentsController.text),
      ),
    );

    ref.read(notificationProvider.notifier).notify('QSO Logged Successfully', title: 'LOGBOOK');

    _clearForm();
  }

  void _clearForm() {
    _callsignController.clear();
    _freqController.clear();
    _nameController.clear();
    _commentsController.clear();
    setState(() {
      _selectedMode = 'SSB';
      _rstSentController.text = '59';
      _rstRcvdController.text = '59';
      _lookupData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
          children: [
            const SizedBox(height: 4),
            _buildHeader(theme),
            const SizedBox(height: 16),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildStationSection(theme),
                  const SizedBox(height: 16),
                  _buildRadioSection(theme),
                  const SizedBox(height: 16),
                  _buildReportSection(theme),
                  const SizedBox(height: 16),
                  _buildNotesSection(theme),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            _buildActionsSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LOGGER', 
                style: theme.textTheme.labelMono.copyWith(
                  fontSize: 10, 
                  color: AppTheme.primary, 
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'NEW QSO', 
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: 24, 
                  height: 1.1,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primary, AppTheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'UTC TIME', 
                  style: theme.textTheme.labelMono.copyWith(
                    fontSize: 8, 
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormat('HH:mm:ss').format(_utcTime), 
                  style: theme.textTheme.labelMono.copyWith(
                    color: Colors.white, 
                    fontWeight: FontWeight.w900, 
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationSection(ThemeData theme) {
    return InstrumentCard(
      accentColor: AppTheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('STATION DETAILS'),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('CALLSIGN'),
                    TextFormField(
                      controller: _callsignController,
                      style: theme.textTheme.labelMono.copyWith(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (val) => _doLookup(val),
                      decoration: InputDecoration(
                        hintText: 'e.g. W1AW',
                        prefixIcon: const Icon(Icons.radio_rounded, color: AppTheme.primary),
                        suffixIcon: _isLookingUp 
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 18, 
                                  height: 18, 
                                  child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primary),
                                ),
                              ) 
                            : null,
                      ),
                      validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('NAME'),
                    TextFormField(
                      controller: _nameController,
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      decoration: const InputDecoration(
                        hintText: 'Operator Name',
                        prefixIcon: Icon(Icons.person_outline_rounded, color: AppTheme.outline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_lookupData != null) ...[
            const SizedBox(height: 14),
            _buildLookupPreview(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildLookupPreview(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primary.withOpacity(0.15), width: 1.2),
      ),
      child: Row(
        children: [
          if (_lookupData!['image'] != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(_lookupData!['image'], width: 44, height: 44, fit: BoxFit.cover),
            )
          else
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.account_box_rounded, size: 24, color: AppTheme.primary),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _lookupData!['qth'] ?? 'Unknown QTH', 
                  style: theme.textTheme.headlineSmall?.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  _lookupData!['country'] ?? '', 
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 11, color: AppTheme.onSurfaceVariant, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          if (_lookupData!['gridsquare'] != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primary, AppTheme.secondary],
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                _lookupData!['gridsquare'], 
                style: theme.textTheme.labelMono.copyWith(
                  fontSize: 10, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRadioSection(ThemeData theme) {
    return InstrumentCard(
      accentColor: AppTheme.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('RADIO SETTINGS'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('BAND'),
                    DropdownButtonFormField<String>(
                      value: _selectedBand,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.waves_rounded, color: AppTheme.secondary),
                      ),
                      items: _bands.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                      onChanged: (v) => setState(() => _selectedBand = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('FREQUENCY (MHz)'),
                    TextFormField(
                      controller: _freqController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: theme.textTheme.labelMono.copyWith(color: AppTheme.secondary, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintText: '0.000',
                        prefixIcon: Icon(Icons.settings_input_antenna_rounded, color: AppTheme.secondary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFieldLabel('OPERATING MODE'),
          const SizedBox(height: 6),
          _buildModeSelector(theme),
        ],
      ),
    );
  }

  Widget _buildModeSelector(ThemeData theme) {
    final allModes = _showAllModes ? [..._mainModes, ..._extraModes] : _mainModes;
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...allModes.map((m) => _buildModeChip(m, _selectedMode == m)),
        ActionChip(
          label: Text(_showAllModes ? 'LESS' : 'MORE'),
          onPressed: () => setState(() => _showAllModes = !_showAllModes),
          backgroundColor: AppTheme.surfaceContainerLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppTheme.outlineVariant, width: 1.2),
          ),
          labelStyle: theme.textTheme.labelLarge?.copyWith(
            fontSize: 9, 
            fontWeight: FontWeight.bold,
            color: AppTheme.primary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        ),
      ],
    );
  }

  Widget _buildModeChip(String label, bool selected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (val) {
        if (val) {
          setState(() {
            _selectedMode = label;
            if (label == 'FT8' || label == 'FT4') {
              _rstSentController.text = '0';
              _rstRcvdController.text = '0';
            } else {
              _rstSentController.text = '59';
              _rstRcvdController.text = '59';
            }
          });
        }
      },
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: selected ? Colors.transparent : AppTheme.outlineVariant,
          width: 1.2,
        ),
      ),
      selectedColor: AppTheme.primary,
      backgroundColor: Colors.white,
      labelStyle: Theme.of(context).textTheme.labelMono.copyWith(
        fontSize: 10,
        color: selected ? Colors.white : AppTheme.onSurfaceVariant,
        fontWeight: selected ? FontWeight.bold : FontWeight.w600,
      ),
    );
  }

  Widget _buildReportSection(ThemeData theme) {
    final isDigital = _selectedMode == 'FT8' || _selectedMode == 'FT4';

    return InstrumentCard(
      accentColor: AppTheme.tertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('SIGNAL REPORTS (RST)'),
          const SizedBox(height: 16),
          if (isDigital)
            _buildDigitalRstFields(theme)
          else
            _buildStandardRstFields(theme),
        ],
      ),
    );
  }

  Widget _buildStandardRstFields(ThemeData theme) {
    return Column(
      children: [
        _buildRstRow('SENT', _rstSentController),
        const SizedBox(height: 16),
        _buildRstRow('RCVD', _rstRcvdController),
      ],
    );
  }

  Widget _buildRstRow(String label, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(
          width: 54, 
          child: _buildFieldLabel(label),
        ),
        Container(
          width: 64,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.outlineVariant, width: 1.2),
          ),
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMono.copyWith(
              fontSize: 14, 
              fontWeight: FontWeight.w900,
              color: AppTheme.primary,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              filled: false,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _rstValues.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final val = _rstValues[index];
                final isSelected = controller.text == val;
                return GestureDetector(
                  onTap: () => setState(() => controller.text = val),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: isSelected 
                          ? const LinearGradient(colors: [AppTheme.tertiary, AppTheme.secondary])
                          : null,
                      color: isSelected ? null : AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : AppTheme.outlineVariant,
                        width: 1.2,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: AppTheme.tertiary.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ] : null,
                    ),
                    child: Text(
                      val, 
                      style: Theme.of(context).textTheme.labelMono.copyWith(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
                        color: isSelected ? Colors.white : AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitalRstFields(ThemeData theme) {
    return Row(
      children: [
        Expanded(child: _buildDigitalRstPicker('SENT', _rstSentController)),
        const SizedBox(width: 16),
        Expanded(child: _buildDigitalRstPicker('RCVD', _rstRcvdController)),
      ],
    );
  }

  Widget _buildDigitalRstPicker(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel(label),
        DropdownButtonFormField<String>(
          value: _ft8RstValues.contains(controller.text) ? controller.text : _ft8RstValues.first,
          style: Theme.of(context).textTheme.labelMono.copyWith(fontSize: 12, color: AppTheme.onSurface),
          items: _ft8RstValues.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
          onChanged: (v) => setState(() => controller.text = v!),
        ),
      ],
    );
  }

  Widget _buildNotesSection(ThemeData theme) {
    return InstrumentCard(
      accentColor: AppTheme.outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('COMMENTS / NOTES'),
          const SizedBox(height: 10),
          TextFormField(
            controller: _commentsController,
            maxLines: 3,
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              hintText: 'QTH, Rig details, Signal quality, etc...',
              contentPadding: EdgeInsets.all(14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _clearForm,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              foregroundColor: AppTheme.error,
              side: const BorderSide(color: AppTheme.error, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('CLEAR FORM'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _saveQso,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppTheme.primary,
              elevation: 4,
              shadowColor: AppTheme.primary.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.send_rounded, color: Colors.white),
                const SizedBox(width: 8),
                const Text('LOG CONTACT', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primary, AppTheme.secondary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title, 
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 10, 
            letterSpacing: 1.2,
            color: AppTheme.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label, 
        style: Theme.of(context).textTheme.labelMono.copyWith(
          fontSize: 9, 
          color: AppTheme.onSurfaceVariant.withOpacity(0.8),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
