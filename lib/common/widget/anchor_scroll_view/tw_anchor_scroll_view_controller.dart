/*
 * @Author: liruiqin
 * @Date: 2021-12-13 13:36:15
 * @Description: 
 */
import 'dart:async';

import 'package:flutter/material.dart';

typedef TWAnchorScrollViewControllerCallback = void Function(
    ScrollController scrollController);

class TWAnchorScrollViewController {
  TWAnchorScrollViewController(
      {this.tabController, this.offset, this.autoUpdateTabbarIndex = false}) {
    debugPrint("TWAnchorScrollViewController offset : $offset");
    scrollController = ScrollController();
    indexDidChanged = StreamController.broadcast();
    indexDidChanged.stream.listen((event) {
      if (autoUpdateTabbarIndex && tabController != null) {
        tabController!.index = event;
      }
    });
  }

  /// 自动更新tabbar的index
  /// 要保证这个tabbar的itemCount和itemCount一致
  bool autoUpdateTabbarIndex;

  /// 用于管理tabbar
  TabController? tabController;

  /// 用于控制 滑动
  late ScrollController scrollController;

  /// 用于 滑动 和 tab 之间的通信，当滚动到某个item的时候触发
  late StreamController<int> indexDidChanged;

  /// 当前选中的索引
  int currentIndex = 0;

  /// 是否点击滑动
  bool tab = false;

  /// 定位之后的偏移
  double? offset;

  /// 每个元素在滑动组件中的位置
  List<double> cardOffsetList = [];

  /// 监听回调
  TWAnchorScrollViewControllerCallback? scrollingListener;

  /// 跳转到指定index
  void jumpTo(int index, {bool animated = true, int milliseconds = 100}) {
    currentIndex = index;
    if (animated) {
      tab = true;
      scrollController
          .animateTo(cardOffsetList[index],
              duration: Duration(milliseconds: milliseconds),
              curve: Curves.linear)
          .whenComplete(() {
        tab = false;
      });
    } else {
      scrollController.jumpTo(cardOffsetList[index]);
    }
  }
}
