import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; 
void main() {
  runApp(const NFCApp());
}

class NFCApp extends StatelessWidget {
  const NFCApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const SizedBox(height: 60),
              // Título
              Text(
                'NFC App',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Descripción
              Text(
                'Bienvenido a NFC App, con esta aplicación podrás, escanear, añadir y configurar tarjetas con la tecnología NFC de tu dispositivo Android.',
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              // Espacio entre el primer párrafo y la línea de división
              const SizedBox(height: 15),
              const Divider(
                color: Colors.white24,
                thickness: 1,
                height: 25,
              ),
              const SizedBox(height: 15), // Espacio adicional después de la línea de separación
              // Subtítulo
              Text(
                'Prueba NFC',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Descripción del botón
              Text(
                'Verifiquemos que tu dispositivo tiene la tecnología NFC incorporada.',
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 90),
              // Icono NFC personalizado usando flutter_vector_icons
              Center(
                child: Icon(
                  MaterialCommunityIcons.nfc,  // Usando el icono de NFC de MaterialCommunityIcons
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 100),
              
              // Botón con bordes redondeados, sin relleno
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 2), // Borde blanco
                    padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Bordes redondeados
                    ),
                    backgroundColor: Colors.transparent, // Sin relleno
                  ),
                  child: Text(
                    'Verificar NFC',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
