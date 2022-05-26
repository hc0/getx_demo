import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getx_demo/common/services/global_service.dart';
import 'tw_anchor_scroll_view_controller.dart';
export 'tw_anchor_scroll_view_controller.dart';

/// 构建指定索引的Widget
typedef AnchorTabWidgetIndexedBuilder = Widget Function(
    BuildContext context, int index);

class TWAnchorScrollView extends StatefulWidget {
  /// 生成每一行widget
  final AnchorTabWidgetIndexedBuilder itemBuilder;

  //用于控制tab
  TabController? get tabController => controller.tabController;

  final TWAnchorScrollViewController controller;

  //设置tab与widget的个数
  final int itemCount;

  const TWAnchorScrollView(
      {Key? key,
      required this.controller,
      required this.itemBuilder,
      required this.itemCount})
      : super(key: key);

  @override
  _BrnScrollAnchorTabWidgetState createState() =>
      _BrnScrollAnchorTabWidgetState();
}

class _BrnScrollAnchorTabWidgetState extends State<TWAnchorScrollView>
    with SingleTickerProviderStateMixin {
  //用于控制 滑动
  ScrollController get scrollController => widget.controller.scrollController;

  //用于 滑动 和 tab 之间的通信
  StreamController<int> get streamController =>
      widget.controller.indexDidChanged;

  //当前选中的索引
  int get currentIndex => widget.controller.currentIndex;

  set currentIndex(value) => widget.controller.currentIndex = value;

  //每个元素在滑动组件中的位置
  List<double> get cardOffsetList => widget.controller.cardOffsetList;

  //是否点击滑动
  bool get tab => widget.controller.tab;

  //滑动组件的 key
  late GlobalKey key;

  //滑动组件的元素、
  late List<Widget> bodyWidgetList;

  //滑动组件的元素的key
  late List<GlobalKey> bodyKeyList;

  //tab
  late List<Widget> tabList;

  //滑动组件在屏幕的位置
  double listDy = 0;

  @override
  void initState() {
    key = GlobalKey();
    cardOffsetList.addAll(List.filled(widget.itemCount, -1.0));
    bodyWidgetList = [];
    bodyKeyList = [];
    tabList = [];

    // fillKeyList();
    // fillList();

    ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((da) {
      scrollController.addListener(() {
        final _scrollingListener = widget.controller.scrollingListener;
        if (_scrollingListener != null) {
          _scrollingListener(scrollController);
        }
        updateOffset();
        currentIndex = createIndex(scrollController.offset);
        //防止再次 发送消息
        if (!tab) streamController.add(currentIndex);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fillList();

    ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((da) {
      fillOffset();
    });
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: bodyWidgetList,
      ),
      key: key,
      controller: scrollController,
    );
  }

  void fillList() {
    // global key从外部传入
    // 否则如果item里面包含textfield的话
    // 会导致 rebuild后出问题
    bodyWidgetList.clear();
    bodyKeyList.clear();
    for (int i = 0, n = widget.itemCount; i < n; i++) {
      Widget innerWidget = widget.itemBuilder(context, i);
      late Widget widgetWrapper;
      late GlobalKey k;
      if (innerWidget.key != null && innerWidget.key is GlobalKey) {
        k = innerWidget.key as GlobalKey;
        widgetWrapper = innerWidget;
      } else {
        k = GlobalKey();
        widgetWrapper = Container(key: k, child: innerWidget);
      }
      bodyWidgetList.add(widgetWrapper);
      bodyKeyList.add(k);
    }
  }

  void fillOffset() {
    cardOffsetList.clear();
    cardOffsetList.addAll(List.filled(widget.itemCount, -1.0));
    Offset globalToLocal = (key.currentContext!.findRenderObject() as RenderBox)
        .localToGlobal(Offset.zero);
    listDy = globalToLocal.dy;
    for (int i = 0, n = widget.itemCount; i < n; i++) {
      if (cardOffsetList[i] == -1.0) {
        if (bodyKeyList[i].currentContext != null) {
          double cardOffset =
              (bodyKeyList[i].currentContext!.findRenderObject() as RenderBox)
                  .localToGlobal(Offset.zero) //相对于原点 控件的位置
                  .dy; //y点坐标

          cardOffsetList[i] = cardOffset + scrollController.offset - listDy;
          final offset = widget.controller.offset;
          if (i != 0 && offset != null) {
            cardOffsetList[i] = cardOffsetList[i] - offset;
            // debugPrint("fillOffset offset : $offset");
          }
        }
      }
    }
  }

  void updateOffset() {
    for (int i = 0, n = widget.itemCount; i < n; i++) {
      if (cardOffsetList[i] == -1.0) {
        if (bodyKeyList[i].currentContext != null) {
          double cardOffset =
              (bodyKeyList[i].currentContext!.findRenderObject() as RenderBox)
                  .localToGlobal(Offset.zero) //相对于原点 控件的位置
                  .dy; //y点坐标

          cardOffsetList[i] = cardOffset + scrollController.offset - listDy;
          final offset = widget.controller.offset;
          if (i != 0 && offset != null) {
            cardOffsetList[i] = cardOffsetList[i] - offset;
            debugPrint("updateOffset offset : $offset");
          }
        }
      }
    }
  }

  //根据偏移量 确定tab索引
  int createIndex(double offset) {
    int index = 0;
    for (int i = 0, n = cardOffsetList.length; i < n; i++) {
      if (offset >= cardOffsetList[i]) {
        index = i;
      }
    }
    return index;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
