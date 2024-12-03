import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_flutter_proyect/interfaz/nfc/nfc_data.dart';

class NfcTagAdapter implements NfcData {
  final NfcTag tag;

  NfcTagAdapter(this.tag);

  @override
  String get id {
    // Intentar obtener un ID único de la etiqueta
    return tag.data['id']?.toString() ?? tag.data['identifier']?.toString() ?? 'ID desconocido';
  }

  @override
  String get type {
    // Determinar el tipo de etiqueta usando techList
    return tag.data['techList']?.join(', ') ?? 'Tipo desconocido';
  }

  @override
  Map<String, dynamic> get additionalData {
    // Retornar datos adicionales
    return tag.data;
  }

  @override
  String toString() {
    return '''
Etiqueta NFC Detectada:
ID: $id
Tipo: $type
Datos Adicionales: ${additionalData.isNotEmpty ? additionalData : 'Ninguno'}
    ''';
  }
}
