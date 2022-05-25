
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_demo/page/anchor_scroller/widget/title_bar_view.dart';

/// 联动列表
class SliverPage extends StatefulWidget {
  const SliverPage({Key? key}) : super(key: key);

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> with TickerProviderStateMixin {

  //状态栏高度
  double get statusBarHeight => ScreenUtil().statusBarHeight;

  //标题高度
  double get titleHeight => 56.w;

  //tab高度
  double get tabHeight => 48.w;

  //header高度
  double get headerHeight => titleHeight + tabHeight + statusBarHeight;

  // 子项数量
  int get itemCount => 17;

  // tab 数据
  List<String> get tabs => List.generate(itemCount, (index) => '$index');

  //滚动监听
  ScrollController scrollController = ScrollController();

  //tab控制器
  late TabController tabController;

  //动画控制器
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    tabController = TabController(length: tabs.length, vsync: this);
    scrollController.addListener(() {
      double temp = scrollController.position.pixels.clamp(0, headerHeight) /
          headerHeight;
      animationController.value = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: scrollBySliverView(),
          ),
          TitleBarView(
            animationController: animationController,
            tabController: tabController,
            tabs: tabs,
            statusBarHeight: statusBarHeight,
            titleHeight: titleHeight,
            tabHeight: tabHeight,
          ),
        ],
      ),
    );
  }

  ///滚动视图
  Widget scrollBySliverView() {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPersistentHeader(
          delegate: MySliverPersistentHeader(
            height: headerHeight,
            elevation: 1,
            child: Image.asset(
              'assets/png/header_bg.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 200,
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                height: 200,
                color: Colors.primaries[index],
                child: Column(
                  children: [
                    Text('Tilte $index'),
                    Expanded(
                      child: Container(
                        color: Colors.primaries[itemCount - index],
                      ),
                    )
                  ],
                ),
              );
            },
            childCount: itemCount,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }
}

class MySliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final double elevation;
  final Widget? child;

  MySliverPersistentHeader({
    required this.height,
    this.elevation = 0,
    this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Material(
        // 若标题栏下面有内容（被钉住），则渲染投影
        elevation: overlapsContent ? elevation : 0.0,
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
