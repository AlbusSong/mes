import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import '../../Others/View/MESSquareItemWidget.dart';

import 'MoldInPage.dart';

class MoldPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map> functionItemDataArray = [
    {"title": "模具入库", "icon": "", "badgeValue": 0},
    {"title": "模具出库", "icon": "", "badgeValue": 0},
    {"title": "模具锁定", "icon": "", "badgeValue": 0},
    {"title": "模具解锁", "icon": "", "badgeValue": 0},
    {"title": "保养申请", "icon": "", "badgeValue": 0},
    {"title": "维修申请", "icon": "", "badgeValue": 0},
    {"title": "模具信息", "icon": "", "badgeValue": 0},
  ];

  final List<MESSquareItemWidget> functionItemArray = [];

  @override
  Widget build(BuildContext context) {
    _initSomeThings();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("设备管理(EES)"),
        centerTitle: true,
      ),
      body: _buildGridView(),
    );
  
  }

  void _initSomeThings() {
    functionItemArray.clear();
    for (int i = 0; i < functionItemDataArray.length; i++) {
      Map functionItemData = functionItemDataArray[i];
      MESSquareItemWidget item =
          _buildFunctionModuleItem(functionItemData["title"], i);
      functionItemArray.add(item);
    }
  }

  Widget _buildFunctionModuleItem(String title, int index) {
    void Function(int) onClick = (int v) {
      _functionItemClickedAtIndex(v);
    };
    return MESSquareItemWidget(index, title, 0, onClick);
  }

  void _functionItemClickedAtIndex(int index) {

    if (index == 0) {

    }
    Navigator.of(_scaffoldKey.currentContext).push(MaterialPageRoute(
              builder: (BuildContext context) => MoldInPage()));
  }
  
  Widget _buildGridView() {
    return GridView(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        childAspectRatio: 1 / 0.95,
      ),
      children: this.functionItemArray,
    );
  }
}