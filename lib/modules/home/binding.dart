import 'package:get/get.dart';
import 'package:meus_fiis/modules/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
