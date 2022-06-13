import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getx_demo/page/link_scrollview/my_scroll_physics.dart';

///滚动+联动
class LinkScrollViewPage extends StatefulWidget {
  const LinkScrollViewPage({Key? key}) : super(key: key);

  @override
  State<LinkScrollViewPage> createState() => _LinkScrollViewPageState();
}

class _LinkScrollViewPageState extends State<LinkScrollViewPage> {
  int itemCount = 27;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text('滚动联动 $itemCount'),
            centerTitle: true,
          ),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: SingleChildScrollView(
                  physics: MyScrollPhysics(
                    startHeight: 50,
                    endHeight: 50,
                    overCallBack: (double offset) {
                      // print('test MyScrollPhysics=$offset');
                    },
                  ),
                  child: Column(
                    children: [
                      ...List.generate(itemCount, (index) {
                        return Container(
                          height: Random().nextInt(50) + 50.0,
                          color: Colors.primaries[index % 17],
                          alignment: Alignment.center,
                          child: Text('${index + 1}'),
                        );
                      })
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.refresh),
          ),
        );
      },
    );
  }
}
