import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import 'Widget/ProjectInfoDisplayWidget.dart';

import 'package:barcode_scan/barcode_scan.dart';

class ProjectOrderMaterialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectOrderMaterialPageState();
  }
}

class _ProjectOrderMaterialPageState extends State<ProjectOrderMaterialPage> {
  final List<String> functionTitleList = [
    "上升",
    "下降",
    "删除",
    "追加",
  ];
  List<Widget> bottomFunctionWidgetList = List();
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();

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
              // _functionItemClickedAtIndex(i);
            },
          ),
        ),
      );
      bottomFunctionWidgetList.add(btn);

      if (i != (functionTitleList.length - 1)) {
        bottomFunctionWidgetList.add(SizedBox(width: 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("工单上料"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: this.bottomFunctionWidgetList,
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
        ProjectInfoDisplayWidget(
          title: "订单号",
        ),
        _buildSelectionInputItem(2),
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: ProjectInfoDisplayWidget(
                  title: "物料需求",
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ProjectInfoDisplayWidget(
                  title: "已上料",
                ),
              ),
            ],
          ),
        ),
        WidgetTool.createListViewLine(15, hexColor("f2f2f7")),
      ],
    );
  }

  Widget _buildSelectionInputItem(int index) {
    String title = "";
    bool enabled = true;
    if (index == 0) {
      title = "作业中心";
    } else if (index == 1) {
      title = "工单";
    } else if (index == 2) {
      title = "追溯物料";
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
