import 'package:flutter/material.dart';
import 'package:ti_tiwitir/1_sayfalar/giris/giris.dart';
import 'package:ti_tiwitir/1_sayfalar/login/kayit_mail.dart';
import 'package:ti_tiwitir/1_sayfalar/login/sosyalmedya_circular.dart';
import 'package:ti_tiwitir/2_widgetlar/sbt_textfild.dart';
import 'package:ti_tiwitir/2_widgetlar/sosyal_medya_buttonu.dart';
import 'package:ti_tiwitir/3_sabitler/color.dart';
import 'package:ti_tiwitir/3_sabitler/postlar.dart';
import 'package:ti_tiwitir/model/post_model.dart';
import 'package:ti_tiwitir/model/usermodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var mailController = TextEditingController();
  var sifreController = TextEditingController();

  bool tema = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List<PostModel> posts = [];

    @override
    void initState() {
      super.initState();
      posts = SbtPostlar().posts;
      posts.shuffle();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              tema == false ? SbtColor().anaREnkl : SbtColor().anadarkREnkl,
          elevation: 0,
          actions: [
            Switch(
              value: tema,
              onChanged: (value) {
                tema = !tema;
                setState(() {});
              },
            )
          ],
        ),
        backgroundColor:
            tema == false ? SbtColor().anaREnkl : SbtColor().anadarkREnkl,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: size.height / 6,
                  height: size.height / 6,
                  child: Image.asset('assets/image/logo.png'),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SbtTextfield(controller: mailController, label: 'Mail'),
                      SbtTextfield(controller: sifreController, label: 'Sifre'),
                      ElevatedButton(
                          onPressed: () {
                            if (mailController.text.isEmpty ||
                                sifreController.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: const Text(
                                        'Lütfen tüm alanları doldurduktan sonra tekrar deneyin'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Tamam'))
                                    ],
                                  );
                                },
                              );
                            } else {
                              var usermodel = UserModdel(
                                  username: mailController.text,
                                  password: sifreController.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GirisSayafasi(
                                    userModdel: usermodel,
                                    posts: posts,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Giriş Yap'))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Google
                    SosyalMediaButtonu(
                        onTap: () {
                          var usermodel = UserModdel(
                              username: 'Ayşe Kıvanç', password: '145302');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplasScreen(
                                gelen: 1,
                                userModdel: usermodel,
                              ),
                            ),
                          );
                        },
                        imageYolu: 'assets/image/google.png'),
                    //FAcebook
                    SosyalMediaButtonu(
                        onTap: () {
                          var usermodel = UserModdel(
                              username: 'Mehmet Demir', password: '145302');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplasScreen(
                                gelen: 2,
                                userModdel: usermodel,
                              ),
                            ),
                          );
                        },
                        imageYolu: 'assets/image/facebook.png'),

                    //Apple
                    SosyalMediaButtonu(
                        onTap: () {
                          var usermodel = UserModdel(
                              username: 'Nazlı Buse Kurnaz',
                              password: '145302');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplasScreen(
                                gelen: 3,
                                userModdel: usermodel,
                              ),
                            ),
                          );
                        },
                        imageYolu: 'assets/image/ios.png'),
                    //Mail
                    SosyalMediaButtonu(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const KayitEkraniMail()),
                          );
                        },
                        imageYolu: 'assets/image/mail.png'),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
