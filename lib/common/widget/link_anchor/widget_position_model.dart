import 'package:flutter/material.dart';

///控件位置-开始与结束
class WidgetPosition {
  //对应tab的下标
  int index;

  //开始位置-相对scroll起始位置
  double begin;

  //结束位置-相对scroll起始位置
  double end;

  //控件大小
  Size size;

  //控件顶部距离滚动视图底部的距离
  double endToScrollEndHeight;

  WidgetPosition({
    required this.index,
    required this.begin,
    required this.end,
    required this.size,
    required this.endToScrollEndHeight,
  });
}
