import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
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
    {"title": "模具入库", "icon": "", "badgeValue": 0, "iconUri": "MuJuRuKu.png"},
    {"title": "模具出库", "icon": "", "badgeValue": 0, "iconUri": "MuJuChuKu.png"},
    {"title": "模具锁定", "icon": "", "badgeValue": 0, "iconUri": "MuJuSuoDing.png"},
    {"title": "模具解锁", "icon": "", "badgeValue": 0, "iconUri": "MuJuJieSuo.png"},
    {"title": "保养申请", "icon": "", "badgeValue": 0, "iconUri": "BaoYangShenQing.png"},
    {"title": "维修申请", "icon": "", "badgeValue": 0, "iconUri": "WeiXiuShenQing.png"},
    {"title": "模具信息", "icon": "", "badgeValue": 0, "iconUri": "MuJuXinXi.png"},
  ];

  final List<MESSquareItemWidget> functionItemArray = [];

  @override
  Widget build(BuildContext context) {
    HudTool.dismiss();
    _initSomeThings();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("模具管理"),
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
          _buildFunctionModuleItem(functionItemData["title"], i, functionItemData["iconUri"]);
      functionItemArray.add(item);
    }
  }

  Widget _buildFunctionModuleItem(String title, int index, String iconUri) {
    void Function(int) onClick = (int v) {
      _functionItemClickedAtIndex(v);
    };
    return MESSquareItemWidget(index, title, 0, iconUri, onClick);
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