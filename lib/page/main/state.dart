import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MainState {
  MainState() {
    ///Initialize variables
  }

  RxInt currentIndex = 0.obs;

  var user = User('23').obs;
}

class User {
  String name;

  User(this.name);
}
