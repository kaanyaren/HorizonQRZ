import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
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
    await db.into(db.qsos).insert(
      QsosCompanion.insert(
        callsign: _callsignController.text.toUpperCase(),
        qsoDate: DateTime.now().toUtc(),
        band: _selectedBand,
        mode: _selectedMode,
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
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        children: [
          SizedBox(height: 2.h),
          _buildHeader(theme),
          SizedBox(height: 2.h),

          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildStationSection(theme),
                SizedBox(height: 2.h),
                _buildRadioSection(theme),
                SizedBox(height: 2.h),
                _buildReportSection(theme),
                SizedBox(height: 2.h),
                _buildNotesSection(theme),
              ],
            ),
          ),
          
          SizedBox(height: 3.h),
          _buildActionsSection(),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LOGGER', style: theme.textTheme.labelMono.copyWith(fontSize: 8.sp, color: AppTheme.primary, letterSpacing: 2)),
            Text('NEW QSO', style: theme.textTheme.displayLarge?.copyWith(fontSize: 18.sp, height: 1.1)),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('UTC TIME', style: theme.textTheme.labelMono.copyWith(fontSize: 7.sp, color: Colors.white70)),
              Text(DateFormat('HH:mm:ss').format(_utcTime), 
                style: theme.textTheme.labelMono.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStationSection(ThemeData theme) {
    return InstrumentCard(
      accentColor: AppTheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('STATION DETAILS'),
          SizedBox(height: 1.5.h),
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
                      style: theme.textTheme.labelMono.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (val) => _doLookup(val),
                      decoration: InputDecoration(
                        hintText: '---',
                        suffixIcon: _isLookingUp ? const SizedBox(width: 20, height: 20, child: Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(strokeWidth: 2))) : null,
                      ),
                      validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('NAME'),
                    TextFormField(
                      controller: _nameController,
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 10.sp),
                      decoration: const InputDecoration(hintText: 'Operator Name'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_lookupData != null) ...[
            SizedBox(height: 1.5.h),
            _buildLookupPreview(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildLookupPreview(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          if (_lookupData!['image'] != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(_lookupData!['image'], width: 12.w, height: 12.w, fit: BoxFit.cover),
            )
          else
            Icon(Icons.person, size: 10.w, color: AppTheme.onSurfaceVariant.withOpacity(0.5)),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_lookupData!['qth'] ?? 'Unknown QTH', style: theme.textTheme.labelLarge?.copyWith(fontSize: 9.sp)),
                Text(_lookupData!['country'] ?? '', style: theme.textTheme.bodySmall?.copyWith(fontSize: 8.sp, color: AppTheme.onSurfaceVariant)),
              ],
            ),
          ),
          if (_lookupData!['gridsquare'] != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(_lookupData!['gridsquare'], style: theme.textTheme.labelMono.copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold)),
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
          SizedBox(height: 1.5.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('BAND'),
                    DropdownButtonFormField<String>(
                      value: _selectedBand,
                      items: _bands.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                      onChanged: (v) => setState(() => _selectedBand = v!),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('FREQUENCY (MHz)'),
                    TextFormField(
                      controller: _freqController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: theme.textTheme.labelMono,
                      decoration: const InputDecoration(hintText: '0.000'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildFieldLabel('OPERATING MODE'),
          _buildModeSelector(theme),
        ],
      ),
    );
  }

  Widget _buildModeSelector(ThemeData theme) {
    final allModes = _showAllModes ? [..._mainModes, ..._extraModes] : _mainModes;
    
    return Wrap(
      spacing: 2.w,
      runSpacing: 1.h,
      children: [
        ...allModes.map((m) => _buildModeChip(m, _selectedMode == m)),
        ActionChip(
          label: Text(_showAllModes ? 'LESS' : 'MORE'),
          onPressed: () => setState(() => _showAllModes = !_showAllModes),
          backgroundColor: AppTheme.surfaceContainerHighest,
          labelStyle: theme.textTheme.labelLarge?.copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
          padding: EdgeInsets.zero,
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
              _rstSentController.text = '00';
              _rstRcvdController.text = '00';
            } else {
              _rstSentController.text = '59';
              _rstRcvdController.text = '59';
            }
          });
        }
      },
      showCheckmark: false,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      selectedColor: AppTheme.primary,
      labelStyle: Theme.of(context).textTheme.labelMono.copyWith(
        fontSize: 9.sp,
        color: selected ? Colors.white : AppTheme.onSurfaceVariant,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
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
          SizedBox(height: 1.5.h),
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
        SizedBox(height: 2.h),
        _buildRstRow('RCVD', _rstRcvdController),
      ],
    );
  }

  Widget _buildRstRow(String label, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(width: 14.w, child: _buildFieldLabel(label)),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMono.copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          flex: 6,
          child: SizedBox(
            height: 4.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _rstValues.length,
              separatorBuilder: (_, __) => SizedBox(width: 2.w),
              itemBuilder: (context, index) {
                final val = _rstValues[index];
                final isSelected = controller.text == val;
                return GestureDetector(
                  onTap: () => setState(() => controller.text = val),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.tertiary : AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: isSelected ? Colors.transparent : AppTheme.outlineVariant),
                    ),
                    child: Text(val, style: Theme.of(context).textTheme.labelMono.copyWith(
                      fontSize: 9.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : AppTheme.onSurfaceVariant,
                    )),
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
        SizedBox(width: 4.w),
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
          value: _ft8RstValues.contains(controller.text) ? controller.text : '00',
          style: Theme.of(context).textTheme.labelMono.copyWith(fontSize: 11.sp, color: AppTheme.onSurface),
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
          SizedBox(height: 1.h),
          TextFormField(
            controller: _commentsController,
            maxLines: 3,
            style: theme.textTheme.bodyMedium,
            decoration: const InputDecoration(
              hintText: 'QTH, Rig details, Signal quality, etc...',
              contentPadding: EdgeInsets.all(12),
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
              padding: EdgeInsets.symmetric(vertical: 2.h),
              foregroundColor: AppTheme.error,
              side: BorderSide(color: AppTheme.error.withOpacity(0.5)),
            ),
            child: const Text('CLEAR FORM'),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _saveQso,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              backgroundColor: AppTheme.primary,
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.send_rounded),
                SizedBox(width: 2.w),
                const Text('LOG CONTACT'),
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
          height: 14,
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 2.w),
        Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 9.sp, 
          letterSpacing: 1.2,
          color: AppTheme.primary,
          fontWeight: FontWeight.bold,
        )),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.5.h),
      child: Text(label, style: Theme.of(context).textTheme.labelMono.copyWith(
        fontSize: 7.sp, 
        color: AppTheme.onSurfaceVariant.withOpacity(0.7),
        fontWeight: FontWeight.bold,
      )),
    );
  }
}
