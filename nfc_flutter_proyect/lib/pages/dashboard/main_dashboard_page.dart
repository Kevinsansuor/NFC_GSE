import 'package:flutter/material.dart';
import 'package:nfc_flutter_proyect/widgets/body_text/body_text.dart';
import 'package:nfc_flutter_proyect/widgets/h1_text/tittle_text.dart';
import 'package:nfc_flutter_proyect/widgets/h2_text/large_text.dart';

class MainDashboardPage extends StatelessWidget {
  const MainDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String _id = '1005258846';
    
    final Color primaryColor = Theme.of(context).colorScheme.primary;
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
                const BodyText(
                    text:
                        'Acerca tu telefono a la terminal de acceso para ingresar.',
                    textAlign: TextAlign.start)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
