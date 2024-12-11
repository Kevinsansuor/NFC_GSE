import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nfc_flutter_proyect/adapters/nfc/nfc_tag_adapter.dart';
import 'package:nfc_flutter_proyect/main.dart';
import 'package:nfc_flutter_proyect/pages/error_nfc/error_nfc_page.dart';
import 'package:nfc_flutter_proyect/pages/valid_nfc/valid_nfc_page.dart';
import 'package:nfc_flutter_proyect/widgets/alerts/nfc_verify_alert.dart';
import 'package:nfc_flutter_proyect/widgets/body_text/body_text.dart';
import 'package:nfc_flutter_proyect/widgets/h1_text/tittle_text.dart';
import 'package:nfc_flutter_proyect/widgets/h2_text/large_text.dart';
import 'package:nfc_manager/nfc_manager.dart';

class VerifyNfcPage extends StatefulWidget {
  const VerifyNfcPage({super.key});

  @override
  State<VerifyNfcPage> createState() => _VerifyNfcPageState();
}

class _VerifyNfcPageState extends State<VerifyNfcPage> {
  // ignore: unused_field
  String _nfcData = '';
  bool _isReading = false;

  Future<void> _readNFC() async {
    final isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ErrorNfcPage()),
        );
      }
      return;
    }

    if (mounted) {
      _showNfcDialog('Escaneando etiqueta NFC...');
    }

    setState(() {
      _isReading = true;
      _nfcData = 'Escaneando...';
    });

    try {
      await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        setState(() {
          _isReading = false;
        });
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pop(context);
        logger.d('Cerrar dialogo');

        try {
          if (tag.data.isNotEmpty) {
            logger.i('NFC tag data: ${tag.data.toString()}');
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ValidNfcPage()),
              );
            }
            return;
          }

          // Procesar la etiqueta NFC
          String nfcTag = NfcTagAdapter(tag).toString();
          setState(() {
            _isReading = false;
            _nfcData = nfcTag;
          });
          _showNfcDialog(nfcTag);
        } catch (e) {
          _showNfcDialog('Error al procesar la etiqueta NFC: $e');
        } finally {
          await NfcManager.instance.stopSession();
          setState(() {
            _isReading = false;
          });
        }
      });

      logger.i('NFC session started');
    } catch (e) {
      if (mounted) {
        _showNfcDialog('Error al iniciar la sesión NFC: $e');
      }
      setState(() {
        _isReading = false;
      });
    }
  }

  void _showNfcDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return NfcResultDialog(message: message);
      },
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('¿Seguro que quieres salir?'),
            content: const Text('Si sales, perderás los avances actuales.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                child: const Text('Salir'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color primaryOpaqueColor =
        Theme.of(context).colorScheme.onPrimaryFixed;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        _onWillPop();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Row(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 25),
                    child: Column(
                      textDirection: TextDirection.ltr,
                      children: [
                        TittleText(
                          text: 'NFC App',
                          color: primaryColor,
                          textStyle: Theme.of(context).textTheme.displayLarge,
                        ),
                        BodyText(
                          textAlign: TextAlign.start,
                          text:
                              'Bienvenido a NFC App, con esta aplicación podrás, escanear, añadir y configurar tarjetas con la tecnología NFC de tu dispositivo Android.',
                          color: primaryColor,
                          textStyle: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.5,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryOpaqueColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Column(
                            textDirection: TextDirection.ltr,
                            children: [
                              LargeText(
                                text: 'Prueba NFC',
                                color: primaryColor,
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                              BodyText(
                                textAlign: TextAlign.start,
                                text:
                                    'Verifiquemos que tu dispositivo tiene la tecnología NFC incorporada.',
                                color: primaryColor,
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        'assets/images/appImages/img_nfc_test.png',
                                      ),
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                    side: BorderSide(
                                        color: primaryOpaqueColor, width: 2.5),
                                    padding: const EdgeInsets.all(25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onPressed: _isReading ? null : _readNFC,
                                  child: const Text('Verificar NFC'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
