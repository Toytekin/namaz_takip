import 'package:flutter/material.dart';
import 'package:ti_tiwitir/1_sayfalar/giris/giris.dart';
import 'package:ti_tiwitir/2_widgetlar/sbt_textfild.dart';
import 'package:ti_tiwitir/3_sabitler/color.dart';
import 'package:ti_tiwitir/model/post_model.dart';
import 'package:ti_tiwitir/model/usermodel.dart';

class PostSendPage extends StatefulWidget {
  final List<PostModel> posts;
  final UserModdel userModdel;
  const PostSendPage({
    super.key,
    required this.userModdel,
    required this.posts,
  });

  @override
  State<PostSendPage> createState() => _PostSendPageState();
}

class _PostSendPageState extends State<PostSendPage> {
  var postTitleController = TextEditingController();
  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SbtColor().anaREnkl,
      appBar: AppBar(
        backgroundColor: SbtColor().anaREnkl,
        title: Text(widget.userModdel.username),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SbtTextfield(controller: postTitleController, label: 'Başlık'),
              SbtTextfield(controller: postController, label: 'İçerik'),
              ElevatedButton(
                  onPressed: () {
                    PostModel newPost = PostModel(
                        postID: 'postID',
                        postTitle: postTitleController.text,
                        post: postController.text,
                        userName: widget.userModdel.username,
                        userImage: 'assets/image/ben.png',
                        begeni: 52);

                    List<PostModel> yeniPostList = widget.posts;

                    yeniPostList.add(newPost);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GirisSayafasi(
                            posts: yeniPostList, userModdel: widget.userModdel),
                      ),
                    );
                  },
                  child: const Text('Paylaş'))
            ],
          ),
        ),
      ),
    );
  }
}
