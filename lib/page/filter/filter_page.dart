import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getx_demo/page/filter/drop_donw_view.dart';

///筛选
class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('筛选视图'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const FlutterLogo(size: 50),
          const FlutterLogo(size: 50),
          const FlutterLogo(size: 50),
          Row(
            children: [
              const FlutterLogo(size: 50),
              const FlutterLogo(size: 50),
              const FlutterLogo(size: 50),
              DropDownView(
                displayView: Container(
                  height: 400,
                  color: Colors.primaries[Random().nextInt(17)],
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        10,
                        (index) => ListTile(
                          title: Text('$index'),
                        ),
                      ),
                    ),
                  ),
                ),
                child: const Text(
                  'tsst',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const FlutterLogo(size: 50),
          const FlutterLogo(size: 50),
          const FlutterLogo(size: 50),
          const FlutterLogo(size: 50),
        ],
      ),
    );
  }
}
