import 'package:nfc_flutter_proyect/interfaz/nfc/nfc_data.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcTagAdapter implements NfcData {
  final NfcTag tag;

  NfcTagAdapter(this.tag);

  @override
  String get id {
    return tag.data['id']?.toString() ?? 'ID desconocido';
  }

  @override
  String get type {
    return tag.data['type']?.toString() ?? 'Tipo desconocido';
  }

  @override
  Map<String, dynamic> get additionalData {
    return tag.data['additionalData'] ?? {};
  }

  @override
  String toString() {
    return '''
Etiqueta NFC:
ID: $id
Tipo: $type
Datos adicionales: ${additionalData.isNotEmpty ? additionalData : 'Ninguno'}
    ''';
  }
}
