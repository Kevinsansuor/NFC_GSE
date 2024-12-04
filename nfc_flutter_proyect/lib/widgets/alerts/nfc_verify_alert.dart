import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcResultDialog extends StatelessWidget {
  final String message;

  const NfcResultDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Resultado NFC',
        style: GoogleFonts.sourceSans3(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await NfcManager.instance.stopSession();
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
