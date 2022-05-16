import 'package:get/get.dart';

import 'state.dart';

class GetStateLogic extends GetxController {
  final GetStateState state = GetStateState();

  @override
  void onInit() {
    print('test onInit 进入了');
    super.onInit();
    state.pageNumber = getValue('pageNumber');
    state.topNumber.value = getValue('topNumber', defaultValue: 1);
    state.bottomNumber.value = getValue('bottomNumber', defaultValue: 99);

    print('test pageNumber=${state.pageNumber}');
  }

  int getValue(String key, {int defaultValue = 0}) {
    Map? map = Get.arguments;
    if (map == null || map.isEmpty) return defaultValue;
    if (map.containsKey(key)) {
      return map[key];
    }
    return defaultValue;
  }
}
