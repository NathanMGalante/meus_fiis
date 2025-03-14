import 'package:get/get.dart';
import 'package:meus_fiis/shared/locales.dart';

enum In18 {
  navBarDashboardLabel,
  navBarFiiLabel,
  navBarOperationsLabel,
  operationButtonText,
  operationTagLabel,
  operationTypeLabel,
  operationDateLabel,
  operationQuantityLabel,
  operationPriceLabel,
  operationTotalLabel,
  sharedSelectionHintText,
  sharedSearchHintText,
  sharedTryAgainText,
  sharedNoDataText,
  operationTypeBuyText,
  operationTypeSellText,
}

class In18Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    Locales.ptBR.toString(): {
      In18.navBarDashboardLabel.name: 'Visão geral',
      In18.navBarFiiLabel.name: 'Ativos',
      In18.navBarOperationsLabel.name: 'Operações',
      In18.operationButtonText.name: 'Nova operação',
      In18.operationTagLabel.name: 'Ativo',
      In18.operationTypeLabel.name: 'Operação',
      In18.operationDateLabel.name: 'Data',
      In18.operationQuantityLabel.name: 'Quantidade',
      In18.operationPriceLabel.name: 'Valor',
      In18.operationTotalLabel.name: 'Total',
      In18.sharedSelectionHintText.name: 'Selecione',
      In18.sharedSearchHintText.name: 'Pesquisar',
      In18.sharedTryAgainText.name: 'Tentar novamente',
      In18.sharedNoDataText.name: 'Nenhum item encontrado',
      In18.operationTypeBuyText.name: 'Compra',
      In18.operationTypeSellText.name: 'Venda',
    },
  };
}