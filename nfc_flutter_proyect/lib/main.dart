import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:nfc_flutter_proyect/pages/dashboard/main_dashboard_page.dart';
import 'package:nfc_flutter_proyect/pages/register/user_register.dart';
import 'package:nfc_flutter_proyect/theme/app_theme.dart';

var logger = Logger();

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
      home: const AppTheme(
        child: SafeArea(
          child: RegisterScreen(),
        ),
      ),
    );
  }
}
