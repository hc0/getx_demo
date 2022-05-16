import 'package:get/get.dart';

import 'state.dart';

class GoodsDetailLogic extends GetxController {
  final GoodsDetailState state = GoodsDetailState();

  @override
  void onInit() {
    super.onInit();
    state.bean = Get.arguments['bean'];
  }
}
