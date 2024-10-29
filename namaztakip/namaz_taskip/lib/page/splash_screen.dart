import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Kopyalama için gerekli
import 'package:namaz_taskip/constant/colors.dart';
import 'package:namaz_taskip/models/soz_model.dart';
import 'package:namaz_taskip/page/namaz_takip_anasayfa.dart';
import 'dart:math';
import 'package:namaz_taskip/services/sozler_servis.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<List<SozModel>> _sozlerFuture;
  late SozModel _soz;

  @override
  void initState() {
    super.initState();
    _sozlerFuture = SrvSozler().sozDataAl();
    _sozlerFuture.then((sozler) {
      final randomIndex = Random().nextInt(sozler.length);
      setState(() {
        _soz = sozler[randomIndex]; // Rastgele seçilen söz
      });
    });
  }

  void _copyToClipboard(String text, String sozSahibi) {
    // Söz ve söz sahibini birleştiriyoruz
    String combinedText = '$text ($sozSahibi)';
    Clipboard.setData(ClipboardData(text: combinedText)).then((_) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kopyalandı!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<List<SozModel>>(
        future: _sozlerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TEFEKKÜR',
                    style: TextStyle(
                        color: SbtColors.secondaryColor,
                        fontSize: sizeWidth / 6),
                  ),
                  SizedBox(height: sizeWidth / 6),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Text(
                              _soz.soz,
                              style: TextStyle(
                                  fontSize: sizeWidth * 0.06,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '(${_soz.sozSahibi})',
                              style: TextStyle(
                                  fontSize: sizeWidth * 0.04,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    // Kopyalama fonksiyonunu güncelledik
                                    _copyToClipboard(_soz.soz, _soz.sozSahibi);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SbtColors.primaryColor,
        onPressed: () {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const NamazTakibiScreen()),
          );
        },
        child: const Icon(
          Icons.next_plan,
          color: SbtColors.secondaryColor,
        ),
      ),
    );
  }
}
