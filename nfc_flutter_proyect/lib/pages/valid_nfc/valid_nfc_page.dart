import 'package:flutter/material.dart';

class ValidNfcPage extends StatelessWidget {
  const ValidNfcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success'),),
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dispositivo con NFC',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 64,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
