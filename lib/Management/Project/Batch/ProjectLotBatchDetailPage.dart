import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import '../../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import '../../../Others/Tool/GlobalTool.dart';
import '../../../Others/Const/Const.dart';
import '../../../Others/View/MESSelectionItemWidget.dart';
import '../Widget/ProjectTextInputWidget.dart';

import '../Model/ProjectItemModel.dart';
import '../Model/ProjectGradeItemModel.dart';

class ProjectLotBatchDetailPage extends StatefulWidget {
  ProjectLotBatchDetailPage(
    this.data,
  );
  final ProjectItemModel data;

  @override
  State<StatefulWidget> createState() {
    return _ProjectLotBatchDetailPageState(data);
  }
}

class _ProjectLotBatchDetailPageState extends State<ProjectLotBatchDetailPage> {
  _ProjectLotBatchDetailPageState(
    this.data,
  );
  final ProjectItemModel data;

  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];

  MESSelectionItemWidget _selectionWgt0;
  MESSelectionItemWidget _selectionWgt1;

  ProjectTextInputWidget _pTextInputWgt0;
  ProjectTextInputWidget _pTextInputWgt1;

  List arrOfGradeItem;
  ProjectGradeItemModel selectedGradeItem;

  String lotNo;

  @override
  void initState() {
    super.initState();

    _selectionWgt0 = _buildSelectionInputItem(0);
    _selectionWgt1 = _buildSelectionInputItem(1);

    _pTextInputWgt0 = _buildTextInputWidgetItem(0);
    _pTextInputWgt1 = _buildTextInputWidgetItem(1);

    _getGradeInfoFromServer(this.data.ProdClassCode);
  }

  void _getGradeInfoFromServer(String prodClass) {
    // 获取档位信息
    HttpDigger().postWithUri("LotSubmit/GetGrade",
        parameters: {"proclass": prodClass}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetGrade: $responseJson");
      this.arrOfGradeItem = (jsonDecode(responseJson['Extend']) as List)
          .map((item) => ProjectGradeItemModel.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot分批-分批"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
    ;
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
        _pTextInputWgt0,
        _pTextInputWgt1,
        _selectionWgt0,
        _selectionWgt1,
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
              " LotNo：${this.data.LotNo}",
              style: TextStyle(fontSize: 16, color: hexColor("999999")),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30),
            height: 30,
            child: Text(
              "载具ID：${this.data.CToolNo}",
              style: TextStyle(fontSize: 16, color: hexColor("999999")),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30),
            height: 30,
            child: Text(
              "    数量：${this.data.Qty}",
              style: TextStyle(fontSize: 16, color: hexColor("999999")),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30),
            height: 30,
            child: Text(
              "    档位：${this.data.Grade}",
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

    String c = await BarcodeScanTool.tryToScanBarcode();
    _pTextInputWgt1.setContent(c);
    this.lotNo = c;
  }
}
