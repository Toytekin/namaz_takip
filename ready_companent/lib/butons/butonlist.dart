import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButonList extends StatefulWidget {
  const ButonList({super.key});

  @override
  State<ButonList> createState() => _ButonListState();
}

class _ButonListState extends State<ButonList> {
  final _appbarTitle = 'All Button List';
  final _elevatedButon = 'Elevated Buton';
  final _elevatedButonClick = 'Elevated Buton Click';

  final _textButon = 'Text Buton';
  final _textButonClick = 'Text Buton Click';

  final _outlinedButon = 'Outlined Buton';
  final _chipText = 'Chip';

  String _popMenuItem = 'PopupMenuButon';

  String? selecTedOption;
  bool isChecks = true;

  String? selectedRadioButonValue;

  bool isSwitcSelected = true;

  double _sliderValue = 0.0;
  int _currentStep = 0;

  final List<bool> _selections = List.generate(3, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appbarTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: ListView(
            children: [
              eleveteedButon(_elevatedButonClick),
              textButon(),
              outlinedButon(),
              iconButon(),
              sizeBox(),
              dropDownButton(),
              sizeBox(),
              popMenuButon(),
              sizeBox(),
              cupertinaButon(),
              sizeBox(),
              cupertino2(),
              sizeBox(),
              checxBoxButon(),
              sizeBox(),
              readiButon1(),
              readiButon2(),
              sizeBox(),
              siwitch(),
              sizeBox(),
              cupertinoSwitch(),
              sliderText(),
              sliderButon(),
              cupertinoSlider(),
              //ADım adım olan işlemlerde
              //stepper(),
              chip(),
              toolTip(),
              toggleButon(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatingButon(),
    );
  }

  ToggleButtons toggleButon() {
    return ToggleButtons(
      isSelected: _selections,
      onPressed: (int index) {
        setState(() {
          _selections[index] = !_selections[index];
        });
      },
      children: const [
        Icon(Icons.format_bold),
        Icon(Icons.format_italic),
        Icon(Icons.format_underline),
      ],
    );
  }

  Tooltip toolTip() {
    return const Tooltip(
      child: Text('Tool Tip'),
      message: 'Bu Tool tip mesajıdır',
    );
  }

  Chip chip() => Chip(label: Text(_chipText));

  Stepper stepper() {
    return Stepper(
      steps: _stepperSteps(),
      currentStep: _currentStep,
      onStepContinue: () {
        setState(() {
          // Eğer son adımda değilse bir sonraki adıma geç
          if (_currentStep < _stepperSteps().length - 1) {
            _currentStep++;
          }
        });
      },
      // Geri butonuna basıldığında çalışacak fonksiyon
      onStepCancel: () {
        setState(() {
          // Eğer ilk adımda değilse bir önceki adıma geç
          if (_currentStep > 0) {
            _currentStep--;
          }
        });
      },
    );
  }

  CupertinoSlider cupertinoSlider() {
    return CupertinoSlider(
      divisions: 10,
      value: _sliderValue,
      onChanged: (value) {
        setState(() {
          _sliderValue = value;
        });
      },
    );
  }

  Slider sliderButon() {
    return Slider(
      thumbColor: Colors.green,
      divisions: 10,
      autofocus: true,
      activeColor: Colors.red,
      // Değer aralığı
      min: 0.0,
      max: 100.0,
      // Başlangıç değeri
      value: _sliderValue,
      // Değer değiştiğinde çalışacak fonksiyon
      onChanged: (newValue) {
        setState(() {
          _sliderValue = newValue;
        });
      },
    );
  }

  Text sliderText() {
    return Text(
      'Değer: $_sliderValue',
      style: const TextStyle(fontSize: 20.0),
    );
  }

  CupertinoSwitch cupertinoSwitch() {
    return CupertinoSwitch(
      value: isSwitcSelected,
      onChanged: (value) {
        setState(() {
          isSwitcSelected = !isSwitcSelected;
        });
      },
    );
  }

  Switch siwitch() {
    return Switch(
      value: isSwitcSelected,
      onChanged: (value) {
        setState(() {
          isSwitcSelected = !isSwitcSelected;
        });
      },
    );
  }

  RadioListTile<String> readiButon2() {
    return RadioListTile<String>(
      title: const Text('Kadın'),
      value: 'Kadın',
      groupValue: selectedRadioButonValue,
      onChanged: (value) {
        setState(() {
          selectedRadioButonValue = value;
        });
      },
    );
  }

  RadioListTile<String> readiButon1() {
    return RadioListTile<String>(
      title: const Text('Erkek'),
      value: 'Erkek',
      groupValue: selectedRadioButonValue,
      onChanged: (value) {
        setState(() {
          selectedRadioButonValue = value;
        });
      },
    );
  }

  Checkbox checxBoxButon() {
    return Checkbox(
      value: isChecks,
      onChanged: (value) {
        setState(() {
          isChecks = !isChecks;
        });
      },
    );
  }

  CupertinoButton cupertino2() {
    return CupertinoButton.filled(
      pressedOpacity: 0.2,
      disabledColor: Colors.red,
      borderRadius: BorderRadius.circular(2),
      child: const Text('Cupertino 2'),
      onPressed: () {},
    );
  }

  CupertinoButton cupertinaButon() {
    return CupertinoButton(
      child: const Text('Cupertino Buton'),
      onPressed: () {},
    );
  }

  PopupMenuButton<String> popMenuButon() {
    return PopupMenuButton(
      child: Text(_popMenuItem),
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'item1',
            child: Text('Öğe 1'),
          ),
          const PopupMenuItem<String>(
            value: 'item2',
            child: Text('Öğe 2'),
          ),
          const PopupMenuItem<String>(
            value: 'item3',
            child: Text('Öğe 3'),
          ),
        ];
      },
      onSelected: (value) {
        setState(() {
          _popMenuItem = value;
        });
      },
    );
  }

  SizedBox sizeBox() => const SizedBox(height: 25);

  DropdownButton<String> dropDownButton() {
    return DropdownButton<String>(
      // İlk öğe görüntülenen metin, ikinci öğe değer
      items: const [
        DropdownMenuItem(
          value: 'option1',
          child: Text('Seçenek 1'),
        ),
        DropdownMenuItem(
          value: 'option2',
          child: Text('Seçenek 2'),
        ),
        DropdownMenuItem(
          value: 'option3',
          child: Text('Seçenek 3'),
        ),
      ],
      value: selecTedOption,
      onChanged: (value) {
        // Seçilen değeri güncelle
        selecTedOption = value;
        setState(() {});
      },
    );
  }

  FloatingActionButton floatingButon() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }

  IconButton iconButon() {
    return IconButton(
        onPressed: () {}, icon: const Icon(Icons.headphones_rounded));
  }

  OutlinedButton outlinedButon() =>
      OutlinedButton(onPressed: () {}, child: Text(_outlinedButon));

  TextButton textButon() {
    return TextButton(
        onPressed: () {
          debugPrint(_textButonClick);
        },
        child: Text(_textButon));
  }

  ElevatedButton eleveteedButon(String dat) {
    return ElevatedButton(
      onPressed: () {
        debugPrint(dat);
      },
      child: Text(_elevatedButon),
    );
  }

  List<Step> _stepperSteps() {
    return [
      Step(
        title: const Text('Adım 1'),
        content: const Text('Bu ilk adım içeriği'),
        isActive: _currentStep == 0,
      ),
      Step(
        title: const Text('Adım 2'),
        content: const Text('Bu ikinci adım içeriği'),
        isActive: _currentStep == 1,
      ),
      Step(
        title: const Text('Adım 3'),
        content: const Text('Bu üçüncü adım içeriği'),
        isActive: _currentStep == 2,
      ),
    ];
  }
}




// ElevatedButton: Yükseltilmiş bir düğme oluşturur. Material Design stilinde bir düğmedir.

// TextButton: Metin tabanlı bir düğme oluşturur. Genellikle içeriği daha az belirgin olan durumlarda tercih edilir.

// OutlinedButton: Kenarları çizgili bir düğme oluşturur. İçeriği düzleştirmek ve vurgulamak için kullanılır.

// IconButton: İkon tabanlı bir düğme oluşturur. Genellikle çubuklar veya araç çubukları için kullanılır.

// FloatingActionButton: Ana içerik üzerinde yüzen bir düğme oluşturur. Genellikle uygulamanın ana eylemini temsil eder.

// DropdownButton: Bir açılır menüyü tetiklemek için bir düğme oluşturur. Kullanıcılar seçenekler arasından bir seçim yapabilir.

// PopupMenuButton: Bir popup menüyü tetiklemek için bir düğme oluşturur. Kullanıcılar bağlam menüsünden bir seçim yapabilir.

// CupertinoButton: iOS stiline uygun bir düğme oluşturur. iOS uygulamalarında kullanılan standart düğmelerle uyumlu olması için tasarlanmıştır.


// Checkbox: Kullanıcının bir onay kutusunu işaretleyip işaretlememesini sağlar.
// RadioButton: Kullanıcının bir listeden yalnızca bir öğeyi seçmesini sağlar.
// Switch: Kullanıcının bir anahtar değiştiriciyi açıp kapatmasını sağlar.
// CupertinoSwitch: iOS stiline uygun anahtar değiştirici oluşturur.
// Slider: Kullanıcının bir değer aralığını seçmesini sağlar.
// CupertinoSlider: iOS stiline uygun bir kaydırıcı oluşturur.

// Stepper: Bir adım adım iş akışı oluşturmak için kullanılır. Kullanıcılar bir dizi adımdan geçerken ilerleyebilir veya geri gidebilir.
// Chip: Kompakt bir kullanıcı arayüzü öğesi oluşturur. Genellikle bir etiket veya seçenekleri temsil etmek için kullanılır.
// Tooltip: Bir widget'e ilişkin açıklayıcı metin gösterir. Kullanıcılar widget'e odaklandığında veya üzerine geldiğinde görüntülenir.
// ToggleButtons: Birden çok seçeneği etkinleştirmek veya devre dışı bırakmak için kullanılan bir grup düğme oluşturur.