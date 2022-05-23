import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageViewFooter extends RefreshIndicator {
  final String? idleText;
  final String? refreshText;
  final TextStyle? textStyle;
  final Icon? icon;

  const PageViewFooter({
    Key? key,
    RefreshStyle refreshStyle = RefreshStyle.Follow,
    double height = 60.0,
    Duration completeDuration = Duration.zero,
    this.idleText,
    this.refreshText,
    this.textStyle,
    this.icon,
  }) : super(
          key: key,
          refreshStyle: refreshStyle,
          completeDuration: completeDuration,
          height: height,
        );

  @override
  State createState() => _ClassicHeaderState();
}

class _ClassicHeaderState extends RefreshIndicatorState<PageViewFooter> {
  Widget _buildText(mode) {
    String value = "";
    if (mode == RefreshStatus.canRefresh) {
      value = widget.refreshText ?? '释放查看更多';
    } else {
      value = widget.idleText ?? '滑动查看更多';
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: value
          .split('')
          .map(
            (e) => Text(e, style: widget.textStyle),
          )
          .toList(),
    );
  }

  Widget _buildIcon(mode) {
    double turns;
    if (mode == RefreshStatus.canRefresh) {
      turns = 0;
    } else {
      turns = -0.5;
    }
    return AnimatedRotation(
      duration: const Duration(milliseconds: 300),
      turns: turns,
      child: widget.icon ?? const Icon(Icons.arrow_back_ios_rounded),
    );
  }

  @override
  bool needReverseAll() {
    return false;
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);

    Widget container = Column(
      mainAxisSize: MainAxisSize.min,
      children: [textWidget, iconWidget],
    );
    return SizedBox(
      width: 80.0,
      height: widget.height,
      child: Center(
        child: container,
      ),
    );
  }
}
