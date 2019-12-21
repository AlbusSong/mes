import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';

class MoldPage extends StatelessWidget {
  final List<Map> functionItemDataArray = [
    {"title": "模具入库", "icon": "", "badgeValue": 0},
    {"title": "模具出库", "icon": "", "badgeValue": 0},
    {"title": "模具锁定", "icon": "", "badgeValue": 0},
    {"title": "模具解锁", "icon": "", "badgeValue": 0},
    {"title": "保养申请", "icon": "", "badgeValue": 0},
    {"title": "维修申请", "icon": "", "badgeValue": 0},
    {"title": "模具信息", "icon": "", "badgeValue": 0},
  ];

  final List<FunctionModuleItem> functionItemArray = [];

  @override
  Widget build(BuildContext context) {
    _initSomeThings();
    return Scaffold(
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
      FunctionModuleItem item =
          _buildFunctionModuleItem(functionItemData["title"], i);
      functionItemArray.add(item);
    }
  }

  Widget _buildFunctionModuleItem(String title, int index) {
    void Function(int) onClick = (int v) {
      _functionItemClickedAtIndex(v);
    };
    return FunctionModuleItem(index, title, 0, onClick);
  }

  void _functionItemClickedAtIndex(int index) {
    
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


class FunctionModuleItem extends StatefulWidget {
  FunctionModuleItem(
    this.index,
    this.title,
    this.badgeValue,
    this.onClick,
  );

  final int index;
  final String title;
  final int badgeValue;

  //点击回调
  final void Function(int) onClick;

  _FunctionModuleItemState _itemState;

  void updateItem(int newBadgeValue) {
    _itemState.updateItem(newBadgeValue);
  }

  @override
  State<StatefulWidget> createState() {
    _itemState = _FunctionModuleItemState(
        this.index, this.title, this.badgeValue, this.onClick);
    return _itemState;
  }
}

class _FunctionModuleItemState extends State<FunctionModuleItem> {
  _FunctionModuleItemState(
    this.index,
    this.title,
    this.badgeValue,
    this.onClick,
  );

  final int index;
  final String title;
  int badgeValue;

  //点击回调
  final void Function(int) onClick;

  void updateItem(int newBadgeValue) {
    this.badgeValue = newBadgeValue;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(index),
      child: Container(
        // color: hexColor(MAIN_COLOR),
        decoration: BoxDecoration(
          color: hexColor(MAIN_COLOR),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Container(
                  color: randomColor(),
                  height: 45,
                  width: 50,
                  // child: Image(
                  //   height: 50,
                  //   width: 45,
                  //   image: AssetImage("others/images/Home-CompanyLogo.jpeg"),
                  // ),
                )
              ],
            ),
            Positioned(
              right: 4,
              top: 8,
              child: Opacity(
                opacity: this.badgeValue > 0 ? 1 : 0,
                child: Container(
                height: 15,
                constraints: BoxConstraints(minWidth: 15),
                decoration: BoxDecoration(
                  color: hexColor("eb4d3d"),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Center(
                    child:  Text(
                  randomIntWithRange(1, 99).toString(),
                  style: TextStyle(color: Colors.white, fontSize: 9),
                ),
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}