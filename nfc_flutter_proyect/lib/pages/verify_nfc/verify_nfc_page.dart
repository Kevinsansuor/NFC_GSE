import 'package:flutter/material.dart';
import 'package:nfc_flutter_proyect/adapters/nfc/nfc_tag_adapter.dart';
import 'package:nfc_flutter_proyect/main.dart';
import 'package:nfc_flutter_proyect/pages/error_nfc/error_nfc_page.dart';
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
  String _nfcData = '';
  bool _isReading = false;

  Future<void> _readNFC() async {
  final isAvailable = await NfcManager.instance.isAvailable();
  if (!isAvailable) {
    if (mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ErrorNfcPage()));
    }
    return;
  }

  if (mounted) {
    _showNfcDialog(context, 'Escaneando etiqueta NFC...');
  }
  setState(() {
    _isReading = true;
    _nfcData = 'Escaneando...';
  });

  try {
    // Iniciar sesión NFC
    await NfcManager.instance.startSession(onDiscovered: _handleNfcTag);
    logger.i('NFC session started');
  } on Exception catch (e) {
    if (mounted) {
      _showNfcDialog(context, 'Error al leer NFC: $e');
    }
  }
}


  Future<void> _handleNfcTag(NfcTag tag) async {
    try {
      String nfcTag = NfcTagAdapter(tag).toString();
      setState(() {
        _isReading = false;
        _nfcData = nfcTag;
      });
      Navigator.of(context).pop();
      _showNfcDialog(context, _nfcData);
    } catch (e) {
      _showNfcDialog(context,'Error al procesar la etiqueta NFC: $e');
    } finally {
      await NfcManager.instance.stopSession();
      setState(() {
        _isReading = false;
      });
    }
  }
  void _showNfcDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return NfcResultDialog(message: message);
    },
  );

}

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color primaryOpaqueColor =
        Theme.of(context).colorScheme.onPrimaryFixed;

    return Scaffold(
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
                              textStyle: Theme.of(context).textTheme.titleLarge,
                            ),
                            BodyText(
                              text:
                                  'Verifiquemos que tu dispositivo tiene la tecnología NFC incorporada.',
                              color: primaryColor,
                              textStyle: Theme.of(context).textTheme.bodyLarge,
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
                              padding: const EdgeInsets.symmetric(vertical: 15),
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
    );
  }
}