import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import 'Widget/ProjectInfoDisplayWidget.dart';

import 'package:flutter_picker/flutter_picker.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'Model/ProjectLineModel.dart';

class ProjectOrderMaterialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectOrderMaterialPageState();
  }
}

class _ProjectOrderMaterialPageState extends State<ProjectOrderMaterialPage> {
  MESSelectionItemWidget _selectionWgt0;
  MESSelectionItemWidget _selectionWgt1;
  MESSelectionItemWidget _selectionWgt2;

  ProjectInfoDisplayWidget _pInfoDisplayWgt0;
  ProjectInfoDisplayWidget _pInfoDisplayWgt1;
  ProjectInfoDisplayWidget _pInfoDisplayWgt2;

  final List<String> functionTitleList = [
    "上升",
    "下降",
    "删除",
    "追加",
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> bottomFunctionWidgetList = List();
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;
  List arrOfLineItem;
  ProjectLineModel selectedLineItem;

  @override
  void initState() {
    super.initState();

    _selectionWgt0 = _buildSelectionInputItem(0);
    _selectionWgt1 = _buildSelectionInputItem(1);
    _selectionWgt2 = _buildSelectionInputItem(2);

    _pInfoDisplayWgt0 = ProjectInfoDisplayWidget(
      title: "订单号",
    );
    _pInfoDisplayWgt1 = ProjectInfoDisplayWidget(
      title: "物料需求",
    );
    _pInfoDisplayWgt2 = ProjectInfoDisplayWidget(
      title: "已上料",
    );

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

    _getDataFromServer();
  }

  void _getDataFromServer () {
    // 获取所有有效的产线
    HttpDigger().postWithUri("LoadMaterial/AllLine", parameters: {}, shouldCache: true, success: (int code, String message, dynamic responseJson){
      print("LoadMaterial/AllLine: $responseJson");
      this.arrOfLineItem = (responseJson['Extend'] as List)
          .map((item) => ProjectLineModel.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        _selectionWgt0,
        _selectionWgt1,
        _pInfoDisplayWgt0,
        _selectionWgt2,
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _pInfoDisplayWgt1,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: _pInfoDisplayWgt2,
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
      title = "产线";
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
    List<String> arrOfSelectionTitle = [];
    if (index == 0) {
      for (ProjectLineModel m in this.arrOfLineItem) {
        arrOfSelectionTitle.add('${m.LineCode}|${m.LineName}');
      }
    } else if (index == 1) {
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
    picker.show(_scaffoldKey.currentState);
  }

  void _handlePickerConfirmation(int indexOfSelectedItem, String title, int index) {
    if (index == 0) {
      this.selectedLineItem = this.arrOfLineItem[indexOfSelectedItem];
      _selectionWgt0.setContent(title);
    } else if (index == 1) {
    }

    setState(() {});
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
