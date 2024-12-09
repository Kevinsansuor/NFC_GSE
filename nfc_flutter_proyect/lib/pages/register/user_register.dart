import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool isBiometricAvailable = false;
  bool isBiometricEnrolled = false;

  @override
  void initState() {
    super.initState();
    checkBiometricAvailability();
  }

  Future<void> checkBiometricAvailability() async {
    // Verificar si el dispositivo puede revisar biometría
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    
    // Verificar si el dispositivo soporta biometría
    bool isDeviceSupported = await auth.isDeviceSupported();
    
    // Obtener los tipos de biometría disponibles (puede incluir huella dactilar o reconocimiento facial)
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    bool isFingerprintAvailable = availableBiometrics.contains(BiometricType.fingerprint);

    setState(() {
      // La biometría está disponible solo si el dispositivo la soporta y está configurada
      isBiometricAvailable = canCheckBiometrics && isDeviceSupported && isFingerprintAvailable;
      isBiometricEnrolled = isDeviceSupported;
    });

    // Imprimir información para depuración
    print('Biometría disponible: $isBiometricAvailable');
    print('Dispositivo soporta biometría: $isDeviceSupported');
    print('Huella dactilar disponible: $isFingerprintAvailable');
    print('Tipos de biometría disponibles: $availableBiometrics');
  }

  Future<void> registerUser() async {
    String name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa tu nombre')),
      );
      return;
    }

    if (!isBiometricAvailable) {
      // Imprimir mensaje de error en consola
      print('Biometría no disponible o no configurada.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Biometría no disponible o no configurada en este dispositivo')),
      );
      return;
    }

    try {
      // Realizar la autenticación biométrica
      bool authenticated = await auth.authenticate(
        localizedReason: 'Confirma tu identidad para registrar tu huella',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (authenticated) {
        // Registro exitoso
        print('Huella digital capturada correctamente');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Huella digital capturada correctamente')),
        );

        // Guardar el nombre del usuario en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', name);

        // Redirigir a la siguiente pantalla
        Navigator.pushReplacementNamed(context, '/verify');
      } else {
        print('Autenticación fallida');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Autenticación fallida')),
        );
      }
    } catch (e) {
      print('Error en la autenticación biométrica: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la autenticación biométrica')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerUser,
              child: Text('Registrar Huella'),
            ),
          ],
        ),
      ),
    );
  }
}
