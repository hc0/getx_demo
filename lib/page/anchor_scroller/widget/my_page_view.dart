import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 父控件执行页面刷新时，校验PageView的状态是否会改变
/// 使用时新增GlobalKey 不会进行刷新
class MyPageView extends StatefulWidget {
  final List<String> tabs;

  const MyPageView({Key? key, required this.tabs}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  SwiperControl swiperControl = const SwiperControl();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.primaries[index],
            margin: const EdgeInsets.all(16),
            child: Text(
              widget.tabs[index],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
        itemCount: widget.tabs.length,
        // pagination: DotSwiperPaginationBuilder(),
        outer: true,
        control: swiperControl,
        itemWidth: 0.5.sw,
        layout: SwiperLayout.STACK,
        axisDirection: AxisDirection.right,
      ),
    );
  }
}
