import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_demo/common/widget/link_anchor/link_anchor_controller.dart';
import 'package:getx_demo/common/widget/link_anchor/link_anchor_view.dart';
import 'package:getx_demo/page/anchor_scroller/widget/my_page_view.dart';
import 'package:getx_demo/page/anchor_scroller/widget/title_bar_view.dart';

class LinkAnchorPage extends StatefulWidget {
  const LinkAnchorPage({Key? key}) : super(key: key);

  @override
  State<LinkAnchorPage> createState() => _LinkAnchorPageState();
}

class _LinkAnchorPageState extends State<LinkAnchorPage>
    with TickerProviderStateMixin {
  ///状态栏高度
  double get statusBarHeight => ScreenUtil().statusBarHeight;

  ///标题高度
  double get titleHeight => 56.w;

  ///tab高度
  double get tabHeight => 48.w;

  ///header高度
  double get headerHeight => titleHeight + tabHeight + statusBarHeight;

  ///tab数据
  List<String> get tabs => List.generate(8, (index) => ' ${index + 1} ');

  ///动画控制器
  late AnimationController animationController;

  ///子视图个数
  int itemCount = 14;

  ///tab控制器
  late TabController tabController;

  ///定位时向下偏移量
  double get toOffset => headerHeight;

  late LinkAnchorController linkAnchorController;

  bool toggle = false;

  @override
  void initState() {
    super.initState();
    //初始化-动画控制器
    animationController = AnimationController(vsync: this);
    tabController = TabController(length: tabs.length, vsync: this)
      ..addListener(() {
        if (tabController.indexIsChanging) {
          int tempIndex = tabController.index.clamp(0, tabs.length);
          linkAnchorController.jumpToIndex(tempIndex);
        }
      });
    linkAnchorController = LinkAnchorController(
      offset: headerHeight,
      animationNotification: (double value) {
        animationController.value = value;
      },
      positionNotification: (int index) {
        int tempIndex = index.clamp(0, tabs.length);
        tabController.index = tempIndex;
      },
      scrollNotification: (scrollController) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: LinkAnchorView(
                    controller: linkAnchorController,
                    itemCount: 10,
                    build: (BuildContext context, int index) {
                      if (index == 0) {
                        return AnimatedContainer(
                          height: toggle ? 400 : 600,
                          color: toggle
                              ? Colors.primaries[index]
                              : Colors.primaries.reversed.toList()[index],
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 300),
                          child: Text(toggle ? '我是图片' : '我是视频'),
                        );
                      } else if (index == 5) {
                        return MyPageView(tabs: tabs);
                      } else {
                        return Container(
                          height: 200,
                          color: Colors.primaries[index],
                          child: Column(
                            children: [
                              Text('Tilte ${index + 1}'),
                              Expanded(
                                child: Container(
                                  color: Colors.primaries[itemCount - index],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                TitleBarView(
                  animationController: animationController,
                  tabController: tabController,
                  tabs: tabs,
                  statusBarHeight: statusBarHeight,
                  titleHeight: titleHeight,
                  tabHeight: tabHeight,
                  shareTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    animationController.dispose();
    super.dispose();
  }
}
