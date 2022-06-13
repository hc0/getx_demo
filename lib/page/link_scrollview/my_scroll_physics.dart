import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyScrollPhysics extends ScrollPhysics {
  final double startHeight;
  final double endHeight;

  //通知外部
  final Function(double offset)? overCallBack;

  //构造器
  const MyScrollPhysics({
    required this.startHeight,
    required this.endHeight,
    this.overCallBack,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return MyScrollPhysics(
      startHeight: startHeight,
      endHeight: endHeight,
      overCallBack: overCallBack,
      parent: buildParent(ancestor),
    );
  }

  /// [position] 当前的位置, [offset] 用户拖拽距离
  /// 将用户拖拽距离 offset 转为需要移动的 pixels = 上次位置与拖拽后的位置距离差
  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    overCallBack?.call(offset);

    // if (offset > 0.0) {
    //   return parent!.applyPhysicsToUserOffset(position, offset);
    // }
    //
    // if (position.outOfRange) {
    //   final double overscrollPastStart =
    //       math.max(position.minScrollExtent - position.pixels, 0.0);
    //   print('test overscrollPastStart=$overscrollPastStart');
    //   final double overscrollPastEnd = math.max(position.pixels, 0.0);
    //   print('test overscrollPastEnd=$overscrollPastEnd');
    //   final double overscrollPast =
    //       math.max(overscrollPastStart, overscrollPastEnd);
    //
    //   final bool easing = (overscrollPastStart > 0.0 && offset < 0.0) ||
    //       (overscrollPastEnd > 0.0 && offset > 0.0);
    //
    //   final double friction = easing
    //       // Apply less resistance when easing the overscroll vs tensioning.
    //       ? frictionFactor(
    //           (overscrollPast - offset.abs()) / position.viewportDimension)
    //       : frictionFactor(overscrollPast / position.viewportDimension);
    //   final double direction = offset.sign;
    //   return direction * _applyFriction(overscrollPast, offset.abs(), friction);
    // }
    return super.applyPhysicsToUserOffset(position, offset);
  }

  double frictionFactor(double overscrollFraction) =>
      0.52 * math.pow(1 - overscrollFraction, 2);

  static double _applyFriction(
    double extentOutside,
    double absDelta,
    double gamma,
  ) {
    assert(absDelta > 0);
    double total = 0.0;
    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit) {
        return absDelta * gamma;
      }
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  /// 返回 overscroll ，如果返回 0 ，overscroll 就一直是0
  /// 返回边界条件
  /// 当返回 0 时，也就是达到 0 是就边界，过了 0 的就是边界外的拖拽效果了。
  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // print(''
    //     'test minScrollExtent=${position.minScrollExtent} '
    //     'maxScrollExtent=${position.maxScrollExtent} '
    //     'viewportDimension=${position.viewportDimension}'
    //     '');



    print('test position=${position.pixels} value=$value');
    if (position.pixels - startHeight - value < 0) {
      return parent!.applyBoundaryConditions(position, value);
    }
    double topExtra = startHeight;
    final double topBoundary =
        position.minScrollExtent - startHeight - topExtra;

    print(
        'test value=$value startHeight=$startHeight  pixels=${position.pixels}');
    if (value < -startHeight && -startHeight <= position.pixels) {
      print('test 1111');
      // hit top edge
      return value + startHeight;
    }
    if (value < topBoundary && topBoundary < position.pixels) {
      print('test 2222');
      return value - topBoundary;
    }

    if (value < position.pixels && position.pixels <= topBoundary) {
      print('test 333');
      return value - position.pixels;
    }
    return 0.0;
  }

  ///创建一个滚动的模拟器
  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // final Tolerance tolerance = this.tolerance;
    //
    bool outOfRange =
        position.pixels + startHeight < position.minScrollExtent ||
            position.pixels > position.maxScrollExtent;


    // print('test ${position.outOfRange}');
    print('test velocity=$velocity');
    return BouncingScrollSimulation(
      spring: spring,
      position: position.pixels - startHeight,
      velocity: velocity,
      leadingExtent: position.minScrollExtent,
      trailingExtent: position.maxScrollExtent,
      tolerance: tolerance,
    );

    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent - startHeight,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
      );
    }
    return null;
  }

  ///最小滚动数据
  @override
  double get minFlingDistance => super.minFlingDistance;

  ///传输动量，返回重复滚动时的速度
  @override
  double carriedMomentum(double existingVelocity) {
    return super.carriedMomentum(existingVelocity);
  }

  ///最小的开始拖拽距离
  @override
  double? get dragStartDistanceMotionThreshold =>
      super.dragStartDistanceMotionThreshold;

  ///滚动模拟的公差
  ///指定距离、持续时间和速度差应视为平等的差异的结构
  @override
  Tolerance get tolerance => super.tolerance;

  ///是否接受用户的滚动
  ///false 滚动禁止  ture 可以滚动
  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return super.shouldAcceptUserOffset(position);
  }
}
