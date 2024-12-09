import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> authenticateUser(BuildContext context) async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Autentícate para acceder',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (authenticated) {
        // Recuperar el nombre del usuario
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? name = prefs.getString('userName');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bienvenido, $name')),
        );

        // Aquí podrías redirigir a una pantalla principal
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Autenticación fallida')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Biométrico')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => authenticateUser(context),
          child: Text('Iniciar Sesión con Huella Digital'),
        ),
      ),
    );
  }
}
