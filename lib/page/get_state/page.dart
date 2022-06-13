import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/page/get_state/state.dart';

import 'logic.dart';

class GetStatePage extends StatelessWidget {
  // final logic = Get.put(GetStateLogic(), tag:'${ Get.arguments?['pageNumber'] ?? 1}');
  // final state = Get.find<GetStateLogic>().state;

  // final GetStateLogic logic = Get.put(
  //   GetStateLogic(),
  //   tag: '${Get.arguments?['pageNumber'] ?? 1}',
  // );

  late final GetStateLogic logic;

  GetStateState get state => logic.state;

  GetStatePage({Key? key}) : super(key: key) {
    logic = GetStateLogic();
    Get.create(() => logic);
  }

  @override
  Widget build(BuildContext context) {
    // Get.create(() => GetStateLogic());
    // //
    // // Get.create(() => GetStateLogic(),tag: 'tag');
    // //
    // Get.putAsync<GetStateLogic>(
    //   () => Future.value(GetStateLogic()),
    //   tag: '${Get.arguments?['pageNumber'] ?? 1}',
    // );
    //
    // Get.lazyPut(
    //   () => GetStateLogic(),
    //   tag: '${Get.arguments?['pageNumber'] ?? 1}',
    // );
    // //
    // // Get.create(() => null);
    //
    // GetBuilder<GetStateLogic>(
    //   builder: (logic) {
    //     return Container();
    //   },
    // );
    //
    // GetX<GetStateLogic>(
    //   initState: (state) {},
    //   builder: (logic) {
    //     return Container();
    //   },
    //   dispose: (state) {},
    // );
    //
    // ValueBuilder<GetStateLogic>(
    //   //初始值
    //   initialValue: GetStateLogic(),
    //   //视图
    //   builder: (logic, _) {
    //     return Container();
    //   },
    //   //销毁时
    //   onDispose: () {},
    // );
    //
    // SimpleBuilder(
    //   builder: (context) {
    //     return Container();
    //   },
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('第${state.pageNumber}页'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.blue.withOpacity(0.2),
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Obx(() {
                  return Text('${state.topNumber}');
                }),
                ElevatedButton(
                  child: const Text('+1'),
                  onPressed: () {
                    state.topNumber += 1;
                  },
                ),
                ElevatedButton(
                  child: const Text('go'),
                  onPressed: () {
                    // Get.toNamed(
                    //   Paths.getState,
                    //   arguments: {
                    //     'pageNumber': state.pageNumber + 1,
                    //     'topNumber': state.topNumber.value,
                    //   },
                    //   preventDuplicates: false,
                    // );
                  },
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.green.withOpacity(0.2),
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Obx(() {
                  return Text('${state.bottomNumber}');
                }),
                ElevatedButton(
                  child: const Text('-1'),
                  onPressed: () {
                    state.bottomNumber -= 1;
                  },
                ),
                ElevatedButton(
                  child: const Text('go'),
                  onPressed: () {
                    // Get.toNamed(
                    //   Paths.getState,
                    //   arguments: {
                    //     'pageNumber': state.pageNumber + 1,
                    //     'bottomNumber': state.bottomNumber.value,
                    //   },
                    //   preventDuplicates: false,
                    // );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyPage extends GetView<GetStateLogic> {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
