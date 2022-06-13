import 'package:get/get.dart';

import 'logic.dart';

class BindBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BindLogic());
  }
}
