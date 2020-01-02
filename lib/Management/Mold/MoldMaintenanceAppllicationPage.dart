import 'package:flutter/material.dart';
import '../../Others/Tool/AlertTool.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import '../../Others/Network/HttpDigger.dart';
import '../../Others/Tool/HudTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import '../../Others/View/MESContentInputWidget.dart';

class MoldMaintenanceAppllicationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoldMaintenanceAppllicationPageState();  
  }
}

class _MoldMaintenanceAppllicationPageState extends State<MoldMaintenanceAppllicationPage> {
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(hintText: "模具编码",);
  Map responseJson = Map();
  String moldCode;
  String content;
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;

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
      String c = "";
      if (i == 0) {
        c = avoidNull(this.responseJson["MouldNo"]);
      } else if (i == 1) {
        c = avoidNull(this.responseJson["MouldName"]);
      } else if (i == 2) {
        c = avoidNull(this.responseJson["MouldStatus"]);
      } else if (i == 3) {
        c = avoidNull(this.responseJson["HoldStateDes"]);
      } else if (i == 4) {
        String actUseCount = this.responseJson["AlertLife"].toString();
        String alertLife = this.responseJson["AlertLife"].toString();
        String ctrlLife = this.responseJson["CtrlLife"].toString();  
        c = '$actUseCount/$alertLife/$ctrlLife';
      }
      w.setContent(c);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("保养申请"),
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
              child: Text("申请"),
              onPressed: () {
                _btnConfirmClicked();
              },
            ),
          ),
      ],
    );
  }

  Widget _buildListView() {
    List<Widget> children = List();
    for (int i = 0; i < this.selectionItemList.length; i++) {
      children.add(this.selectionItemList[i]);
    }
    children.add(_buildContentInputItem());
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildContentInputItem() {
    void Function (String) contentChangedBlock = (String newContent) {
      // print("contentChangedBlock: $newContent");
      this.content = newContent;
    };
    return MESContentInputWidget(placeholder: "备注", contentChangedBlock: contentChangedBlock,);
  }

  Widget _buildSelectionItem(int index) {
    bool enabled = false;
    String title = "";
    if (index == 0) {
      enabled = false;
      title = "模号";
    } else if (index == 1) {
      enabled = false;
      title = "模具名称";
    } else if (index == 2) {
      enabled = false;
      title = "状态";
    } else if (index == 3) {
      enabled = false;
      title = "锁定状态";
    } else if (index == 4) {
      enabled = false;
      title = "冲次信息";
    }

    void Function () selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget item = MESSelectionItemWidget(enabled: enabled, title: title, selected: false, selectionBlock: selectionBlock,);
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
    if (isAvailable(this.moldCode) == false || this.responseJson.isNotEmpty == false) {
      HudTool.showInfoWithStatus("请先获取模具信息");
      return;
    } 

    if (isAvailable(this.content) == false) {
      HudTool.showInfoWithStatus("请填写备注");
      return;
    }

    bool isOkay = await AlertTool.showStandardAlert(context, "确定申请?");

    if (isOkay) {
      _realConfirmationAction();
    }
  }

  void _realConfirmationAction() {
    HudTool.show();
    HttpDigger().postWithUri("Mould/ApplyPM", parameters: {"mouldCode":this.moldCode, "remark":this.content}, success: (int code, String message, dynamic responseJson) {
      print("Mould/ApplyPM: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus(message);
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

    this.moldCode = await BarcodeScanTool.tryToScanBarcode();
    _getDataFromServer();
  }
}