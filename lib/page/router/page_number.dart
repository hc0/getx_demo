import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/common/routes/app_pages.dart';
import 'package:getx_demo/common/routes/app_router_obsever.dart';

class PageNumber extends StatefulWidget {
  const PageNumber({Key? key}) : super(key: key);

  @override
  State<PageNumber> createState() => _PageNumberState();
}

class _PageNumberState extends State<PageNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['number']),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                AppRouter.share.open(
                  Paths.page1,
                  arguments: {'number': '1'},
                  preventDuplicates: false,
                );
              },
              child: const Text('page 1'),
            ),
            ElevatedButton(
              onPressed: () {
                AppRouter.share.open(
                  Paths.page2,
                  arguments: {'number': '2'},
                  preventDuplicates: false,
                );
              },
              child: const Text('page 2'),
            ),
            ElevatedButton(
              onPressed: () {
                AppRouter.share.open(
                  Paths.page3,
                  arguments: {'number': '3'},
                  preventDuplicates: false,
                );
              },
              child: const Text('page 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('pop'),
            ),
            ElevatedButton(
              onPressed: () {
                AppRouter.share.replace(
                  Paths.page2,
                  arguments: {'number': '2'},
                );
              },
              child: const Text('Replace to 2'),
            ),
            ElevatedButton(
              onPressed: () {
                AppRouter.share.until(
                  Paths.page1,
                  Paths.main,
                  arguments: {'number': '1'},
                );
              },
              child: const Text('unit to 1'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Text('\nGet:'
                  '\n当前路由:${Get.currentRoute}'
                  '\n上一个路由:${Get.previousRoute}'
                  '\n本地:'
                  '\n当前路由:${AppRouter.share.currentRoute}'
                  '\n上一个路由-绝对:${AppRouter.share.previousRoute}'
                  '\npageRoute=${AppRouter.share.pageRoute.toString()}'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
