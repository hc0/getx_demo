import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ScrollViewPage extends StatelessWidget {
  final logic = Get.put(ScrollViewLogic());
  final state = Get.find<ScrollViewLogic>().state;

  ScrollViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
