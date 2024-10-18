import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_fiis/modules/home/binding.dart';
import 'package:meus_fiis/modules/home/page.dart';
import 'package:meus_fiis/modules/home/views/operation/binding.dart';
import 'package:meus_fiis/shared/in18.dart';
import 'package:meus_fiis/shared/locales.dart';
import 'package:meus_fiis/shared/n_widgets/n_config.dart';
import 'package:meus_fiis/shared/routes.dart';
import 'package:meus_fiis/shared/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ColorScheme get _colorScheme => ColorScheme.fromSeed(
        seedColor: const Color(0xff5b6965),
      );

  @override
  Widget build(BuildContext context) {
    return NConfig(
      dropdownHintText: In18.sharedSelectionHintText.name.tr,
      child: GetMaterialApp(
        title: 'Meus FIIs',
        theme: ThemeData(
          colorScheme: _colorScheme,
          splashColor: _colorScheme.secondary.withOpacity(0.10),
          highlightColor: _colorScheme.secondary.withOpacity(0.10),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            color: _colorScheme.inversePrimary,
          ),
          scaffoldBackgroundColor: const Color(0xffDFE4E2),
        ),
        translations: In18Messages(),
        locale: Locales.ptBR,
        fallbackLocale: Locales.enUS,
        initialRoute: Routes.home.route,
        getPages: [
          GetPage(
            name: Routes.home.route,
            page: () => const HomePage(),
            binding: HomeBinding(),
            bindings: [OperationBinding()],
          ),
        ],
      ),
    );
  }
}
