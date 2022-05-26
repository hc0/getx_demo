import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';

///锚点
class LinkPage extends StatefulWidget {
  const LinkPage({Key? key}) : super(key: key);

  @override
  State<LinkPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<LinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滚动'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('sliver'),
              onPressed: () {
                Get.toNamed(Paths.sliver);
              },
            ),
            ElevatedButton(
              child: const Text('tw_anchor'),
              onPressed: () {
                Get.toNamed(Paths.anchor);
              },
            ),
            ElevatedButton(
              child: const Text('scrollable_position'),
              onPressed: () {
                Get.toNamed(Paths.scrollablePosition);
              },
            ),
            ElevatedButton(
              child: const Text('custom_anchor'),
              onPressed: () {
                Get.toNamed(Paths.customAnchor);
              },
            ),
            ElevatedButton(
              child: const Text('link_anchor'),
              onPressed: () {
                Get.toNamed(Paths.linkAnchor);
              },
            ),
          ],
        ),
      ),
    );
  }
}
