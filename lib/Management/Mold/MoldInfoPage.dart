import 'package:flutter/material.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';

class MoldInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoldInfoPageState();  
  }
}

class _MoldInfoPageState extends State<MoldInfoPage> {
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(hintText: "模具编码",);
  String moldCode;
  String content;
  Map responseJson = Map();
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

    for (int i = 0; i < 8; i++) {
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
    for (int i = 0; i < 8; i++) {
      MESSelectionItemWidget w = this.selectionItemList[i];
      String c = "";
      if (i == 0) {
        c = avoidNull(this.responseJson["MouldNo"]);
      } else if (i == 1) {
        c = avoidNull(this.responseJson["MouldName"]);
      } else if (i == 2) {
        c = avoidNull(this.responseJson["MouldStatus"]);
      } else if (i == 3) {
        c = avoidNull(this.responseJson["Location"]);
      } else if (i == 4) {
        c = avoidNull(this.responseJson["EquipName"]);
      } else if (i == 5) {
        String actUseCount = this.responseJson["AlertLife"].toString();
        String alertLife = this.responseJson["AlertLife"].toString();
        String ctrlLife = this.responseJson["CtrlLife"].toString();  
        c = '$actUseCount/$alertLife/$ctrlLife';
      } else if (i == 6) {
        c = avoidNull(this.responseJson["HoldStateDes"]);
      } else if (i == 7) {
        c = avoidNull(this.responseJson["HoldReasonCode"]);
      }
      w.setContent(c);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("模具信息"),
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
      ],
    );
  }

  Widget _buildListView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: this.selectionItemList,
    );
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
      title = "位置";
    } else if (index == 4) {
      enabled = false;
      title = "设备";
    } else if (index == 5) {
      enabled = false;
      title = "冲次信息";
    } else if (index == 6) {
      enabled = false;
      title = "锁定状态";
    } else if (index == 7) {
      enabled = false;
      title = "锁定代码";
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

    String c = await BarcodeScanTool.tryToScanBarcode();
    print("cccc: $c");
    _sBar.setContent(c);
    HudTool.showInfoWithStatus("扫码结果：$c");
    this.moldCode = c;
    _getDataFromServer();
  }
}