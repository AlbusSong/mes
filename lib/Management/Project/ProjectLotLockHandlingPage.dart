import 'package:flutter/material.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import 'package:mes/Others/View/SearchBar.dart';

import './Model/ProjectLotLockItemModel.dart';

class ProjectLotLockHandlingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectLotLockHandlingPageState();
  }
}

class _ProjectLotLockHandlingPageState
    extends State<ProjectLotLockHandlingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SearchBar _sBar = SearchBar(
    hintText: "产线代码",
  );

  List<Widget> bottomFunctionWidgetList = List();
  final List<String> functionTitleList = [
    "解锁",
    "返修",
    "报废",
  ];

  String lotNo;
  List arrOfData;
  List arrOfSelectedIndex = List();

  @override
  void initState() {
    super.initState();

    _sBar.keyboardReturnBlock = (String c) {
      _getDataFromServer();
    };

    for (int i = 0; i < functionTitleList.length; i++) {
      String functionTitle = functionTitleList[i];
      Widget btn = Expanded(
        child: Container(
          height: 50,
          color: hexColor(MAIN_COLOR),
          child: FlatButton(
            padding: EdgeInsets.all(0),
            textColor: Colors.white,
            color: hexColor(MAIN_COLOR),
            child: Text(functionTitle),
            onPressed: () {
              print(functionTitle);
              _functionItemClickedAtIndex(i);
            },
          ),
        ),
      );
      bottomFunctionWidgetList.add(btn);

      if (i != (functionTitleList.length - 1)) {
        bottomFunctionWidgetList.add(SizedBox(width: 1));
      }
    }

    _getDataFromServer();
  }

  void _getDataFromServer() {
    // LotSubmit/GetLotLockList
    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/GetLotLockList", parameters: {"lotno": avoidNull(this.lotNo)}, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetLotLockList: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfSelectedIndex.clear();
      this.arrOfData = (responseJson["Extend"] as List)
          .map((item) => ProjectLotLockItemModel.fromJson(item))
          .toList();
      setState(() { });
    });
  }    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot锁定"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _sBar,
        Expanded(
          child: Container(
            color: hexColor("f2f2f7"),
            child: _buildListView(),
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          // color: randomColor(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: this.bottomFunctionWidgetList,
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        itemCount: listLength(this.arrOfData),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _hasSelectedIndex(index),
            child: _buildListItem(index),
          );
        });
  }

  Widget _buildListItem(int index) {
    ProjectLotLockItemModel itemData = this.arrOfData[index];
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    height: 25,
                    color: Colors.white,
                    child: Text(
                      "LotNo：${itemData.LotNo}",
                      maxLines: 2,
                      style: TextStyle(
                          color: hexColor(MAIN_COLOR_BLACK),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("物料ID：${itemData.ItemCode}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("物料名称：${itemData.ItemName}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                  margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("数量：${itemData.Qty}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                        Text("代码：${itemData.HoldCode}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),             
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("是否锁定：${itemData.Hold}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                        Text("状态：${itemData.StatusDesc}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("备注：${itemData.Comment}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    color: hexColor("dddddd"),
                    height: 1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
            margin: EdgeInsets.only(right: 8),
            color: Colors.white,
            child: Icon(
              _checkIfSelected(index) == true ? Icons.check_box : Icons.check_box_outline_blank,
              color: _checkIfSelected(index) == true ? hexColor(MAIN_COLOR) : hexColor("dddddd"),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  bool _checkIfSelected(int index) {
    return this.arrOfSelectedIndex.contains(index);
  }

  void _hasSelectedIndex(int index) {
    if (this.arrOfSelectedIndex.contains(index) == true) {
      this.arrOfSelectedIndex.remove(index);
    } else {
      this.arrOfSelectedIndex.add(index);
    }

    setState(() {
    });
  }

  Future _functionItemClickedAtIndex(int index) async {
    if (listLength(this.arrOfSelectedIndex) == 0) {
      HudTool.showInfoWithStatus("请至少选择一项");
      return;
    }

    Map resultDict = await AlertTool.showInputFeildAlert(_scaffoldKey.currentContext, "确定提交?", placeholder: "请输入备注信息");

    if (resultDict["confirmation"] == true) {
      _confirmActionWithComment(index, resultDict["text"]);
    }
  }

  void _confirmActionWithComment(int index, String comment) {
    Map mDict = Map();

    String lotNoString = "";
    for (int i = 0; i < listLength(this.arrOfSelectedIndex); i++) {
      int idx = this.arrOfSelectedIndex[i];
      ProjectLotLockItemModel lockItemData = this.arrOfData[idx];
      if (i == (listLength(this.arrOfSelectedIndex) - 1)) {
        // if last element
        lotNoString += lockItemData.LotNo;
      } else {
        lotNoString += (lockItemData.LotNo + "|");
      }
    }
    mDict["lotno"] = lotNoString;
    mDict["comment"] = avoidNull(comment);

    String uri = "";    
    if (index == 0) {
      // 解锁 LotSubmit/LotUnLock
      uri = "LotSubmit/LotUnLock";
    } else if (index == 1) {

    } else if (index == 2) {

    }

    print("$uri: $mDict");

    HudTool.show();
    HttpDigger().postWithUri(uri, parameters: mDict, success: (int code, String message, dynamic responseJson) {
      print("$uri: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.of(context).pop();
    });
  }
}
