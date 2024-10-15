import 'package:get/get.dart';
import 'package:meus_fiis/shared/locales.dart';

enum In18 {
  dashboardTitle
}

class In18Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    Locales.ptBR.toString(): {
      In18.dashboardTitle.name: 'Visão geral',
    },
    Locales.enUS.toString(): {
      In18.dashboardTitle.name: 'Visão geral',
    },
  };
}