import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_flutter_proyect/widgets/body_text/body_text.dart';
import 'package:nfc_flutter_proyect/widgets/h1_text/tittle_text.dart';
import 'package:nfc_flutter_proyect/widgets/h2_text/large_text.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_flutter_proyect/adapters/nfc/nfc_tag_adapter.dart';

void main() {
  runApp(const NFCApp());
}

class NFCApp extends StatelessWidget {
  const NFCApp({super.key});
  final String title = 'NFC App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.white, brightness: Brightness.dark)
            .copyWith(
          primary: const Color(0xFFdde0e1),
          secondary: const Color(0xFF1b1f1c),
          onPrimaryFixed: const Color.fromARGB(50, 221, 224, 255),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            height: 42 / 42,
          ),
          titleLarge: GoogleFonts.raleway(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            height: 32 / 26,
          ),
          bodyLarge: GoogleFonts.sourceSans3(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            height: 18 / 21,
          ),
          labelLarge: GoogleFonts.sourceSans3(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 18 / 21,
          ),
        ),
      ),
      home: const SafeArea(
        child: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _nfcData = '';
  bool _isReading = false;

  Future<void> _readNFC() async {
  bool isAvailable = await NfcManager.instance.isAvailable();
  if (!isAvailable) {
    _showNfcDialog('Tu dispositivo no soporta la tecnología NFC.');
    return;
  }

  setState(() {
    _isReading = true;
    _nfcData = 'Escaneando etiqueta NFC...';
  });

  try {
    await NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        NfcTagAdapter adapter = NfcTagAdapter(tag);
        String tagInfo = adapter.toString();

        setState(() {
          _nfcData = tagInfo;
        });
        _showNfcDialog(tagInfo);
      },
    );
  } catch (e) {
    String errorMessage = 'Error al leer NFC: $e';
    setState(() {
      _nfcData = errorMessage;
    });
    _showNfcDialog(errorMessage);
  } finally {
    await NfcManager.instance.stopSession();
    setState(() {
      _isReading = false;
    });
  }
}


  void _showNfcDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
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
