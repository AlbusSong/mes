import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import '../../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import '../../../Others/Tool/GlobalTool.dart';
import '../../../Others/Const/Const.dart';
import '../../../Others/View/SearchBarWithFunction.dart';
import '../../../Others/View/MESSelectionItemWidget.dart';
import '../../../Others/View/MESContentInputWidget.dart';

import 'package:flutter_picker/flutter_picker.dart';

import '../Model/ProjectItemModel.dart';
import '../Model/ProjectLockCodeModel.dart';
import '../Model/ProjectLineModel.dart';
import '../Model/ProjectPushPersonItemModel.dart';

import 'ProjectLockProductionLinePage.dart';
import 'ProjectLockPushPersonPage.dart';

import 'package:mes/Others/Page/TakePhotoForOCRPage.dart';

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
  MESContentInputWidget _contentInputWgt;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> bottomFunctionTitleList = ["二维码", "OCR"];
  final SearchBarWithFunction _sBar = SearchBarWithFunction(
    hintText: "LOT NO或载具ID",
  );
  String remarkContent;
  String lotNo;
  ProjectItemModel detailData = ProjectItemModel.fromJson({});
  List arrOfLockCode;
  ProjectLockCodeModel selectedLockCode;
  List arrOfProductionLine;
  List arrOfPushPerson;

  @override
  void initState() {
    super.initState();

    _selectionWgt0 = _buildSelectionInputItem(0);
    _selectionWgt1 = _buildSelectionInputItem(1);
    _selectionWgt2 = _buildSelectionInputItem(2);
    _contentInputWgt = _buildContentInputItem();

    _sBar.functionBlock = () {
      print("functionBlock");
      _popSheetAlert();
    };
    _sBar.keyboardReturnBlock = (String c) {
      this.lotNo = c;
      _getDataFromServer();
    };

    _getLockCodeListFromServer();
    _getProductionLineListFromServer();
  }

  void _getDataFromServer() {
    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/GetLotSearch",
        parameters: {"lotno": this.lotNo}, shouldCache: false,
        success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetLotSearch: $responseJson");
      HudTool.dismiss();
      List extend = responseJson["Extend"];
      if (listLength(extend) == 0) {
        return;
      }
      this.detailData = ProjectItemModel.fromJson(extend[0]);
      _selectionWgt0.setContent(this.detailData.LotNo);
      _selectionWgt1.setContent(this.detailData.Qty.toString());
    });
  }

  void _getLockCodeListFromServer() {
    HudTool.show();
    HttpDigger()
        .postWithUri("LotSubmit/GetLockCode", parameters: {}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetLockCode: $responseJson");
      HudTool.dismiss();
      this.arrOfLockCode = (responseJson['Extend'] as List)
          .map((item) => ProjectLockCodeModel.fromJson(item))
          .toList();
    });
  }

  void _getProductionLineListFromServer() {
    // LotSubmit/AllLine
    HttpDigger()
        .postWithUri("LotSubmit/AllLine", parameters: {}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/AllLine: $responseJson");
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
        _contentInputWgt,
        WidgetTool.createListViewLine(20, hexColor("f1f1f7")),
        _buildPushSectionHeader(),
        _buildPushSectionCell(0),
        WidgetTool.createListViewLine(1, hexColor("f1f1f7")),
        _buildPushSectionCell(1),
        _buildFooter(),
      ],
    );
  }

  Widget _buildPushSectionHeader() {
    if (this.selectedLockCode == null ||
        this.selectedLockCode.LockCode != "TL") {
      // 如果锁定代码不是“退料”的话
      return Container(
        height: 1,
      );
    }

    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Text(
        "推送设置",
        style: TextStyle(
            fontSize: 20,
            color: hexColor("333333"),
            fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _buildPushSectionCell(int index) {
    if (this.selectedLockCode == null ||
        this.selectedLockCode.LockCode != "TL") {
      // 如果锁定代码不是“退料”的话
      return Container(
        height: 1,
      );
    }

    return GestureDetector(
      child: Container(
        // height: 50,
        constraints: BoxConstraints(minHeight: 50),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                _fillContentForPushSectionCell(index),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: hexColor("999999"),
              size: 16,
            ),
          ],
        ),
      ),
      onTap: () {
        _hasClickedPushSectionCell(index);
      },
    );
  }

  String _fillContentForPushSectionCell(int index) {
    String result = "选择";

    if (index == 0) {
      result += "产线:    ";

      for (int i = 0; i < listLength(this.arrOfProductionLine); i++) {
        ProjectLineModel itemData = this.arrOfProductionLine[i];
        result += "${itemData.LineName} ";
      }
    } else if (index == 1) {
      result += "推送人:    ";
      for (int i = 0; i < listLength(this.arrOfPushPerson); i++) {
        ProjectPushPersonItemModel itemData = this.arrOfPushPerson[i];
        result += "${itemData.Comment} ";
      }
    }

    return result;
  }

  Future _hasClickedPushSectionCell(int index) async {
    print("_hasClickedPushSectionCell: $index");

    Widget w;
    if (index == 0) {
      w = ProjectLockProductionLinePage();
    } else if (index == 1) {
      if (listLength(this.arrOfProductionLine) == 0) {
        HudTool.showInfoWithStatus("请先选择产线");
        return;
      }

      List lineList = List();
      for (ProjectLineModel itemData in this.arrOfProductionLine) {
        lineList.add(itemData.LineCode);
      }

      w = ProjectLockPushPersonPage(lineList);
    }

    if (w == null) {
      return;
    }

    if (index == 0) {
      this.arrOfProductionLine = await Navigator.of(_scaffoldKey.currentContext)
          .push(MaterialPageRoute(builder: (BuildContext context) => w));
    } else {
      this.arrOfPushPerson = await Navigator.of(_scaffoldKey.currentContext)
          .push(MaterialPageRoute(builder: (BuildContext context) => w));
    }

    setState(() {});
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
        cancelText: "取消",
        confirmText: "确定",
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
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
      this.selectedLockCode = this.arrOfLockCode[indexOfSelectedItem];

      _selectionWgt2.setContent(title);
    } else if (index == 3) {
    } else if (index == 4) {}
    setState(() {});
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

  Future _btnConfirmClicked() async {
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

    // if (listLength(this.arrOfProductionLine) == 0) {
    //   HudTool.showInfoWithStatus("请选择产线");
    //   return;
    // }

    if (this.selectedLockCode != null &&
        this.selectedLockCode.LockCode == "TL") {
      // 如果是“退料”的话
      if (listLength(this.arrOfPushPerson) == 0) {
        HudTool.showInfoWithStatus("请选择推送人");
        return;
      }
    }

    bool isOkay =
        await AlertTool.showStandardAlert(_scaffoldKey.currentContext, "确定锁定?");

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

    List arrOfPushPersonId = List();
    if (listLength(this.arrOfPushPerson) > 0) {
      for (ProjectPushPersonItemModel m in this.arrOfPushPerson) {
        arrOfPushPersonId.add(m.UserID);
      }
    }
    mDict["personList"] = arrOfPushPersonId;

    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/LotLock", parameters: mDict,
        success: (int code, String message, dynamic responseJson) {
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
    var c = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => TakePhotoForOCRPage()));
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

    String c = await BarcodeScanTool.tryToScanBarcode();
    _sBar.setContent(c);
    this.lotNo = c;
    _getDataFromServer();
  }
}
