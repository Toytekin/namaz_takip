import 'package:flutter/material.dart';
import 'package:ti_tiwitir/1_sayfalar/giris/giris.dart';
import 'package:ti_tiwitir/2_widgetlar/sbt_textfild.dart';
import 'package:ti_tiwitir/3_sabitler/color.dart';
import 'package:ti_tiwitir/model/post_model.dart';
import 'package:ti_tiwitir/model/usermodel.dart';

class AyarlarSayfasi extends StatefulWidget {
  final UserModdel userModdel;
  final List<PostModel> posts;

  const AyarlarSayfasi({
    super.key,
    required this.userModdel,
    required this.posts,
  });

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

String src =
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/2021_09_02_Marmara_Universitesi_Bahcesi.jpg/1200px-2021_09_02_Marmara_Universitesi_Bahcesi.jpg';

var name = TextEditingController();

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  @override
  void initState() {
    super.initState();
    name.text = widget.userModdel.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SbtColor().anaREnkl,
        appBar: AppBar(
          backgroundColor: SbtColor().anaREnkl,
          title: const Text('Ayarlar'),
        ),
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Resim çekme
                Container(
                  width: 200,
                  height: 200,
                  child: Image.network(src),
                ),

                SbtTextfield(controller: name, label: 'Ad'),

                ElevatedButton(
                    onPressed: () {
                      if (name.text.isNotEmpty) {
                        var user = UserModdel(
                            username: name.text.toString(),
                            password: widget.userModdel.password);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GirisSayafasi(
                                userModdel: user,
                                posts: widget.posts,
                              ),
                            ),
                            (route) => false);
                      } else {
                        var user = UserModdel(
                            username: widget.userModdel.username,
                            password: widget.userModdel.password);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GirisSayafasi(
                                  userModdel: user, posts: widget.posts),
                            ),
                            (route) => false);
                      }
                    },
                    child: const Text('Kaydet'))
              ],
            ),
          ),
        )));
  }
}
