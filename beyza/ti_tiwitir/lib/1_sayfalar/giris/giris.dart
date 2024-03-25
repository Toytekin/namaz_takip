import 'package:flutter/material.dart';
import 'package:ti_tiwitir/1_sayfalar/ayar/ayar.dart';
import 'package:ti_tiwitir/1_sayfalar/postpaylas/send_post.dart';
import 'package:ti_tiwitir/2_widgetlar/drawer_button.dart';
import 'package:ti_tiwitir/3_sabitler/color.dart';
import 'package:ti_tiwitir/model/post_model.dart';
import 'package:ti_tiwitir/model/usermodel.dart';

// ignore: must_be_immutable
class GirisSayafasi extends StatefulWidget {
  final List<PostModel> posts;
  UserModdel userModdel;
  GirisSayafasi({
    super.key,
    required this.posts,
    required this.userModdel,
  });

  @override
  State<GirisSayafasi> createState() => _GirisSayafasiState();
}

class _GirisSayafasiState extends State<GirisSayafasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userModdel.username),
      ),
      body: ListView.builder(
        reverse: true,
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              //Post
              Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipPath(
                          clipper: CircleClipper(),
                          child: Image.asset(
                            widget.posts[index].userImage,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Text(widget.posts[index].userName)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            widget.posts[index].postTitle,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.posts[index].post),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.heart_broken_sharp,
                            color: Colors.redAccent,
                          ),
                          Text(widget.posts[index].begeni.toString())
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //Divider
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: SbtColor().anaREnkl,
                  height: 2,
                  endIndent: 50,
                  indent: 50,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: SbtColor().anaREnkl,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostSendPage(
                  userModdel: widget.userModdel, posts: widget.posts),
            ),
          );
        },
        child: const Icon(Icons.post_add),
      ),
      drawer: MyDrawer(
        userModdel: widget.userModdel,
        posts: widget.posts,
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final UserModdel userModdel;
  final List<PostModel> posts;
  const MyDrawer({
    super.key,
    required this.userModdel,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: SbtColor().anaREnkl,
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Benim ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Sosyal ',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    ),
                    TextSpan(
                      text: 'Medyam!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          DrawerButtons(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AyarlarSayfasi(
                            userModdel: userModdel,
                            posts: posts,
                          )),
                );
              },
              butonText: 'Ayarlar',
              icon: const Icon(Icons.settings)),
          DrawerButtons(
              onTap: () {},
              butonText: 'Profil',
              icon: const Icon(Icons.person)),
        ],
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
