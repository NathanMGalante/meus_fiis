import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meus_fiis/modules/home/controller.dart';
import 'package:meus_fiis/modules/home/views/dashboard/view.dart';
import 'package:meus_fiis/modules/home/views/operations/view.dart';
import 'package:meus_fiis/shared/in18.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ExpandablePageView(
          onPageChanged: controller.changeView,
          controller: controller.viewController,
          children: const [
            DashboardView(),
            OperationsView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: controller.changeView,
          selectedIndex: controller.currentIndex.value,
          destinations: [
            NavigationDestination(
              icon: Icon(MdiIcons.chartPie),
              label: In18.navBarDashboardLabel.name.tr,
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
