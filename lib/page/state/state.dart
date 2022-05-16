import 'package:get/get_rx/src/rx_types/rx_types.dart';

class StateState {
  StateState() {
    ///Initialize variables
  }

  int pageNumber = 1;

  RxInt currentNumber = 1.obs;

  RxInt subNumber = 99.obs;
}
