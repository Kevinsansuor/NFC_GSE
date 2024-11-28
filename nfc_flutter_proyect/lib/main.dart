import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:logger/logger.dart';

var logger = Logger();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter NFC Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter NFC Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _nfcData = 'Presiona el botón para leer NFC';
  bool _isReading = false;

  void _startNFCReading() async {
    setState(() {
      _isReading = true;
      _nfcData = 'Esperando datos NFC...';
    });

    try {
      bool isAvailable = await NfcManager.instance.isAvailable();
      logger.d('isAvailable: $isAvailable');

      if (isAvailable) {
        NfcManager.instance.startSession(
          //TODO: onDiscoveredSession
          onDiscovered: (NfcTag tag) async {

            String data = tag.data.toString();

              setState(() {
                _nfcData = data;
              });
              NfcManager.instance.stopSession();
            } 
        ); } else {
        _showErrorSnackbar('NFC no está disponible en este dispositivo.');
        setState(() {
          _nfcData = 'NFC no disponible.';
        });
      }
    } catch (e) {
      logger.e('Error: ${e.toString()}');
      _showErrorSnackbar('Error al leer NFC: ${e.toString()}');
      setState(() {
        _nfcData = 'Error al leer NFC.';
      });
    } finally {
      setState(() {
        _isReading = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _nfcData,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isReading ? null : _startNFCReading,
            child: Text(_isReading ? 'Leyendo...' : 'Leer NFC'),
          ),
        ],
      ),
    );
  }
}
