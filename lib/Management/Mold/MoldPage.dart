import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import '../../Others/View/MESSquareItemWidget.dart';

import 'MoldInPage.dart';
import 'MoldOutPage.dart';
import 'MoldLockPage.dart';
import 'MoldUnlockPage.dart';
import 'MoldMaintenanceAppllicationPage.dart';
import 'MoldRepairmentApplicationPage.dart';
import 'MoldInfoPage.dart';

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
    Widget w;
    if (index == 0) {
      w = MoldInPage();
    } else if (index == 1) {
      w = MoldOutPage();
    } else if (index == 2) {
      w = MoldLockPage();
    } else if (index == 3) {
      w = MoldUnlockPage();
    } else if (index == 4) {
      w = MoldMaintenanceAppllicationPage();
    } else if (index == 5) {
      w = MoldRepairmentApplicationPage();
    } else if (index == 6) {
      w = MoldInfoPage();
    }
    Navigator.of(_scaffoldKey.currentContext).push(MaterialPageRoute(
              builder: (BuildContext context) => w));
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