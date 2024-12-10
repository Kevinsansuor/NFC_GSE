import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nfc_flutter_proyect/pages/verify_nfc/verify_nfc_page.dart';
import 'package:nfc_flutter_proyect/widgets/h2_text/large_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticated = true;

  Future<void> _authenticate() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Por favor, autentícate con tu huella digital',
        options: const AuthenticationOptions(
            biometricOnly: false, useErrorDialogs: true, stickyAuth: true),
      );

      setState(() {
        _isAuthenticated = didAuthenticate;
      });

      if (!didAuthenticate) {
        await _registerUser();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Autenticación fallida')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en la autenticación biométrica: $e')),
        );
      }
    }
  }

  Future<void> _registerUser() async {
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
      appBar: AppBar(title: const Text('Autenticación biometrica')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.all(16.0)),
                        elevation: WidgetStatePropertyAll(5.0),
                      ),
                      onPressed: _authenticate,
                      child: _isAuthenticated
                          ? const Icon(
                              Icons.lock,
                              size: 80,
                              color: Color(0xFFA0CC78),
                            )
                          : const Icon(Icons.lock,
                              size: 80, color: Color(0xFFA0CC78)),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Center(
                        child: LargeText(
                      text: 'Por favor autenticate',
                      textAlign: TextAlign.center,
                    ))
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
