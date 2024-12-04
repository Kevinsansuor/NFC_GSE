import 'package:flutter/material.dart';
import 'package:nfc_flutter_proyect/widgets/body_text/body_text.dart';
import 'package:nfc_flutter_proyect/widgets/h1_text/tittle_text.dart';

class ErrorNfcPage extends StatelessWidget {
  const ErrorNfcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error NFC'),
      ),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 100,
                ),
                SizedBox(height: 20),
                TittleText(
                  text: 'No se detectó NFC',
                ),
                BodyText(
                  text:
                      'Bienvenido a NFC App, con esta aplicación podrás, escanear, añadir y configurar tarjetas con la tecnología NFC de tu dispositivo Android.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
