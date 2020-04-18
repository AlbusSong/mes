import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import '../../Others/View/MESSquareItemWidget.dart';

import 'ProjectLotReportPage.dart';
import 'OrderMaterial/ProjectOrderMaterialPage.dart';
import 'ProjectLotSearchPage.dart';
import 'Lock/ProjectLotLockPage.dart';
import 'ProjectLotUnlockPage.dart';
import 'ReturnRepairment/ProjectReturnRepairmentPage.dart';
import 'ProjectChangeGearPage.dart';
import 'Batch/ProjectLotBatchPage.dart';
import 'Repairment/ProjectRepairmentListPage.dart';
import 'Scrap/ProjectScrapPage.dart';
import 'LotLockHandling/ProjectLotLockHandlingPage.dart';

class ProjectPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map> functionItemDataArray = [
    {"title": "工单上料", "icon": "", "badgeValue": 0},
    {"title": "Lot报工", "icon": "", "badgeValue": 0},
    {"title": "Lot查询", "icon": "", "badgeValue": 0},
    {"title": "Lot锁定", "icon": "", "badgeValue": 0},
    {"title": "Lot解锁", "icon": "", "badgeValue": 0},
    {"title": "返修", "icon": "", "badgeValue": 0},
    {"title": "Lot分批", "icon": "", "badgeValue": 0},
    {"title": "档位变更", "icon": "", "badgeValue": 0},
    {"title": "修理", "icon": "", "badgeValue": 0},
    {"title": "报废", "icon": "", "badgeValue": 0},
    {"title": "Lot锁定处理", "icon": "", "badgeValue": 0},
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
      w = ProjectOrderMaterialPage();
    } else if (index == 1) {
      w = ProjectLotReportPage();
    } else if (index == 2) {
      w = ProjectLotSearchPage();
    } else if (index == 3) {
      w = ProjectLotLockPage();
    } else if (index == 4) {
      w = ProjectLotUnlockPage();
    } else if (index == 5) {
      w = ProjectReturnRepairmentPage();
    } else if (index == 6) {
      w = ProjectLotBatchPage();
    } else if (index == 7) {
      w = ProjectChangeGearPage();
    } else if (index == 8) {
      w = ProjectRepairmentListPage();
    } else if (index == 9) {
      w = ProjectScrapPage();
    } else if (index == 10) {
      w = ProjectLotLockHandlingPage();
    }

    if (w != null) {
      Navigator.of(_scaffoldKey.currentContext)
          .push(MaterialPageRoute(builder: (BuildContext context) => w));
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
