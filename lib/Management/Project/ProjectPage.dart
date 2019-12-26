import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import '../../Others/View/MESSquareItemWidget.dart';

import 'ProjectLLotReport.dart';

class ProjectPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map> functionItemDataArray = [
    {"title": "工单上料", "icon": "", "badgeValue": 0},
    {"title": "Lot报工", "icon": "", "badgeValue": 0},
    {"title": "Lot查询", "icon": "", "badgeValue": 0},
    {"title": "Lot锁定", "icon": "", "badgeValue": 0},
    {"title": "Lot解锁", "icon": "", "badgeValue": 0},
    {"title": "报修", "icon": "", "badgeValue": 0},
    {"title": "Lot分批", "icon": "", "badgeValue": 0},
    {"title": "档位变更", "icon": "", "badgeValue": 0},
    {"title": "修理", "icon": "", "badgeValue": 0},
    {"title": "报废", "icon": "", "badgeValue": 0},
  ];

  final List<MESSquareItemWidget> functionItemArray = [];

  @override
  Widget build(BuildContext context) {
    _initSomeThings();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("工程管理"),
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
      
    } else if (index == 1) {
      w = ProjectLLotReport();
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