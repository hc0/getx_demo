import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getx_demo/common/services/global_service.dart';
import 'package:getx_demo/common/widget/link_anchor/widget_position_model.dart';

///动画通知-用于滚动外的视图动画联动
typedef AnimationNotification = Function(double value);

///位置通知
typedef PositionNotification = Function(int index);

///滚动通知
typedef ScrollNotification = Function(ScrollController controller);

class LinkAnchorController {
  ///默认值
  final int initIndex;

  ///定位时向下偏移量
  final double offset;

  ///子视图个数
  late int itemCount;

  ///子视图起始位置
  List<WidgetPosition> widgetPositions = [];

  ///滚动视图key
  final GlobalKey scrollGlobalKey = GlobalKey();

  ///滚动控件大小
  late Size _scrollSize;

  ///子视图key
  late List<GlobalKey> globalKeys;

  ///滚动控制器
  late ScrollController scrollController;

  ///对应tab的下标
  int? _currentToTabIndex;

  ///滚动锁-防止多次滚动计算
  bool _scrollLock = false;

  ///上次滚动的位置
  double _previousPixels = 0;

  ///动画回调
  AnimationNotification? animationNotification;

  ///位置回调
  PositionNotification? positionNotification;

  ///滚动通知
  ScrollNotification? scrollNotification;

  ///更新树
  late VoidCallback reBuildView;

  LinkAnchorController({
    this.initIndex = 0,
    this.offset = 0,
    this.animationNotification,
    this.positionNotification,
    this.scrollNotification,
  });

  ///滚动监听
  void scrollListener() {
    //通知外部
    _scrollNotification();

    //记录滚动距离
    _previousPixels = scrollController.position.pixels;

    //计算位置
    if (!_scrollLock) {
      //记录上次位置
      int? tempTabIndex = _currentToTabIndex;
      //计算对应tab的下标位置
      _getCurrentToTabIndex(scrollController.position.pixels);
      //判断与上次是否同一个视图位置
      if (tempTabIndex != _currentToTabIndex) {
        _toPositionNotification(_currentToTabIndex!);
      }
    }

    //滚动是动画联动
    double displayHeight = (widgetPositions.first.size.height - offset).abs();
    double temp = scrollController.position.pixels.clamp(0, displayHeight) /
        displayHeight;
    _toAnimationNotification(temp);
  }

  ///用于滚动是通知
  void _scrollNotification() {
    scrollNotification?.call(scrollController);
  }

  ///用于动画值变化通知
  void _toAnimationNotification(double value) {
    animationNotification?.call(value);
  }

  ///用于位置变化通知
  void _toPositionNotification(int index) {
    positionNotification?.call(index);
  }

  ///获取-子视图位置
  void getPosition() {
    //滚动视图
    RenderBox scrollRenderBox =
        scrollGlobalKey.currentContext!.findRenderObject() as RenderBox;
    //滚动视图-大小
    _scrollSize = scrollRenderBox.size;
    //滚动视图-相对于原点 控件的位置
    Offset scrollOffset = scrollRenderBox.localToGlobal(Offset.zero);

    widgetPositions.clear();
    int globalKeyLength = globalKeys.length;

    //倒序遍历-为了计算控件距离scroll底部距离
    double tempHeight = 0;
    for (int index = globalKeyLength - 1; index >= 0; index--) {
      RenderBox widgetRenderBox =
          globalKeys[index].currentContext?.findRenderObject() as RenderBox;
      //子控件大小
      Size widgetSize = widgetRenderBox.size;
      //相对于原点-子控件的位置
      Offset widgetOffset = widgetRenderBox.localToGlobal(Offset.zero);
      //子控件-开始与结束坐标(+previousPixels 是为了视图刷新时已经有滚动过了)
      double begin = widgetOffset.dy - scrollOffset.dy + _previousPixels;
      double end = begin + widgetSize.height;

      widgetPositions.insert(
        0,
        WidgetPosition(
          index: index,
          begin: begin,
          end: end,
          size: widgetSize,
          endToScrollEndHeight: tempHeight,
        ),
      );
      tempHeight += widgetSize.height;

      print(
          'test index=$index tempHeight=$tempHeight currentHeight=${widgetSize.height} scrollMaxHeight=${scrollController.position.maxScrollExtent}');
    }
  }

  ///设置初始值
  void setInitIndex() {
    if (initIndex == 0) return;
    jumpToIndex(initIndex);
    _toPositionNotification(initIndex);
  }

  ///获取-对应tab的下标
  void _getCurrentToTabIndex(double pixels) {
    //兼容顶部偏移量
    pixels += offset;
    //判断是否还是当前下标位置
    if (_currentToTabIndex != null) {
      WidgetPosition current = widgetPositions[_currentToTabIndex!];
      if (pixels > current.begin && pixels < current.end) {
        return;
      }
    }
    //判断对应下标
    for (int index = 0; index < widgetPositions.length; index++) {
      WidgetPosition element = widgetPositions[index];
      if (pixels >= element.begin && pixels <= element.end) {
        _currentToTabIndex = index;
        break;
      }
    }
  }

  ///跳转制定偏移量
  Future<void> jumpToOffset(
    double offset, {
    bool animated = false,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.linear,
  }) async {
    //滚动锁
    if (_scrollLock) return;
    _scrollLock = true;
    if (animated) {
      await scrollController.animateTo(
        offset,
        duration: duration,
        curve: curve,
      );
    } else {
      scrollController.jumpTo(offset);
    }
    _scrollLock = false;
  }

  ///跳转对应位置
  Future<void> jumpToIndex(
    int index, {
    bool animated = false,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.linear,
  }) async {
    //滚动锁
    if (_scrollLock) return;
    _scrollLock = true;
    //防止超出下标
    index = index.clamp(0, itemCount - 1);
    WidgetPosition temp = widgetPositions[index];
    //对应位置的视图y坐标 + 向下的偏移量
    double jumpOffset = temp.begin;
    if (temp.begin - offset <= 0) {
      //跳转至顶部-超出scroll最上方-重置为scroll最顶部
      jumpOffset = 0;
    } else if (temp.endToScrollEndHeight + temp.size.height <
        _scrollSize.height - offset) {
      //防止滚动距离过大而回弹
      double toUpOffset =
          _scrollSize.height - temp.endToScrollEndHeight - temp.size.height;
      jumpOffset -= toUpOffset;
    } else {
      jumpOffset -= offset;
    }
    if (animated) {
      await scrollController.animateTo(
        jumpOffset,
        duration: duration,
        curve: curve,
      );
    } else {
      scrollController.jumpTo(jumpOffset);
    }
    _scrollLock = false;
  }

  ///更新视图并重新计算
  ///
  /// 滚动视图内部控件在局部刷新时，高度有变化 需要[重新计算]
  ///
  ///duration：内容控件高度变化可能有动画，延迟是为了在动画结束后在计算
  void updateAndCalculate({
    bool didUpdate = false,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    //延迟作用：内容控件高度变化可能有动画，在动画结束后在计算
    if (didUpdate) {
      _updateAndCalculate();
    } else {}
    Future.delayed(duration, () {
      _updateAndCalculate();
    });
  }

  void _updateAndCalculate() {
    scrollController.removeListener(scrollListener);
    globalKeys = List.generate(itemCount, (index) => GlobalKey());
    reBuildView();
    ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((timeStamp) {
      getPosition();
      scrollController.addListener(scrollListener);
    });
  }
}
