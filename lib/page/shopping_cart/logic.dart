import 'package:get/get.dart';
import 'package:getx_demo/common/services/user_info_service.dart';

import 'state.dart';

class ShoppingCartLogic extends GetxController {
  final ShoppingCartState state = ShoppingCartState();

  @override
  void onInit() {
    super.onInit();
    state.shoppingCart = UserInfoService.to.shoppingCart;
  }
}
