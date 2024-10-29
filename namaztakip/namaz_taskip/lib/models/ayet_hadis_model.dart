class Hadis {
  final String hadis;
  final String kaynak;
  final Ayet ayet;

  Hadis({
    required this.hadis,
    required this.kaynak,
    required this.ayet,
  });

  // JSON'dan Hadis nesnesi oluşturma
  factory Hadis.fromJson(Map<String, dynamic> json) {
    return Hadis(
      hadis: json['hadis'],
      kaynak: json['kaynak'],
      ayet: Ayet.fromJson(json['ayet']),
    );
  }

  // Hadis nesnesini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'hadis': hadis,
      'kaynak': kaynak,
      'ayet': ayet.toJson(),
    };
  }
}

class Ayet {
  final String arapca;
  final String meal;
  final String sure;

  Ayet({
    required this.arapca,
    required this.meal,
    required this.sure,
  });

  // JSON'dan Ayet nesnesi oluşturma
  factory Ayet.fromJson(Map<String, dynamic> json) {
    return Ayet(
      arapca: json['arapca'],
      meal: json['meal'],
      sure: json['sure'],
    );
  }

  // Ayet nesnesini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'arapca': arapca,
      'meal': meal,
      'sure': sure,
    };
  }
}
