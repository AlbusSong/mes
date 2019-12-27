import 'package:flutter/material.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';

import 'package:barcode_scan/barcode_scan.dart';

class ProjectChangeGearPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectChangeGearPageState();
  }
}

class _ProjectChangeGearPageState extends State<ProjectChangeGearPage> {
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "LOT NO或载具ID",
  );
  String lotNo;

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

  void _getDataFromServer() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("档位变更"),
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
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        _buildSelectionInputItem(0),
        _buildSelectionInputItem(1),
        _buildSelectionInputItem(2),
        _buildSelectionInputItem(3),
        _buildSelectionInputItem(4),
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
      title = "物料";
    } else if (index == 2) {
      title = "数量";
    } else if (index == 3) {
      title = "当前档位";
    } else if (index == 4) {
      title = "变更档位";
      enabled = true;
    }
    void Function() selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget wgt = MESSelectionItemWidget(title: title, enabled: enabled,);
    wgt.selectionBlock = selectionBlock;
    return wgt;
  }

  void _hasSelectedItem(int index) {
    print("_hasSelectedItem: $index");
  }

  Widget _buildFooter() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      // color: randomColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("【注意事项】", style: TextStyle(fontSize: 18, color: hexColor("666666")),),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            // color: randomColor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(">只针对整个LOT进行档位变更", style: TextStyle(color: hexColor("333333"), fontSize: 10),),
              Text(">LOT部分变更时，请先进行LOT分批", style: TextStyle(color: hexColor("333333"), fontSize: 10),),
            ],
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
