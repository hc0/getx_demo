import 'package:flutter/material.dart';

class DropDownContentView extends StatefulWidget {
  final LayerLink link;
  final Rect globalRect;
  final VoidCallback hideView;
  final Widget child;

  const DropDownContentView({
    Key? key,
    required this.link,
    required this.globalRect,
    required this.hideView,
    required this.child,
  }) : super(key: key);

  @override
  State<DropDownContentView> createState() => _DropDownContentViewState();
}

class _DropDownContentViewState extends State<DropDownContentView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    controller.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => hideContent(),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          CompositedTransformFollower(
            link: widget.link,
            offset: Offset(
              -widget.globalRect.left,
              widget.globalRect.height,
            ),
            child: Column(
              children: [
                SizeTransition(
                  sizeFactor:
                      CurvedAnimation(parent: controller, curve: Curves.easeIn),
                  child: widget.child,
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => hideContent(),
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                          parent: controller, curve: Curves.easeIn),
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant DropDownContentView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (controller.value == 1) {
      hideContent();
    }
  }

  /// 隐藏内容
  void hideContent() async {
    await controller.animateBack(0);
    widget.hideView.call();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
