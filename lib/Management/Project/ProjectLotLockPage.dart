import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import '../../Others/View/MESContentInputWidget.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'Model/ProjectItemModel.dart';
import 'Model/ProjectLockCodeModel.dart';

class ProjectLotLockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectLotLockPageState();
  }
}

class _ProjectLotLockPageState extends State<ProjectLotLockPage> {
  MESSelectionItemWidget _selectionWgt0;
  MESSelectionItemWidget _selectionWgt1;
  MESSelectionItemWidget _selectionWgt2;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "LOT NO或载具ID",
  );
  String remarkContent;
  String lotNo;
  ProjectItemModel detailData = ProjectItemModel.fromJson({});
  List arrOfLockCode;
  ProjectLockCodeModel selectedLockCode;

  @override
  void initState() {
    super.initState();

    _selectionWgt0 = _buildSelectionInputItem(0);
    _selectionWgt1 = _buildSelectionInputItem(1);
    _selectionWgt2 = _buildSelectionInputItem(2);

    _sBar.functionBlock = () {
      print("functionBlock");
      _popSheetAlert();
    };
    _sBar.keyboardReturnBlock = (String c) {
      this.lotNo = c;
      _getDataFromServer();
    };

    _getLockCodeListFromServer();
  }

  void _getDataFromServer() {
    // CAB1912173050FFF
    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/GetLotSearch", parameters: {"lotno":this.lotNo},  shouldCache: true, success: (int code, String message, dynamic responseJson){
      print("LotSubmit/GetLotSearch: $responseJson");
      HudTool.dismiss();
      List extend = jsonDecode(responseJson["Extend"]);
      if (listLength(extend) == 0) {
        return;
      }
      this.detailData = ProjectItemModel.fromJson(extend[0]);
      _selectionWgt0.setContent(this.detailData.LotNo);
      _selectionWgt1.setContent(this.detailData.LOTSize.toString());
    }); 
  }

  void _getLockCodeListFromServer() {
    HttpDigger().postWithUri("LotSubmit/GetLockCode", parameters: {}, shouldCache: true, success: (int code, String message, dynamic responseJson){
      print("LotSubmit/GetLockCode: $responseJson");
      this.arrOfLockCode = (responseJson['Extend'] as List)
          .map((item) => ProjectLockCodeModel.fromJson(item))
          .toList();
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
          child: FlatButton(
            textColor: Colors.white,
            color: hexColor(MAIN_COLOR),
            child: Text("锁定"),
            onPressed: () {
              _btnConfirmClicked();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        _selectionWgt0,
        _selectionWgt1,
        _selectionWgt2,
        _buildContentInputItem(),
        _buildFooter(),
      ],
    );
  }

  Widget _buildSelectionInputItem(int index) {
    String title = "";
    bool enabled = false;
    if (index == 0) {
      title = "LOT NO";
    } else if (index == 1) {
      title = "数量";
    } else if (index == 2) {
      title = "锁定代码";
      enabled = true;
    }
    void Function() selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget wgt = MESSelectionItemWidget(
      title: title,
      enabled: enabled,
    );
    wgt.selectionBlock = selectionBlock;
    return wgt;
  }

  void _hasSelectedItem(int index) {
    print("_hasSelectedItem: $index");

    List<String> arrOfSelectionTitle = [];
    if (index == 0) {

    } else if (index == 1) {
      
    } else if (index == 2) {
      for (ProjectLockCodeModel m in this.arrOfLockCode) {
        arrOfSelectionTitle.add('${m.LockCode}|${m.Description}');
      }
    }

    if (arrOfSelectionTitle.length == 0) {
      return;
    }

    _showPickerWithData(arrOfSelectionTitle, index);

    hideKeyboard(context);
  }

  void _showPickerWithData(List<String> listData, int index) {
    Picker picker = new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: listData),
        changeToFirst: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List indexOfSelectedItems) {
          print(indexOfSelectedItems.first);
          print(picker.getSelectedValues());
          this._handlePickerConfirmation(indexOfSelectedItems.first,
              picker.getSelectedValues().first, index);
        });
    // picker.show(Scaffold.of(context));
    picker.show(_scaffoldKey.currentState);
  }

  void _handlePickerConfirmation(int indexOfSelectedItem, String title, int index) {
    if (index == 0) {

    } else if (index == 1) {
    } else if (index == 2) {
      this.selectedLockCode = this.arrOfLockCode[indexOfSelectedItem];

      _selectionWgt2.setContent(title);      
    }
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

  Widget _buildFooter() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      // color: randomColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "【注意事项】",
            style: TextStyle(fontSize: 18, color: hexColor("666666")),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            // color: randomColor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ">锁定只针对LOT单位锁定",
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
                Text(
                  ">如是LOT部分锁定，请先进行LOT分批后再锁定",
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
                Text(
                  ">未构成LOT的工程检测锁定，不进行管理，通过标识区分",
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _btnConfirmClicked () async {
    if (isAvailable(this.lotNo) == false) {
      HudTool.showInfoWithStatus("请输入/扫码获取Lot NO");
      return;
    }

    if (this.selectedLockCode == null) {
      HudTool.showInfoWithStatus("请选择锁定代码");
      return;
    }

    if (isAvailable(this.remarkContent) == false) {
      HudTool.showInfoWithStatus("请输入备注");
      return;
    }

    bool isOkay = await AlertTool.showStandardAlert(_scaffoldKey.currentContext, "确定锁定?");

    if (isOkay) {
      _confirmAction();
    }    
  }

  void _confirmAction() {
    // LotSubmit/LotLock
    Map mDict = Map();
    mDict["lotno"] = this.detailData.LotNo;
    mDict["holdcode"] = this.selectedLockCode.LockCode;
    mDict["comment"] = this.remarkContent;

    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/LotLock", parameters: mDict, success: (int code, String message, dynamic responseJson){
      print("LotSubmit/LotLock: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.pop(context);
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
                _tryToscan();
              }),
        )),
        height: 120,
      ),
    );
  }

  Future _tryToscan() async {
    print("start scanning");

    try {
      String c = await BarcodeScanner.scan();
      _sBar.setContent(c);
      this.lotNo = c;      
      _getDataFromServer();
    } on Exception catch (e) {
      if (e == BarcodeScanner.CameraAccessDenied) {
        HudTool.showInfoWithStatus("相机权限未开启");
      } else {
        HudTool.showInfoWithStatus("未知错误，请重试");
      }
    } on FormatException {
      HudTool.showInfoWithStatus("一/二维码的值为空，请检查");
    } catch (e) {
      HudTool.showInfoWithStatus("未知错误，请重试");
    }
  }
}
