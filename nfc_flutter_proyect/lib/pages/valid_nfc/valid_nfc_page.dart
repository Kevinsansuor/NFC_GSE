import 'package:flutter/material.dart';
import 'package:nfc_flutter_proyect/widgets/h2_text/large_text.dart';

class ValidNfcPage extends StatelessWidget {
  const ValidNfcPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color primaryOpaqueColor =
        Theme.of(context).colorScheme.onPrimaryFixed;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 25),
                    child: Column(
                      textDirection: TextDirection.ltr,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 70.0), 
                            child: Text(
                              'Verificacion Exitosa',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
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
                              text: 'Dispositivo con NFC',
                              color: primaryColor,
                              textStyle: Theme.of(context).textTheme.titleLarge,
                            ),

                              Text(
                                'Tu dispositivo cuenta con la tecnología necesaria para poder escanear, añadir y configurar tarjetas con NFC.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: primaryColor,
                                      height: 1.0, 
                                    ),
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
                                    Center(
                                        child: Image(
                                          image: AssetImage('assets/images/appImages/successful.png'),
                                          width: 280, 
                                          height: 280,
                                          fit: BoxFit.cover,
                                        ),
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
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge,
                                    side: BorderSide(
                                        color: primaryOpaqueColor, width: 2.5),
                                    padding: const EdgeInsets.all(25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onPressed: () {
                                    //acciones del boton
                                  },
                                  child: const Text('Siguiente'),
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
          ],
        ),
      ),
    );
  }
}