import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meus_fiis/modules/home/controller.dart';
import 'package:meus_fiis/modules/home/views/dashboard/view.dart';
import 'package:meus_fiis/modules/home/views/operation/view.dart';
import 'package:meus_fiis/modules/home/views/wallet/view.dart';
import 'package:meus_fiis/shared/in18.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandablePageView(
        onPageChanged: controller.changeView,
        controller: controller.viewController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          DashboardView(),
          WalletView(),
          OperationsView(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80.0,
          onDestinationSelected: controller.changeView,
          selectedIndex: controller.currentIndex.value,
          destinations: [
            NavigationDestination(
              icon: Icon(MdiIcons.chartPie),
              label: In18.navBarDashboardLabel.name.tr,
            ),
            NavigationDestination(
              icon: Icon(MdiIcons.chartBar),
              label: In18.navBarFiiLabel.name.tr,
            ),
            NavigationDestination(
              icon: Icon(MdiIcons.plusMinusVariant),
              label: In18.navBarOperationsLabel.name.tr,
            ),
          ],
        ),
      ),
    );
  }
}
