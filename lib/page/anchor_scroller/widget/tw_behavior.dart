import 'package:flutter/material.dart';

/// 去掉ios滚动的回弹效果
class TWBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
