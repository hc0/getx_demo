import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

enum _Mode {
  drag, // Pointer is down.
  armed, // Dragged far enough that an up event will run the onRefresh callback.
  snap, // Animating to the indicator's final "displacement".
  refresh, // Running the refresh callback.
  done, // Animating the indicator's fade-out after refreshing.
  canceled, // Animating the indicator's fade-out after not arming.
}

const double _kDragContainerExtentPercentage = 0.25;

const double _kDragSizeFactorLimit = 1.5;

/// 自定义PageView
class CustomPageView extends StatefulWidget {
  const CustomPageView({Key? key}) : super(key: key);

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView>
    with TickerProviderStateMixin<CustomPageView> {
  /// 当前模式
  _Mode? _mode;

  ///指示器在右边
  bool? _isIndicatorAtRight;

  /// 指示器偏移量
  double _dragOffset = 0;

  /// 动画控制器
  late AnimationController _positionController;

  late PageController controller;

  @override
  void initState() {
    controller = PageController();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        print('test 000');
      }
    });
    _positionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: contentView(),
    );
  }

  Future onRefresh() async {
    await Future.delayed(const Duration(seconds: 3), () {});
  }

  Widget contentView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return AnimatedBuilder(
          animation: _positionController,
          builder: (context, _) {
            double temp = 100 * _positionController.value;
            return Padding(
              padding: EdgeInsets.only(right: temp),
              child: ListView.builder(
                physics: PageScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  alignment: Alignment.center,
                  height: constraints.maxHeight,
                  width: constraints.maxHeight,
                  color: Colors.primaries[index],
                  child: Text('$index'),
                ),
                itemCount: 2,
              ),
            );
          },
        );
      },
    );
  }


  bool _handleScrollNotification(ScrollNotification notification) {
    if (_shouldStart(notification)) {
      setState(() {
        _mode = _Mode.drag;
      });
      return false;
    }

    bool? indicatorAtRightNow;
    switch (notification.metrics.axisDirection) {
      case AxisDirection.left:
        indicatorAtRightNow = true;
        break;
      case AxisDirection.right:
        indicatorAtRightNow = false;
        break;
      case AxisDirection.up:
      case AxisDirection.down:
        indicatorAtRightNow = null;
        break;
    }
    if (indicatorAtRightNow != _isIndicatorAtRight) {
      if (_mode == _Mode.drag || _mode == _Mode.armed) {
        // print('test _dismiss  11');
      }
    } else if (notification is ScrollUpdateNotification) {
      if (_mode == _Mode.drag || _mode == _Mode.armed) {
        if (notification.metrics.extentAfter > 0.0) {
          // print('test _dismiss  22');
        } else {
          _dragOffset = _dragOffset - notification.scrollDelta!;
          // print('test offset 11  =$_dragOffset');
          _checkDragOffset(notification.metrics.viewportDimension);
        }
      }
      if (_mode == _Mode.armed && notification.dragDetails == null) {
        print('test show 11');
      }
    } else if (notification is OverscrollNotification) {
      if (_mode == _Mode.drag || _mode == _Mode.armed) {
        _dragOffset = _dragOffset - notification.overscroll;
        // print('test offset 22  =$_dragOffset');
        _checkDragOffset(notification.metrics.viewportDimension);
      }
    } else if (notification is ScrollEndNotification) {
      switch (_mode) {
        case _Mode.armed:
          // print('test show  22');
          break;
        case _Mode.drag:
          // print('test _dismiss  33');
          break;
        case _Mode.canceled:
        case _Mode.done:
        case _Mode.refresh:
        case _Mode.snap:
        case null:
          // do nothing
          break;
      }
      _dragOffset = 0;
      _mode = null;
      _isIndicatorAtRight = null;
      _positionController.value = 0;
    }
    return false;
  }

  void _checkDragOffset(double containerExtent) {
    assert(_mode == _Mode.drag || _mode == _Mode.armed);
    double newValue =
        _dragOffset / (containerExtent * _kDragContainerExtentPercentage);
    if (_mode == _Mode.armed) {
      newValue = math.max(newValue, 1.0 / _kDragSizeFactorLimit);
    }
    newValue = newValue.abs();
    _positionController.value =
        newValue.clamp(0.0, 1.0); // this triggers various rebuilds
  }

  bool _shouldStart(ScrollNotification notification) {
    return ((notification is ScrollStartNotification &&
                notification.dragDetails != null) ||
            (notification is ScrollUpdateNotification &&
                notification.dragDetails != null)) &&
        notification.metrics.extentAfter == 0.0 &&
        _mode == null &&
        _start(notification.metrics.axisDirection);
  }

  bool _start(AxisDirection direction) {
    // print('test _start');
    assert(_mode == null);
    assert(_isIndicatorAtRight == null);
    switch (direction) {
      case AxisDirection.left:
        _isIndicatorAtRight = true;
        break;
      case AxisDirection.right:
        _isIndicatorAtRight = false;
        break;
      case AxisDirection.up:
      case AxisDirection.down:
        _isIndicatorAtRight = null;
        return false;
    }
    _dragOffset = 0.0;
    _positionController.value = 0.0;
    return true;
  }

  @override
  void dispose() {
    _positionController.dispose();
    super.dispose();
  }
}
