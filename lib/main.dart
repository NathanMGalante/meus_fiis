import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_fiis/modules/dashboard/page.dart';
import 'package:meus_fiis/shared/in18.dart';
import 'package:meus_fiis/shared/locales.dart';
import 'package:meus_fiis/shared/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ColorScheme get _colorScheme => ColorScheme.fromSeed(
        seedColor: const Color(0xff5b6965),
      );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meus FIIs',
      theme: ThemeData(
        colorScheme: _colorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          color: _colorScheme.inversePrimary,
        ),
        scaffoldBackgroundColor: const Color(0xffDFE4E2),
      ),
      translations: In18Messages(),
      locale: Locales.ptBR,
      fallbackLocale: Locales.enUS,
      initialRoute: Routes.dashboard.route,
      getPages: [
        GetPage(
          name: Routes.dashboard.route,
          page: () => const DashboardPage(),
        ),
      ],
    );
  }
}
