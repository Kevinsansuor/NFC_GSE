import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme extends StatelessWidget {
  final Widget child;

  const AppTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF1b1f1c), brightness: Brightness.dark,)
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
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(0, 15, 78, 31),          elevation: 0,
        )
      ),
      home: child,
    );
  }
}
