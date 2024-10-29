import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:namaz_taskip/bloc/sozbloc.dart';
import 'package:namaz_taskip/bloc/theme_bloc.dart';
import 'package:namaz_taskip/constant/thems.dart';
import 'package:namaz_taskip/models/color_adapter.dart';
import 'package:namaz_taskip/models/namaz_model.dart';
import 'package:namaz_taskip/page/splash_screen.dart';

Future<void> main() async {
  await Hive.initFlutter(); // Hive'ı başlat
  Hive.registerAdapter(NamazAdapter()); // Model adapterini kaydedin

  Hive.registerAdapter(ColorAdapter());
  await Hive.openBox('namaz');
  await Hive.openBox('settings');

//intl
  await initializeDateFormatting(
      'tr', null); // Türkçe tarih formatlamayı başlat
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => SozlerCubit()),
        ],
        child: BlocBuilder<ThemeBloc, bool>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state ? TrTheme.darkTheme : TrTheme.lightTheme,
              title: 'Tr',
              //intl takvim dili

              home: const SplashScreen(),
            );
          },
        ));
  }
}
