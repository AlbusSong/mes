import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import 'Widget/ProjectTextInputWidget.dart';

import 'package:barcode_scan/barcode_scan.dart';

class ProjectLotBatchDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectLotBatchDetailPageState();
  }  
}

class _ProjectLotBatchDetailPageState extends State<ProjectLotBatchDetailPage> {
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot分批-分批"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );;
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
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
              child: Text("确认"),
              onPressed: () {
                // _btnConfirmClicked();
              },
            ),
          ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView(
      children: <Widget>[
        WidgetTool.createListViewLine(10, hexColor("f2f2f7")),
        _buildInfoCell(),
        WidgetTool.createListViewLine(10, hexColor("f2f2f7")),
        _buildTextInputWidgetItem(0),
        _buildTextInputWidgetItem(1),
        _buildSelectionInputItem(0),
        _buildSelectionInputItem(1),
      ],
    );
  }

  Widget _buildTextInputWidgetItem(int index) {
    String title = "";
    String placeholder = "";
    bool canScan = true;
    if (index == 0) {
      title = "分批数量";
      placeholder = "请输入数字(只能输入数字)";
      canScan = false;      
    } else if (index == 1) {      
      title = "LotNo/模具ID";
      placeholder = "扫描/输入";
    }
    ProjectTextInputWidget wgt = ProjectTextInputWidget(
      title: title,
      placeholder: placeholder,
      canScan: canScan,
    );

    wgt.functionBlock = () {
      hideKeyboard(context);
      _popSheetAlert();
    };
    wgt.contentChangeBlock = (String newContent) {
      print("contentChangeBlock: $newContent");
    };

    return wgt;
  }

  Widget _buildSelectionInputItem(int index) {
    String title = "";
    bool enabled = false;
    if (index == 0) {
      title = "当前数量";
    } else if (index == 1) {
      title = "档位";
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
  }

  Widget _buildInfoCell() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30),
            height: 30,
            child: Text(
              " LotNo：HSOB19",
              style: TextStyle(fontSize: 16, color: hexColor("999999")),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30),
            height: 30,
            child: Text(
              "载具ID：CAB191217303asdjf",
              style: TextStyle(fontSize: 16, color: hexColor("999999")),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30),
            height: 30,
            child: Text(
              "    数量：35",
              style: TextStyle(fontSize: 16, color: hexColor("999999")),
            ),            
          ),
          Container(
            padding: EdgeInsets.only(left: 30),
            height: 30,
            child: Text(
              "    档位：ASAA",
              style: TextStyle(fontSize: 16, color: hexColor("999999")),
            ),
          ),
        ],
      ),
    );
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
      print("c: $c");
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