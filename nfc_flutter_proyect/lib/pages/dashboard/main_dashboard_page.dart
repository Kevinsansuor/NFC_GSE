import 'package:flutter/material.dart';
import 'package:nfc_flutter_proyect/main.dart';
import 'package:nfc_flutter_proyect/widgets/h1_text/tittle_text.dart';
import 'package:nfc_flutter_proyect/widgets/h2_text/large_text.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MainDashboardPage extends StatefulWidget {
  const MainDashboardPage({super.key});

  @override
  State<MainDashboardPage> createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  final String _id = "Hola desde el emisor NFC!";
  String statusMessage = "Esperando para escribir en la etiqueta...";

  @override
  void initState() {
    logger.d("Iniciando MainDashboardPage");
    super.initState();
    writeNFC();
  }

  void writeNFC() async {
    try {
      logger.d("Iniciando proceso de envío...");

      setState(() => statusMessage = "Esperando etiqueta NFC...");
      logger.d("Esperando a que el dispositivo detecte una etiqueta NFC.");

      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          Ndef? ndef = Ndef.from(tag);
          if (ndef == null || !ndef.isWritable) {
            setState(() => statusMessage = "La etiqueta no es compatible");
            logger.d("Error: Etiqueta no es compatible con NDEF.");
            return;
          }

          NdefRecord record = NdefRecord.createText('Hola desde el emisor NFC!');
          NdefMessage message = NdefMessage([record]);
          await ndef.write(message);
          setState(() {
            statusMessage = "Mensaje enviado exitosamente";
          });

          //NdefMessage
          //Ndef(tag: tag, isWritable: true, maxSize: 100, cachedMessage: );
          logger.d('peneeeeeeeeeeeeeee: ${Ndef.from(tag)}');
          logger.d('Tag: ${Ndef.from(tag.data as NfcTag)}');
          try {
            logger.d("Etiqueta detectada: ${tag.data}");

            // Verificar si la etiqueta es compatible con NDEF
            if (tag.data.isEmpty) {
              setState(() =>
                  statusMessage = 'La etiqueta no es compatible con NDEF');
              logger.d("Error: Etiqueta no es compatible con NDEF.");
              return;
            }

            // Crear mensaje NDEF
            NdefMessage message = NdefMessage([
              NdefRecord.createText(_id),
            ]);

            setState(() => statusMessage = 'Mensaje enviado exitosamente');
            logger.d("Mensaje enviado: $_id");
          } catch (e) {
            setState(
                () => statusMessage = 'Error al escribir en la etiqueta: $e');
            logger.d("Error al escribir en la etiqueta: $e");
          } finally {
            // Detener la sesión
            // await NfcManager.instance.stopSession();
            logger.d("Sesión NFC detenida.");
          }
        },
      );
    } catch (e) {
      setState(() => statusMessage = 'Error al iniciar la sesión NFC: $e');
      logger.d("Error al iniciar la sesión NFC: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryOpaqueColor =
        Theme.of(context).colorScheme.onPrimaryFixed;
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(children: [
                  const TittleText(text: 'NFC App'),
                  const SizedBox(
                    height: 25,
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
                  )
                ]),
                const SizedBox(
                  height: 25,
                ),
                Image.asset('assets/images/appImages/nfc_signal.png'),
                const SizedBox(
                  height: 25,
                ),
                const LargeText(text: 'Autenticar entrada'),
                // const BodyText(
                //     text:
                //         'Acerca tu telefono a la terminal de acceso para ingresar.',
                //     textAlign: TextAlign.start)
                Text(
                  statusMessage,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
