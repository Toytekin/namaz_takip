import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:namaz_taskip/models/soz_model.dart';
import 'package:namaz_taskip/services/sozler_servis.dart'; // Rastgele seçim için gerekli

class SozlerCubit extends Cubit<SozModel?> {
  SozlerCubit() : super(null); // Constructor tamamlandı.

  final SrvSozler repo = SrvSozler();

  Future<void> rasgeleBirSozCek() async {
    // Servisten tüm sözleri al
    List<SozModel> sozler = await repo.sozDataAl();

    // Rastgele bir indeks seç
    var random = Random();
    int randomIndex = random.nextInt(sozler.length);

    // Rastgele sözü emit et (Cubit'in state'ini güncelle)
    emit(sozler[randomIndex]);
  }
}
