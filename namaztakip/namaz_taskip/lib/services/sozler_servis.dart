import 'dart:convert';
import 'dart:math'; // Rastgele seçim için import

import 'package:flutter/services.dart';
import 'package:namaz_taskip/constant/paths.dart';
import 'package:namaz_taskip/models/soz_model.dart';

class SrvSozler {
  List<SozModel> allSozler = [];

  Future<List<SozModel>> sozDataAl() async {
    final String response = await rootBundle.loadString(SbtPaths.sozjsonpath);
    final data = await json.decode(response);

    allSozler = (data as List).map((e) => SozModel.fromJson(e)).toList();
    return allSozler;
  }

  // Rastgele bir SozModel geri döndüren metot
  Future<SozModel?> rastgeleSozAl() async {
    if (allSozler.isEmpty) {
      await sozDataAl(); // Eğer sözler listesi boşsa, verileri al
    }

    if (allSozler.isNotEmpty) {
      final randomIndex = Random().nextInt(allSozler.length); // Rastgele indeks
      return allSozler[randomIndex]; // Rastgele söz
    }
    return null; // Eğer listede hiç söz yoksa null döner
  }
}
