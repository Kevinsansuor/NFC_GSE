import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';

class NfcTagAdapter implements NfcData {
  final NfcTag tag;

  NfcTagAdapter(this.tag);

  @override
  String get id {
    final identifier = tag.data['nfca']?['identifier'] ?? tag.data['identifier'];
    return identifier != null ? _formatIdentifier(identifier) : 'ID desconocido';
  }

  @override
String get type {
  final technologyMap = {
    'isodep': 'IsoDep',
    'nfca': 'Nfc-A',
    'nfcb': 'Nfc-B',
    'nfcc': 'Nfc-C',
    'nfcf': 'Nfc-F',
    'nfcv': 'Nfc-V',
    'mifareclassic': 'Mifare Classic',
    'mifareultralight': 'Mifare Ultralight',
  };

  final technologies = technologyMap.entries
      .where((entry) => tag.data.containsKey(entry.key))
      .map((entry) => entry.value)
      .toList();

  return technologies.isNotEmpty ? technologies.join(', ') : 'Tipo desconocido';
}


  @override
  Map<String, dynamic> get additionalData {
    return tag.data;
  }

  @override
  String toString() {
    return '''
ID: $id
Tipo: $type
Datos Adicionales: ${jsonEncode(additionalData)}
''';
  }

  String _formatIdentifier(dynamic identifier) {
    if (identifier is List) {
      return identifier.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(':').toUpperCase();
    }
    return identifier.toString();
  }
}

abstract class NfcData {
  String get id;
  String get type;
  Map<String, dynamic> get additionalData;
}
