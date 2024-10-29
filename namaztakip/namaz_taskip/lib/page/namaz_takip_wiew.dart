import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namaz_taskip/constant/colors.dart';
import 'package:namaz_taskip/models/namaz_model.dart';
import 'package:namaz_taskip/page/namaz_takip_anasayfa.dart';
import 'package:namaz_taskip/services/namaz_servis.dart';

mixin NamazTakibiScreenMixin on State<NamazTakibiScreen> {
// DEĞİŞKENLER

  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  NamazServis namazServis = NamazServis();
  final ScrollController scrollController = ScrollController();
  bool canGoBack = true; // Geri gitme durumu

// İNİTSTADE
  @override
  void initState() {
    super.initState();
    loadData();
    // Güncel tarihe otomatik kaydırma
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int todayIndex = DateTime.now().day - 1;
      scrollController.jumpTo(todayIndex * 65.0); // Güncel tarihe kaydırma
    });
  }

  void loadData() {
    for (int day = 1; day <= 31; day++) {
      DateTime date = DateTime(selectedYear, selectedMonth, day);
      String formattedDate = DateFormat('dd.MM.yyyy', 'tr').format(date);
      Namaz? namaz = namazServis.al(formattedDate);

      if (namaz != null) {
        defaultColors[day - 1][0] = namaz.sabah;
        defaultColors[day - 1][1] = namaz.ogle;
        defaultColors[day - 1][2] = namaz.ikindi;
        defaultColors[day - 1][3] = namaz.aksam;
        defaultColors[day - 1][4] = namaz.yatsi;
      } else {
        defaultColors[day - 1] = List.filled(5, Colors.white);
      }
    }
    setState(() {});
  }

  final List<Color> colors = [
    Colors.green,
    Colors.orange,
    Colors.red,
    const Color.fromARGB(255, 248, 152, 176),
  ];

  List<List<Color>> defaultColors =
      List.generate(31, (_) => List.filled(5, Colors.white));

  void saveNamaz(String tarih, int index, Color color) async {
    int dayIndex = int.parse(tarih.split('.')[0]) - 1;
    Namaz namaz = Namaz(
      tarih: tarih,
      sabah: defaultColors[dayIndex][0],
      ogle: defaultColors[dayIndex][1],
      ikindi: defaultColors[dayIndex][2],
      aksam: defaultColors[dayIndex][3],
      yatsi: defaultColors[dayIndex][4],
    );

    await namazServis.kaydet(namaz);
  }

// Üstteki yönlendirme renk yeri
  Widget buildStatusIndicator(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: SbtColors.writeColor,
                offset: Offset(2, 2),
                blurRadius: 0,
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(color: SbtColors.writeColor),
        ),
      ],
    );
  }

  void showColorPicker(BuildContext context, Function(Color) onColorSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Renk Seçin'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildColorOption(Colors.green, '', onColorSelected),
              buildColorOption(Colors.orange, '', onColorSelected),
              buildColorOption(Colors.red, '', onColorSelected),
              buildColorOption(Colors.pink, '', onColorSelected),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Kapat',
                style: TextStyle(
                    color: Colors
                        .grey), // SbtColors.secondaryColor kullanabilirsiniz.
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildColorOption(
      Color color, String label, Function(Color) onColorSelected) {
    return GestureDetector(
      onTap: () {
        onColorSelected(color);
        Navigator.of(context).pop();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(2),
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.width * 0.14,
            decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  TextStyle teststyl1() {
    return TextStyle(
        color: SbtColors.writeColor,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width * 0.04);
  }
}
