import 'package:flutter/material.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Tool/AlertTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import '../../Others/View/MESConntenInputWidget.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'Model/MoldInModel.dart';

class MoldInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoldInPageState();
  }
}

class _MoldInPageState extends State<MoldInPage> {
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "模具编码",
  );
  String moldCode;
  String content;
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;
  Map responseJson = Map();
  MoldInModel detailData = MoldInModel.fromJson({});

  @override
  void initState() {
    super.initState();

    _sBar.functionBlock = () {
      print("functionBlock");
      _popSheetAlert();
    };
    _sBar.keyboardReturnBlock = (String c) {
      this.moldCode = c;
      _getDataFromServer();
    };

    for (int i = 0; i < 5; i++) {
      this.selectionItemList.add(_buildSelectionItem(i));
    }
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

  void _getDataFromServer() {
    HudTool.show();
    HttpDigger().postWithUri("Mould/LoadMould",
        parameters: {"mouldCode": this.moldCode},
        success: (int code, String message, dynamic responseJson) {
      print("Mould/LoadMould: $responseJson");
      HudTool.dismiss();
      this.responseJson = responseJson;
      _reloadListView();
    });
  }

  void _reloadListView() {
    for (int i = 0; i < 5; i++) {
      MESSelectionItemWidget w = this.selectionItemList[i];
      String content = "";
      if (i == 0) {
        content = avoidNull(this.responseJson["MouldNo"]);
      } else if (i == 1) {
        content = avoidNull(this.responseJson["MouldName"]);
      } else if (i == 2) {
        content = avoidNull(this.responseJson["MouldStatus"]);
      } else if (i == 3) {
        content = avoidNull(this.responseJson["HoldStateDes"]);
      } else if (i == 4) {
        content = avoidNull(this.responseJson["StorageStateDes"]);
      }
      w.setContent(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("模具入库"),
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
            child: Text("入库"),
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
      children: this.selectionItemList,
    );
  }

  Widget _buildContentInputItem() {
    void Function(String) contentChangedBlock = (String newContent) {
      // print("contentChangedBlock: $newContent");
      this.content = newContent;
    };
    return MESConntenInputWidget(
      placeholder: "备注",
      contentChangedBlock: contentChangedBlock,
    );
  }

  Widget _buildSelectionItem(int index) {
    bool enabled = false;
    String title = "";
    String content = "";
    if (index == 0) {
      enabled = false;
      title = "模号";
      content = avoidNull(this.responseJson["MouldNo"]);
    } else if (index == 1) {
      enabled = false;
      title = "模具名称";
      content = avoidNull(this.responseJson["MouldName"]);
    } else if (index == 2) {
      enabled = false;
      title = "状态";
      content = avoidNull(this.responseJson["MouldStatus"]);
    } else if (index == 3) {
      enabled = false;
      title = "锁定状态";
      content = avoidNull(this.responseJson["HoldStateDes"]);
    } else if (index == 4) {
      enabled = false;
      title = "出入库状态";
      content = avoidNull(this.responseJson["StorageStateDes"]);
    }

    void Function() selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget item = MESSelectionItemWidget(
      enabled: enabled,
      title: title,
      content: content,
      selected: false,
      selectionBlock: selectionBlock,
    );
    return item;
  }

  void _hasSelectedItem(int index) {
    print("_hasSelectedItem: $index");
    this.selectedIndex = index;
    for (int i = 0; i < this.selectionItemList.length; i++) {
      MESSelectionItemWidget wgt = this.selectionItemList[index];
      wgt.setSelected((this.selectedIndex == i));
    }
  }

  Future _btnConfirmClicked() async {
    bool isOkay = await AlertTool.showStandardAlert(context, "确定入库?");

    if (isOkay) {
      _realConfirmationAction();
    }
  }

  void _realConfirmationAction() {
    HudTool.show();
    HttpDigger().postWithUri("Mould/InStock", parameters: {"mouldCode":"D0D201910250001"}, success: (int code, String message, dynamic responseJson) {
      print("Mould/InStock: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus(message);
      Navigator.pop(context);
    });
  }

  Future _tryToscan() async {
    print("start scanning");

    try {
      this.moldCode = await BarcodeScanner.scan();
      _getDataFromServer();
    } on Exception catch (e) {
      if (e == BarcodeScanner.CameraAccessDenied) {
        HudTool.showInfoWithStatus("相机权限未开启");
      } else {
        HudTool.showInfoWithStatus("未知错误");
      }
    } on FormatException {
      HudTool.showInfoWithStatus("一/二维码的值为空，请检查");
    } catch (e) {
      HudTool.showInfoWithStatus("未知错误");
    }
  }
}