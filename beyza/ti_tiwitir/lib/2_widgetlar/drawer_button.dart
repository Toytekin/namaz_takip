import 'package:flutter/material.dart';

class DrawerButtons extends StatelessWidget {
  final Function()? onTap;
  final String butonText;
  final Widget icon;
  const DrawerButtons({
    super.key,
    required this.onTap,
    required this.butonText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [icon, const SizedBox(width: 20), Text(butonText)],
        ),
      ),
    );
  }
}
