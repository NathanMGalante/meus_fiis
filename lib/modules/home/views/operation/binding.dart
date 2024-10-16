import 'package:get/get.dart';
import 'package:meus_fiis/modules/home/views/operation/controller.dart';

class OperationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OperationController());
  }
}
