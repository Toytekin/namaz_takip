import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SbtTextfield extends StatelessWidget {
  TextEditingController controller;
  String label;
  SbtTextfield({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.white), // Tıklanmadan önceki renk
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Tıklandığında renk
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}
