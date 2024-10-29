import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namaz_taskip/constant/colors.dart';
import 'package:namaz_taskip/constant/widget/tiklama_container.dart';
import 'package:namaz_taskip/page/namaz_takip_wiew.dart';

class NamazTakibiScreen extends StatefulWidget {
  const NamazTakibiScreen({super.key});

  @override
  State<NamazTakibiScreen> createState() => _NamazTakibiScreenState();
}

class _NamazTakibiScreenState extends State<NamazTakibiScreen>
    with NamazTakibiScreenMixin {
  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    DateTime today = DateTime.now();
    Size sizem = MediaQuery.of(context).size;

    return PopScope(
      canPop: canGoBack, // Geri gitme durumu
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Ay ve yıl seçim alanı
              Row(
                children: [
                  // Buraya tıklandığında bulunulan aya gitsin
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        oncekiAyaGelenButon(),
                        Text(
                          DateFormat('MMMM yyyy', 'tr')
                              .format(DateTime(selectedYear, selectedMonth)),
                          style: const TextStyle(
                              fontSize: 20,
                              color: SbtColors.writeColor,
                              fontWeight: FontWeight.bold),
                        ),
                        sorakiAyaGelenButon(),
                      ],
                    ),
                  ),
                  buguneGelenButon(),
                ],
              ),
              // Durum simgeleri
              renklerinNeAnlamaGEldiginiGosterenAlan(),
              const SizedBox(height: 20),
              sabahogleaksamyazisi(sizem),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: daysInMonth,
                  itemBuilder: (context, index) {
                    int day = index + 1;
                    DateTime date = DateTime(selectedYear, selectedMonth, day);
                    String formattedDate =
                        DateFormat('dd.MM.yyyy', 'tr').format(date);

                    bool isToday = date.day == today.day &&
                        date.month == today.month &&
                        date.year == today.year;

                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isToday ? Colors.greenAccent : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: SbtColors.writeColor,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: SbtColors.writeColor.withOpacity(0.5),
                                  offset: const Offset(2, 4),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: SbtColors.writeColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(5, (i) {
                              return TiklamaContainer(
                                color: defaultColors[day - 1][i],
                                onpress: () =>
                                    showColorPicker(context, (selectedColor) {
                                  setState(() {
                                    defaultColors[day - 1][i] = selectedColor;
                                    saveNamaz(formattedDate, i, selectedColor);
                                  });
                                }),
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row renklerinNeAnlamaGEldiginiGosterenAlan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildStatusIndicator(Colors.green, 'Vaktinde'),
        buildStatusIndicator(Colors.orange, 'Kaza'),
        buildStatusIndicator(Colors.red, 'Terkedildi'),
        buildStatusIndicator(Colors.pink, 'Haiz (Kadınlar)'),
      ],
    );
  }

  IconButton sorakiAyaGelenButon() {
    return IconButton(
      icon: const Icon(Icons.arrow_forward),
      onPressed: () {
        setState(() {
          if (selectedMonth == 12) {
            selectedMonth = 1;
            selectedYear++;
          } else {
            selectedMonth++;
          }
          loadData();
        });
      },
    );
  }

  IconButton oncekiAyaGelenButon() {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        setState(() {
          if (selectedMonth == 1) {
            selectedMonth = 12;
            selectedYear--;
          } else {
            selectedMonth--;
          }
          loadData();
        });
      },
    );
  }

  IconButton buguneGelenButon() {
    return IconButton(
        onPressed: () {
          setState(() {
            selectedMonth = DateTime.now().month;
            selectedYear = DateTime.now().year;
            loadData();
            // Güncel tarihe otomatik kaydırma
            WidgetsBinding.instance.addPostFrameCallback((_) {
              int todayIndex = DateTime.now().day - 1;
              scrollController
                  .jumpTo(todayIndex * 65.0); // Güncel tarihe kaydırma
            });
          });
        },
        icon: const Icon(Icons.calendar_month));
  }

  Row sabahogleaksamyazisi(Size sizem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            width: sizem.width / 5, child: Text('Tarih', style: teststyl1())),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Sabah', style: teststyl1()),
              Text('Öğle', style: teststyl1()),
              Text('İkindi', style: teststyl1()),
              Text('Akşam', style: teststyl1()),
              Text('Yatsı', style: teststyl1()),
            ],
          ),
        )
      ],
    );
  }
}
