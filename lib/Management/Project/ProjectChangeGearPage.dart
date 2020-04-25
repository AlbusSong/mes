import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';

import 'package:flutter_picker/flutter_picker.dart';

import 'Model/ProjectGradeItemModel.dart';
import 'Model/ProjectItemModel.dart';

import 'package:mes/Others/Page/TakePhotoForOCRPage.dart';

class ProjectChangeGearPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectChangeGearPageState();
  }
}

class _ProjectChangeGearPageState extends State<ProjectChangeGearPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> bottomFunctionTitleList = ["二维码", "OCR"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "LOT NO或载具ID",
  );

  MESSelectionItemWidget _selectionWgt0;
  MESSelectionItemWidget _selectionWgt1;
  MESSelectionItemWidget _selectionWgt2;
  MESSelectionItemWidget _selectionWgt3;
  MESSelectionItemWidget _selectionWgt4;

  String lotNo;
  ProjectItemModel lotDetailData;

  List arrOfGradeItem;
  ProjectGradeItemModel selectedGradeItem;

  @override
  void initState() {
    super.initState();

    _selectionWgt0 = _buildSelectionInputItem(0);
    _selectionWgt1 = _buildSelectionInputItem(1);
    _selectionWgt2 = _buildSelectionInputItem(2);
    _selectionWgt3 = _buildSelectionInputItem(3);
    _selectionWgt4 = _buildSelectionInputItem(4);

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
    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/GetLotSearch",
        parameters: {"lotno": this.lotNo}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetLotSearch: $responseJson");
      HudTool.dismiss();
      List arr = responseJson['Extend'] as List;
      if (listLength(arr) == 0) {
        return;
      }
      this.lotDetailData = ProjectItemModel.fromJson(arr.first);
      _getGradeInfoFromServer(this.lotDetailData.ProdClassCode);

      _selectionWgt0.setContent(this.lotDetailData.LotNo);
      _selectionWgt1.setContent(
          '${this.lotDetailData.ItemCode}|${this.lotDetailData.ItemName}');
      _selectionWgt2.setContent(this.lotDetailData.Qty.toString());
      _selectionWgt3.setContent(this.lotDetailData.Grade);
    });
  }

  void _getGradeInfoFromServer(String prodClass) {
    // 获取档位信息
    HttpDigger().postWithUri("LotSubmit/GetGrade",
        parameters: {"proclass": prodClass}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetGrade: $responseJson");
      this.arrOfGradeItem = (responseJson['Extend2'] as List)
          .map((item) => ProjectGradeItemModel.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        _selectionWgt3,
        _selectionWgt4,
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
    if (index == 4) {
      for (ProjectGradeItemModel m in this.arrOfGradeItem) {
        arrOfSelectionTitle.add('${m.Level}');
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

  void _handlePickerConfirmation(
      int indexOfSelectedItem, String title, int index) {
    if (index == 4) {
      this.selectedGradeItem = this.arrOfGradeItem[indexOfSelectedItem];

      _selectionWgt4.setContent(title);
    }
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
                  ">只针对整个LOT进行档位变更",
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
                Text(
                  ">LOT部分变更时，请先进行LOT分批",
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _btnConfirmClicked() async {
    if (this.lotDetailData == null) {
      HudTool.showInfoWithStatus("请先获取Lot信息");
      return;
    }

    if (this.selectedGradeItem == null) {
      HudTool.showInfoWithStatus("请选择变更档位");
      return;
    }

    bool isOkay =
        await AlertTool.showStandardAlert(_scaffoldKey.currentContext, "确定变更?");

    if (isOkay) {
      _confirmAction();
    }
  }

  void _confirmAction() {
    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/LotGradeChange", parameters: {
      "lotno": this.lotDetailData.LotNo,
      "grade": this.selectedGradeItem.Level,
    }, success: (int code, String message, dynamic responseJson) {
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
                if (index == 0) {
                  _tryToScan();
                } else if (index == 1) {
                  _tryToUseOCR();
                }
              }),
        )),
        height: 120,
      ),
    );
  }

  Future _tryToUseOCR() async {
    print("_tryToUseOCR");
    // TakePhotoForOCRPage 
    var c = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TakePhotoForOCRPage()));
    print("cccccc: $c");
    if (c == null) {
      return;
    }
    this.lotNo = c;
    _sBar.setContent(this.lotNo);
    _getDataFromServer();
  }

  Future _tryToScan() async {
    print("start scanning");

    this.lotNo = await BarcodeScanTool.tryToScanBarcode();
    _sBar.setContent(this.lotNo);
    _getDataFromServer();
  }
}
