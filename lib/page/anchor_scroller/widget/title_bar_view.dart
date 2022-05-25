import 'package:flutter/material.dart';
import 'package:get/get.dart';

///标题栏
class TitleBarView extends StatelessWidget {
  final AnimationController animationController;
  final double statusBarHeight;
  final List<String> tabs;
  final TabController tabController;
  final double titleHeight;
  final double tabHeight;

  const TitleBarView({
    Key? key,
    required this.animationController,
    required this.statusBarHeight,
    required this.tabs,
    required this.tabController,
    required this.titleHeight,
    required this.tabHeight,
  }) : super(key: key);

  //标题栏-图标颜色动画
  Animation get animationIconColor =>
      ColorTween(begin: Colors.white, end: Colors.black)
          .animate(animationController);

  //标题栏-标题颜色动画
  Animation get animationTitleColor =>
      ColorTween(begin: Colors.transparent, end: Colors.black)
          .animate(animationController);

  //标题栏-背景色动画
  Animation get animationTitleBarColor =>
      ColorTween(begin: Colors.transparent, end: Colors.white)
          .animate(animationController);

  //标题栏-tab透明度动画
  Animation get animationOpacityTab =>
      Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.only(top: statusBarHeight),
          color: animationTitleBarColor.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              topTitleBar(context),
              topTab(),
            ],
          ),
        );
      },
    );
  }

  ///标题视图
  Widget topTitleBar(BuildContext context) {
    return SizedBox(
      height: titleHeight,
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: animationIconColor.value,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'title',
                style: TextStyle(
                  fontSize: 18,
                  color: animationTitleColor.value,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: animationIconColor.value,
            ),
          )
        ],
      ),
    );
  }

  ///tab视图
  Widget topTab() {
    return IgnorePointer(
      ignoring: animationOpacityTab.value == 0,
      child: Opacity(
        opacity: animationOpacityTab.value,
        child: SizedBox(
          height: tabHeight,
          child: TabBar(
            isScrollable: true,
            controller: tabController,
            tabs: [
              for (var element in tabs)
                Tab(
                  child: Text(
                    element,
                    style: TextStyle(
                      color: animationTitleColor.value,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
