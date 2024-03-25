import 'package:flutter/material.dart';
import 'package:ti_tiwitir/1_sayfalar/giris/giris.dart';
import 'package:ti_tiwitir/2_widgetlar/sbt_textfild.dart';
import 'package:ti_tiwitir/3_sabitler/color.dart';
import 'package:ti_tiwitir/3_sabitler/postlar.dart';
import 'package:ti_tiwitir/model/post_model.dart';
import 'package:ti_tiwitir/model/usermodel.dart';

class KayitEkraniMail extends StatefulWidget {
  const KayitEkraniMail({super.key});

  @override
  State<KayitEkraniMail> createState() => _KayitEkraniMailState();
}

class _KayitEkraniMailState extends State<KayitEkraniMail> {
  var nameController = TextEditingController();
  var mailController = TextEditingController();
  var telController = TextEditingController();
  var paswordController = TextEditingController();
  var pasworTekrardController = TextEditingController();

  bool cinsiyet = true;
  String erkek = 'Erkek';
  String kiz = 'Kız';
  List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
    posts = SbtPostlar().posts;
    posts.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SbtColor().anaREnkl,
      appBar: AppBar(
        backgroundColor: SbtColor().anaREnkl,
        title: const Text('Kayit'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SbtTextfield(controller: nameController, label: 'İsim'),
              SbtTextfield(controller: mailController, label: 'Mail'),
              SbtTextfield(controller: telController, label: 'Tel'),
              SbtTextfield(controller: paswordController, label: 'Şifre'),
              SbtTextfield(controller: pasworTekrardController, label: 'Şifre'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    cinsiyet ? erkek : kiz,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  Switch(
                    value: cinsiyet,
                    onChanged: (value) {
                      cinsiyet = !cinsiyet;
                      setState(() {});
                    },
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        mailController.text.isNotEmpty &&
                        telController.text.isNotEmpty &&
                        paswordController.text.isNotEmpty &&
                        pasworTekrardController.text.isNotEmpty &&
                        pasworTekrardController.text ==
                            pasworTekrardController.text) {
                      UserModdel userModdel = UserModdel(
                          username: nameController.text,
                          password: paswordController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GirisSayafasi(
                              posts: posts, userModdel: userModdel),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Uyarı'),
                            content: const Text(
                                'Tüm alanların doğru olduğuna ve şifre tekrarını doğru girdiğine emin olduktan sonra tekrar dene'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Dialogu kapat
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Kaydet'))
            ],
          ),
        ),
      ),
    );
  }
}
