import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_demo/common/widget/anchor_scroll/tw_anchor_scroll_view.dart';
import 'package:getx_demo/page/anchor_scroller/widget/my_page_view.dart';
import 'package:getx_demo/page/anchor_scroller/widget/title_bar_view.dart';
import 'package:getx_demo/page/anchor_scroller/widget/tw_behavior.dart';

///锚点-自定义视图
class TwAnchorPage extends StatefulWidget {
  const TwAnchorPage({Key? key}) : super(key: key);

  @override
  State<TwAnchorPage> createState() => _TwAnchorPageState();
}

class _TwAnchorPageState extends State<TwAnchorPage>
    with TickerProviderStateMixin {
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

  //tab控制器
  late TabController tabController;

  //动画控制器
  late AnimationController animationController;

  late TWAnchorScrollViewController anchorScrollViewController;

  GlobalKey globalKey = GlobalKey();

  ValueNotifier<double> valueNotifier = ValueNotifier<double>(200.0);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);

    tabController = TabController(length: tabs.length, vsync: this);
    anchorScrollViewController = TWAnchorScrollViewController(
      tabController: tabController,
      offset: 50 + 48 + statusBarHeight,
      autoUpdateTabbarIndex: true,
    );

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        anchorScrollViewController.jumpTo(tabController.index, animated: false);
      }
    });
    anchorScrollViewController.scrollingListener =
        (ScrollController scrollController) {
      double temp = scrollController.position.pixels.clamp(0, headerHeight) /
          headerHeight;
      animationController.value = temp;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: scrollByPositionedListView(),
          ),
          TitleBarView(
            animationController: animationController,
            tabController: tabController,
            tabs: tabs,
            statusBarHeight: statusBarHeight,
            titleHeight: titleHeight,
            tabHeight: tabHeight,
            shareTap: () {
              valueNotifier.value = 400;
            },
          ),
        ],
      ),
    );
  }

  ///滚动视图
  Widget scrollByPositionedListView() {
    return ScrollConfiguration(
      behavior: TWBehavior(),
      child: TWAnchorScrollView(
        controller: anchorScrollViewController,
        itemBuilder: (BuildContext context, int index) {
          if (index == 5) {
            return MyPageView(
              valueNotifier: valueNotifier,
              tabs: tabs,
              key: globalKey,
            );
          } else {
            return Container(
              height: 200,
              color: Colors.primaries[index],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('test $index'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        color: Colors.primaries[17 - index],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        itemCount: tabs.length,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    tabController.dispose();
    super.dispose();
  }
}
