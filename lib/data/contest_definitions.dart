class ContestDefinition {
  final String id;
  final String name;
  final String description;
  final List<String> requiredFields;
  final List<String> exchangeFields;
  final String exchangeHint;

  ContestDefinition({
    required this.id,
    required this.name,
    this.description = '',
    this.requiredFields = const [],
    this.exchangeFields = const [],
    required this.exchangeHint,
  });
}

final contestDefinitions = <String, ContestDefinition>{
  'CQ-WW-CW': ContestDefinition(
    id: 'CQ-WW-CW',
    name: 'CQ World Wide DX Contest (CW)',
    description: 'CQ WW DX Contest - CW mode',
    exchangeFields: ['RST', 'CQ Zone'],
    exchangeHint: '599 [CQ Zone]',
  ),
  'CQ-WW-SSB': ContestDefinition(
    id: 'CQ-WW-SSB',
    name: 'CQ World Wide DX Contest (SSB)',
    description: 'CQ WW DX Contest - SSB mode',
    exchangeFields: ['RST', 'CQ Zone'],
    exchangeHint: '599 [CQ Zone]',
  ),
  'CQ-WW-RTTY': ContestDefinition(
    id: 'CQ-WW-RTTY',
    name: 'CQ World Wide DX Contest (RTTY)',
    description: 'CQ WW DX Contest - RTTY mode',
    exchangeFields: ['RST', 'CQ Zone'],
    exchangeHint: '599 [CQ Zone]',
  ),
  'CQ-WPX-CW': ContestDefinition(
    id: 'CQ-WPX-CW',
    name: 'CQ World Picture (CW)',
    description: 'CQ WPX DX Contest - CW mode',
    exchangeFields: ['RST', 'Serial'],
    exchangeHint: '599 [Serial Number]',
  ),
  'CQ-WPX-SSB': ContestDefinition(
    id: 'CQ-WPX-SSB',
    name: 'CQ World Picture (SSB)',
    description: 'CQ WPX DX Contest - SSB mode',
    exchangeFields: ['RST', 'Serial'],
    exchangeHint: '599 [Serial Number]',
  ),
  'ARRL-DX-CW': ContestDefinition(
    id: 'ARRL-DX-CW',
    name: 'ARRL DX Contest (CW)',
    description: 'ARRL DX Contest - CW mode',
    exchangeFields: ['RST', 'State/Prov'],
    exchangeHint: '599 [State/Province]',
  ),
  'ARRL-DX-SSB': ContestDefinition(
    id: 'ARRL-DX-SSB',
    name: 'ARRL DX Contest (SSB)',
    description: 'ARRL DX Contest - SSB mode',
    exchangeFields: ['RST', 'State/Prov'],
    exchangeHint: '599 [State/Province]',
  ),
  'ARRL-SS-CW': ContestDefinition(
    id: 'ARRL-SS-CW',
    name: 'ARRL Sectional Sweepstakes (CW)',
    description: 'ARRL SS Contest - CW mode',
    exchangeFields: ['Serial', 'Category', 'Check', 'Section'],
    exchangeHint: '[Serial] [Category] [Check] [Section]',
  ),
  'ARRL-SS-SSB': ContestDefinition(
    id: 'ARRL-SS-SSB',
    name: 'ARRL Sectional Sweepstakes (SSB)',
    description: 'ARRL SS Contest - SSB mode',
    exchangeFields: ['Serial', 'Category', 'Check', 'Section'],
    exchangeHint: '[Serial] [Category] [Check] [Section]',
  ),
  'ARRL-FIELD-DAY': ContestDefinition(
    id: 'ARRL-FIELD-DAY',
    name: 'ARRL Field Day',
    description: 'ARRL Field Day Contest',
    exchangeFields: ['Class', 'Section'],
    exchangeHint: '[Class] [Section]',
  ),
  'IARU-HF': ContestDefinition(
    id: 'IARU-HF',
    name: 'IARU HF Contest',
    description: 'IARU HF Band Contest',
    exchangeFields: ['RST', 'ITU Zone'],
    exchangeHint: '599 [ITU Zone]',
  ),
  'ALL-ASIAN-DX-CW': ContestDefinition(
    id: 'ALL-ASIAN-DX-CW',
    name: 'All Asian DX Contest (CW)',
    description: 'All Asian DX Contest - CW mode',
    exchangeFields: ['RST', 'CQ Zone'],
    exchangeHint: '599 [CQ Zone]',
  ),
  'ALL-ASIAN-DX-SSB': ContestDefinition(
    id: 'ALL-ASIAN-DX-SSB',
    name: 'All Asian DX Contest (SSB)',
    description: 'All Asian DX Contest - SSB mode',
    exchangeFields: ['RST', 'CQ Zone'],
    exchangeHint: '599 [CQ Zone]',
  ),
  'CQ-160-CW': ContestDefinition(
    id: 'CQ-160-CW',
    name: 'CQ 160m DX Contest (CW)',
    description: 'CQ 160m DX Contest - CW mode',
    exchangeFields: ['RST', 'CQ Zone'],
    exchangeHint: '599 [CQ Zone]',
  ),
  'CQ-160-SSB': ContestDefinition(
    id: 'CQ-160-SSB',
    name: 'CQ 160m DX Contest (SSB)',
    description: 'CQ 160m DX Contest - SSB mode',
    exchangeFields: ['RST', 'CQ Zone'],
    exchangeHint: '599 [CQ Zone]',
  ),
  'CQ-160-RTTY': ContestDefinition(
    id: 'CQ-160-RTTY',
    name: 'CQ 160m DX Contest (RTTY)',
    description: 'CQ 160m DX Contest - RTTY mode',
    exchangeFields: ['RST', 'CQ Zone'],
    exchangeHint: '599 [CQ Zone]',
  ),
};
