import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:getx_demo/common/services/global_service.dart';

typedef WidgetSizeChanged = Function(Size? size);

///测量控件大小-监听大小变化
class MeasureWidget extends SingleChildRenderObjectWidget {
  final WidgetSizeChanged? onChange;

  const MeasureWidget({
    required Widget child,
    this.onChange,
    Key? key,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange: onChange);
  }
}

class MeasureSizeRenderObject extends RenderProxyBox {
  late Size oldSize=Size.zero;
  final WidgetSizeChanged? onChange;

  MeasureSizeRenderObject({this.onChange});

  @override
  void performLayout() {
    super.performLayout();

    Size? newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((_) {
      onChange?.call(newSize);
    });
  }
}
