import 'package:get/get.dart';
import 'package:meus_fiis/shared/locales.dart';

enum In18 {
  navBarDashboardLabel,
  navBarFiiLabel,
  navBarOperationsLabel,
}

class In18Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    Locales.ptBR.toString(): {
      In18.navBarDashboardLabel.name: 'Visão geral',
      In18.navBarFiiLabel.name: 'Ativos',
      In18.navBarOperationsLabel.name: 'Operações',
    },
  };
}