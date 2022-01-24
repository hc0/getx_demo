import 'package:get/get.dart';
import 'package:getx_demo/common/entity/goods.dart';

class GoodsListState {
  GoodsListState() {
    ///Initialize variables
  }

  RxList<Goods> list = <Goods>[].obs;
}
