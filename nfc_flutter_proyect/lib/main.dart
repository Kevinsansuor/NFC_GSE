import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_flutter_proyect/widgets/body_text/body_text.dart';
import 'package:nfc_flutter_proyect/widgets/h1_text/tittle_text.dart';
import 'package:nfc_flutter_proyect/widgets/h2_text/large_text.dart';

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
            .copyWith(primary: const Color(0xFFdde0e1)),
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
        ),
      ),
      home: const SafeArea(
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TittleText(
              text: 'NFC App',
              color: primaryColor,
              textStyle: Theme.of(context).textTheme.displayLarge,
            ),
            LargeText(
              text: 'Subtitulo',
              color: primaryColor,
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
            BodyText(
              text: 'Cuerpo',
              color: primaryColor,
              textStyle: Theme.of(context).textTheme.bodyLarge,
            )
          ]),
        ),
      ),
    );
  }
}
