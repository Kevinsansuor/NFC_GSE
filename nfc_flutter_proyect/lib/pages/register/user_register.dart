import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nfc_flutter_proyect/pages/verify_nfc/verify_nfc_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticated = false;

  Future<void> _authenticate() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Por favor, autentícate con tu huella digital',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      setState(() {
        _isAuthenticated = didAuthenticate;
      });

      if (didAuthenticate) {
        await _registerUser();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Autenticación fallida')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la autenticación biométrica: $e')),
      );
    }
  }

  Future<void> _registerUser() async {
    String name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa tu nombre')),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Huella digital capturada correctamente')),
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const VerifyNfcPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text(
                  _isAuthenticated ? 'Huella Autenticada' : 'Registrar Huella'),
            ),
          ],
        ),
      ),
    );
  }
}
