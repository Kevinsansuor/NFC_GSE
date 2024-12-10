import 'package:flutter/material.dart';
import 'package:nfc_flutter_proyect/pages/verify_nfc/verify_nfc_page.dart';
import 'package:nfc_flutter_proyect/widgets/h2_text/large_text.dart';

class ErrorNfcPage extends StatelessWidget {
  const ErrorNfcPage({super.key});

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color primaryOpaqueColor =
        Theme.of(context).colorScheme.onPrimaryFixed;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VerifyNfcPage()),
              );
            },
          ),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 25),
                      child: Column(
                        textDirection: TextDirection.ltr,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Verificacion Fallida',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.5,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryOpaqueColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Column(
                              textDirection: TextDirection.ltr,
                              children: [
                                LargeText(
                                  text: 'No se encontro NFC',
                                  color: primaryColor,
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  'No se encuentra actividad NFC o no se ha reconocido.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: primaryColor,
                                        height: 1.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/appImages/fail.png'),
                                          width: 280,
                                          height: 280,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      side: BorderSide(
                                          color: primaryOpaqueColor,
                                          width: 2.5),
                                      padding: const EdgeInsets.all(25),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VerifyNfcPage(),
                                        ),
                                      );
                                    },
                                    child: const Text('Intentar de nuevo'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
