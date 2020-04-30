import 'package:flutter/material.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/View/SearchBar.dart';

import '../Model/ProjectTagInfoModel.dart';
import '../Model/ProjectMaterialItemModel.dart';

class ProjectAddMaterialTagPage extends StatefulWidget {
  ProjectAddMaterialTagPage(
    this.materialInfo,
    this.wono,
  );

  final ProjectMaterialItemModel materialInfo;
  final String wono;

  @override
  State<StatefulWidget> createState() {
    return _ProjectAddMaterialTagPageState(materialInfo, wono);
  }
}

class _ProjectAddMaterialTagPageState extends State<ProjectAddMaterialTagPage> {
  _ProjectAddMaterialTagPageState(
    this.materialInfo,
    this.wono,
  );

  final ProjectMaterialItemModel materialInfo;
  final String wono;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SearchBar _sBar = SearchBar(
    hintText: "LOT NO或载具ID",
  );
  List arrOfData;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    _sBar.keyboardReturnBlock = (String c) {
      _getDataFromServer();
    };

    _sBar.setContent(
        '${this.materialInfo.ItemType}|${this.materialInfo.ItemCode}|${this.materialInfo.ItemName}');

    _getDataFromServer();
  }

  void _getDataFromServer() {
    if (isAvailable(this.materialInfo.ItemCode) == false) {
      return;
    }
    // 获取所有有效的产线
    HudTool.show();
    HttpDigger().postWithUri("LoadMaterial/GetTagInfo",
        parameters: {"item": this.materialInfo.ItemCode}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LoadMaterial/GetTagInfo: $responseJson");
      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => ProjectTagInfoModel.fromJson(item))
          .toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("选择物料"),
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
          child: FlatButton(
            textColor: Colors.white,
            color: hexColor(MAIN_COLOR),
            child: Text("添加"),
            onPressed: () {
              _btnConfirmClicked();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        itemCount: listLength(this.arrOfData),
        // itemCount: 10,
        itemBuilder: (context, index) {
          // In our case, a DogCard for each doggo.
          return GestureDetector(
            onTap: () => _hasSelectedIndex(index),
            child: _buildListItem(index),
          );
        });
  }

  Widget _buildListItem(int index) {
    ProjectTagInfoModel itemData = this.arrOfData[index];
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
                      "标签：${itemData.TagID}",
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
                        Text("物料批次：${itemData.ProductionBatch}",
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
                      children: <Widget>[
                        Text("数量：${itemData.Qty}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
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
                        Text("订单号：${itemData.OrderNo}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                        Text("单位：${itemData.Unit}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
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
          Opacity(
            opacity: (this.selectedIndex == index) ? 1.0 : 0.0,
            child: Container(
              margin: EdgeInsets.only(right: 8),
              color: Colors.white,
              child: Icon(
                Icons.check,
                color: hexColor(MAIN_COLOR),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _hasSelectedIndex(int index) {
    this.selectedIndex = index;
    setState(() {});
  }

  Future _btnConfirmClicked() async {
    if (this.selectedIndex < 0) {
      HudTool.showInfoWithStatus("请选择一项");
      return;
    }

    bool isOkay =
        await AlertTool.showStandardAlert(_scaffoldKey.currentContext, "确定添加?");

    if (isOkay) {
      _confirmAction();
    }
  }

  void _confirmAction() {
    ProjectTagInfoModel tagInfo = this.arrOfData[this.selectedIndex];
    HudTool.show();
    HttpDigger().postWithUri("LoadMaterial/BarcodeScan", parameters: {
      "wono": this.wono,
      "item": this.materialInfo.ItemCode,
      "tag": tagInfo.TagID
    }, success: (int code, String message, dynamic responseJson) {
      print("LoadMaterial/BarcodeScan: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.of(context).pop(true);
    });
  }
}
