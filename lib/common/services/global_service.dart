import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

///全局服务
class GlobalService extends GetxService {
  static GlobalService get to => Get.find();

  Future<GlobalService> init() async {
    await GetStorage.init();
    return this;
  }
}
