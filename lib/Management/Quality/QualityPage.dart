import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import '../../Others/View/MESSquareItemWidget.dart';

// import 'SelfTest/QualitySelfTestWorkOrderPage.dart';
import 'SelfTest/QualitySelfTestNewPage.dart';
import 'PatrolTest/QualityPatrolTestWorkOrderPage.dart';
import 'MaterialHoldPage.dart';
import 'MaterialUnholdPage.dart';

class QualityPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map> functionItemDataArray = [
    {"title": "自检工单", "icon": "", "badgeValue": 0, "iconUri": "ZiJianGongDan.png"},
    {"title": "巡检工单", "icon": "", "badgeValue": 0, "iconUri": "XunJianGongDan.png"},
    {"title": "原材料Hold", "icon": "", "badgeValue": 0, "iconUri": "YuanCaiLiaoHold.png"},
    {"title": "解Hold", "icon": "", "badgeValue": 0, "iconUri": "JieHold.png"},
  ];

  final List<MESSquareItemWidget> functionItemArray = [];

  @override
  Widget build(BuildContext context) {
    _initSomeThings();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("品质管理"),
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
      w = QualitySelfTestNewPage();
    } else if (index == 1) {
      w = QualityPatrolTestWorkOrderPage();
    } else if (index == 2) {
      w = MaterialHoldPage();
    } else if (index == 3) {
      w = MaterialUnholdPage();
    }
    if (w != null) {
      Navigator.of(_scaffoldKey.currentContext).push(MaterialPageRoute(
              builder: (BuildContext context) => w));
    }
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