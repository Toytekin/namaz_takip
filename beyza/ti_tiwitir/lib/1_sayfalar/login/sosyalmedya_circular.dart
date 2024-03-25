import 'package:flutter/material.dart';
import 'package:ti_tiwitir/1_sayfalar/giris/giris.dart';
import 'package:ti_tiwitir/3_sabitler/color.dart';
import 'package:ti_tiwitir/3_sabitler/postlar.dart';
import 'package:ti_tiwitir/model/post_model.dart';
import 'package:ti_tiwitir/model/usermodel.dart';

// ignore: must_be_immutable
class SplasScreen extends StatefulWidget {
  UserModdel userModdel;
  int gelen;
  SplasScreen({
    super.key,
    required this.userModdel,
    required this.gelen,
  });

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  String google = 'assets/image/google.png';
  String facebook = 'assets/image/facebook.png';
  String apple = 'assets/image/ios.png';

  String ayarlanacakResim = 'assets/image/google.png';
  String yazacakYazi = '';
  List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
    posts = SbtPostlar().posts;
    posts.shuffle();
    medyaKontrolEt(widget.gelen);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => GirisSayafasi(
                  userModdel: widget.userModdel,
                  posts: posts,
                )),
      );
    });
  }

  void medyaKontrolEt(int gelen) {
    switch (gelen) {
      case 1:
        ayarlanacakResim = google;
        yazacakYazi = 'Google ile giriş yapılıyor...';
        break;
      case 2:
        ayarlanacakResim = facebook;
        yazacakYazi = 'Facebook ile giriş yapılıyor...';

        break;
      case 3:
        ayarlanacakResim = apple;
        yazacakYazi = 'Apple ile giriş yapılıyor...';

        break;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SbtColor().anaREnkl,
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 4,
                  child: Image.asset(ayarlanacakResim)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(yazacakYazi),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
