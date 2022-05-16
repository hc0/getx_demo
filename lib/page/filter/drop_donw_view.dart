import 'package:flutter/material.dart';
import 'package:getx_demo/page/filter/drop_down_content_view.dart';

///筛选-tab
class DropDownView extends StatefulWidget {
  final Widget child;
  final Widget displayView;

  const DropDownView({
    Key? key,
    required this.child,
    required this.displayView,
  }) : super(key: key);

  @override
  State<DropDownView> createState() => _DropDownViewState();
}

class _DropDownViewState extends State<DropDownView> {
  UniqueKey key = UniqueKey();
  LayerLink link = LayerLink();
  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CompositedTransformTarget(
        link: link,
        child: Container(
          alignment: Alignment.center,
          color: Colors.green,
          height: 50,
          child: widget.child,
        ),
      ),
    );
  }

  ///获取当前位置
  Rect get globalRect {
    var renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  ///点击事件
  void onTap() {
    if (entry == null) {
      entry = OverlayEntry(
        builder: (_) {
          return DropDownContentView(
            link: link,
            globalRect: globalRect,
            hideView: hideView,
            child: widget.displayView,
          );
        },
      );
      Overlay.of(context)?.insert(entry!);
    } else {
      hideView();
    }
  }

  void hideView() {
    entry?.remove();
    entry = null;
  }
}
