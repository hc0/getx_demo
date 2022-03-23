import 'package:get/get.dart';

import 'state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();

  void updateIndex(int index) {
    state.currentIndex.value = index;
  }
}
