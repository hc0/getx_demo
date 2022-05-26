import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 父控件执行页面刷新时，校验PageView的状态是否会改变
/// 使用时新增GlobalKey 不会进行刷新
class MyPageView extends StatelessWidget {
  final List<String> tabs;
  final ValueNotifier<double> valueNotifier;

  const MyPageView({
    Key? key,
    required this.tabs,
    required this.valueNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: valueNotifier,
      builder: (BuildContext context, value, Widget? child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: value,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.primaries[index],
                margin: const EdgeInsets.all(16),
                child: Text(
                  tabs[index],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
            itemCount: tabs.length,
            // pagination: DotSwiperPaginationBuilder(),
            outer: true,
            itemWidth: 0.5.sw,
            layout: SwiperLayout.STACK,
            axisDirection: AxisDirection.right,
          ),
        );
      },
    );
  }
}
