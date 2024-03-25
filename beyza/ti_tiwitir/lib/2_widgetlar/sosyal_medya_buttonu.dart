import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SosyalMediaButtonu extends StatelessWidget {
  void Function()? onTap;
  String imageYolu;
  SosyalMediaButtonu({
    super.key,
    required this.onTap,
    required this.imageYolu,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: size.width / 8,
        height: size.width / 8,
        child: Image.asset(imageYolu),
      ),
    );
  }
}
