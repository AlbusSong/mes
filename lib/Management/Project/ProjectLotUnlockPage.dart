import 'package:flutter/material.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Tool/AlertTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESContentInputWidget.dart';

import 'Model/ProjectLotUnlockItemModel.dart';

import 'package:flutter_picker/flutter_picker.dart';

class ProjectLotUnlockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectLotUnlockPageState();
  }
}

class _ProjectLotUnlockPageState extends State<ProjectLotUnlockPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "LOT NO或载具ID",
  );

  String lotNo = "HSO0042004090007";
  List arrOfData;
  List arrOfSelectedIndex = List();
  String remarkContent;

  @override
  void initState() {
    super.initState();

    _sBar.functionBlock = () {
      print("functionBlock");
      _popSheetAlert();
    };
    _sBar.keyboardReturnBlock = (String c) {
      this.lotNo = c;
      _getDataFromServer();
    };
  }

  void _getDataFromServer() {
    // LotSubmit/GetUnLockLot
    Map mDict = Map();
    if (isAvailable(this.lotNo)) {
      mDict["Lotno"] = this.lotNo;      
    } else {
      return;
    }

    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/GetUnLockLot", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetUnLockLot: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfData = (responseJson["Extend"] as List)
          .map((item) => ProjectLotUnlockItemModel.fromJson(item))
          .toList();
      // this.arrOfSelectedIndex.clear();

      setState(() {        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot解锁"),
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
            child: Text("解锁"),
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
        itemCount: listLength(this.arrOfData) == 0 ? 0 : listLength(this.arrOfData) + 1,
        itemBuilder: (context, index) {
          if (index == listLength(this.arrOfData)) {
            // 如果是最后一项
            return _buildContentInputItem();
          } else {
            return GestureDetector(
              onTap: () => _hasSelectedIndex(index),
              child: _buildListItem(index),
            );
          }
        });
  }

  Widget _buildContentInputItem() {
    void Function(String) contentChangedBlock = (String newContent) {
      // print("contentChangedBlock: $newContent");
      this.remarkContent = newContent;
    };
    return MESContentInputWidget(
      placeholder: "备注",
      contentChangedBlock: contentChangedBlock,
    );
  }

  Widget _buildListItem(int index) {
    ProjectLotUnlockItemModel itemData = this.arrOfData[index];
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
              _checkIfSelected(index) == true
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: _checkIfSelected(index) == true
                  ? hexColor(MAIN_COLOR)
                  : hexColor("dddddd"),
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
    if (this.arrOfSelectedIndex.contains(index)) {
      this.arrOfSelectedIndex.remove(index);
    } else {
      this.arrOfSelectedIndex.add(index);      
    }
    setState(() {      
    });
  }

  void _popSheetAlert() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: ListView(
            children: List.generate(
          2,
          (index) => InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: 60.0,
                  child: Text(bottomFunctionTitleList[index])),
              onTap: () {
                print('tapped item ${index + 1}');
                Navigator.pop(context);
                _tryToScan();
              }),
        )),
        height: 120,
      ),
    );
  }

  Future _btnConfirmClicked() async {
    if (listLength(this.arrOfSelectedIndex) == 0) {
      HudTool.showInfoWithStatus("请选择解锁项");
      return;
    }

    if (isAvailable(this.remarkContent) == false) {
      HudTool.showInfoWithStatus("请填写备注");
      return;
    }

    bool isOkay = await AlertTool.showStandardAlert(_scaffoldKey.currentContext, "确认解锁？");

    if (isOkay) {
      _confirmAction();
    }
  }

  void _confirmAction() {
    Map<String, dynamic> mDict = Map();
    mDict["lotno"] = this.lotNo;
    mDict["comment"] = this.remarkContent;

    print("LotSubmit/LotUnLock mDict: $mDict");

    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/LotUnLock", parameters: mDict,
        success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/LotUnLock: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("解锁成功");
      Navigator.pop(context);
    });
  }

  Future _tryToScan() async {
    print("start scanning");

    String c = await BarcodeScanTool.tryToScanBarcode();
    _sBar.setContent(c);
    this.lotNo = c;
    _getDataFromServer();
  }
}
