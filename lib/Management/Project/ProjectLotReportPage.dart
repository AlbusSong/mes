import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/BarcodeScanTool.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Tool/AlertTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/MESSelectionItemWidget.dart';
import 'Widget/ProjectTextInputWidget.dart';
import 'Widget/ProjectInfoDisplayWidget.dart';

import 'package:flutter_picker/flutter_picker.dart';

import 'Model/ProjectLineModel.dart';
import 'Model/ProjectWorkOrderModel.dart';
import 'Model/ProjectRealGradeItemModel.dart';
import 'Model/ProjectQingxixianInfoModel.dart';

import 'package:mes/Others/Page/TakePhotoForOCRPage.dart';

class ProjectLotReportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectLotReportPageState();
  }
}

class _ProjectLotReportPageState extends State<ProjectLotReportPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MESSelectionItemWidget _selectionWgt0;
  MESSelectionItemWidget _selectionWgt1;
  MESSelectionItemWidget _selectionWgt2;

  ProjectInfoDisplayWidget _pInfoDisplayWgt0;
  ProjectInfoDisplayWidget _pInfoDisplayWgt1;
  ProjectInfoDisplayWidget _pInfoDisplayWgt2;
  ProjectInfoDisplayWidget _pInfoDisplayWgt3;

  ProjectTextInputWidget _pTextInputWgt0;
  ProjectTextInputWidget _pTextInputWgt1;

  final List<String> bottomFunctionTitleList = ["二维码", "OCR"];
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;
  String lotNo;
  String lotAmount;
  List arrOfProductLine;
  ProjectLineModel selectedProductLine = ProjectLineModel.fromJson({});
  List arrOfPlanInfo;
  ProjectWorkOrderModel selectedPlanInfo = ProjectWorkOrderModel.fromJson({});
  List arrofGradeInfo;
  ProjectRealGradeItemModel selectedGradeInfo;
  ProjectQingxixianInfoModel qingxixianInfo;

  @override
  void initState() {
    super.initState();

    _selectionWgt0 = _buildSelectionInputItem(0);
    _selectionWgt1 = _buildSelectionInputItem(1);
    _selectionWgt2 = _buildSelectionInputItem(2);

    _pInfoDisplayWgt0 = ProjectInfoDisplayWidget(
      title: "工程",
    );
    _pInfoDisplayWgt1 = ProjectInfoDisplayWidget(
      title: "机型",
    );
    _pInfoDisplayWgt2 = ProjectInfoDisplayWidget(
      title: "工单数量",
    );
    _pInfoDisplayWgt3 = ProjectInfoDisplayWidget(
      title: "已报工数量",
    );

    _pTextInputWgt0 = _buildTextInputWidgetItem(0);
    _pTextInputWgt1 = _buildTextInputWidgetItem(1);

    _getDataFromServer();
  }

  void _getDataFromServer() {
    // LoadMaterial/AllLine 获取所有的产线
    HttpDigger()
        .postWithUri("LoadMaterial/AllLine", parameters: {}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("LoadMaterial/AllLine: $responseJson");
      ;
      this.arrOfProductLine = (responseJson["Extend"] as List)
          .map((item) => ProjectLineModel.fromJson(item))
          .toList();
      if (listLength(this.arrOfProductLine) > 0) {
        ProjectLineModel firstWorkData = this.arrOfProductLine.first;
        _getPlanListFromServer(firstWorkData.LineCode);
      }
    });
  }

  void _getPlanListFromServer(String workLine, {shouldShowHud = true}) {
    // 获取计划信息清单
    print("workLine: $workLine");
    if (shouldShowHud == true) {
      HudTool.show();
    }
    HttpDigger().postWithUri("LotSubmit/PlanInfo",
        parameters: {"line": workLine}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/PlanInfo: $responseJson");
      if (shouldShowHud == true) {
        HudTool.dismiss();
      }
      this.arrOfPlanInfo = (responseJson["Extend"] as List)
          .map((item) => ProjectWorkOrderModel.fromJson(item))
          .toList();
    });
  }

  void _getGradeInfoFromServer(String prodClass) {
    // 获取档位信息
    HttpDigger().postWithUri("LotSubmit/GetGrade",
        parameters: {"proclass": prodClass}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/GetGrade: $responseJson");

      this.arrofGradeInfo = (responseJson["Extend2"] as List)
          .map((item) => ProjectRealGradeItemModel.fromJson(item))
          .toList();
      if (listLength(this.arrofGradeInfo) > 0) {
        this.selectedGradeInfo = this.arrofGradeInfo.first;
        _selectionWgt2.setContent(this.selectedGradeInfo.Level);
      }
    });
  }

  void _getQingxixianInfoFromServer() {
    // LotSubmit/UnplanInfo
    Map mDict = Map();
    mDict["lotNo"] = this.lotNo;
    mDict["nPagesize"] = 10;
    mDict["nPageindex"] = 0;

    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/UnplanInfo", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/UnplanInfo: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      List arr = (responseJson["Extend"] as List)
          .map((item) => ProjectQingxixianInfoModel.fromJson(item))
          .toList();
      if (listLength(arr) == 0) {
        return;
      }
      this.qingxixianInfo = arr.first;

      this.lotAmount = "1";

      _pInfoDisplayWgt0.setContent(this.qingxixianInfo.ProcessName);
      _pInfoDisplayWgt1.setContent(this.qingxixianInfo.ItemCode);
      _pTextInputWgt1.setContent(this.lotAmount);
      _selectionWgt2.setContent(this.qingxixianInfo.Grade);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot报工"),
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
        Offstage(
          offstage: _isQingXiXian(),
          child: _selectionWgt1,
        ),
        _pInfoDisplayWgt0,
        _pInfoDisplayWgt1,
        Offstage(
          offstage: _isQingXiXian(),
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: _pInfoDisplayWgt2,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _pInfoDisplayWgt3,
                ),
              ],
            ),
          ),
        ),
        WidgetTool.createListViewLine(15, hexColor("f2f2f7")),
        _pTextInputWgt0,
        _pTextInputWgt1,
        _selectionWgt2,
      ],
    );
  }

  Widget _buildTextInputWidgetItem(int index) {
    String title = "";
    String placeholder = "";
    bool canScan = true;
    bool enabled = true;
    TextInputType keyboardType = TextInputType.text;
    if (index == 0) {
      title = "LotNo/载具ID";
      placeholder = "扫描/输入";
    } else if (index == 1) {
      title = "数量";
      placeholder = "请输入数字";
      canScan = false;
      keyboardType = TextInputType.number;

      if (_isQingXiXian()) {
        enabled = false;
      }
    }
    ProjectTextInputWidget wgt = ProjectTextInputWidget(
      title: title,
      placeholder: placeholder,
      canScan: canScan,
      keyboardType: keyboardType,
      enabled: enabled,
    );

    wgt.functionBlock = () {
      hideKeyboard(context);
      _popSheetAlert();
    };
    wgt.keyboardReturnBlock = (String content) {
      if (index == 0 && _isQingXiXian()) {
        _getQingxixianInfoFromServer();
      }
    };
    wgt.contentChangeBlock = (String newContent) {
      print("contentChangeBlock: $newContent");
      if (index == 0) {
        this.lotNo = newContent;
      } else if (index == 1) {
        this.lotAmount = newContent;
      }
    };

    return wgt;
  }

  Widget _buildSelectionInputItem(int index) {
    String title = "";
    bool enabled = true;
    String c = "-";
    if (index == 0) {
      title = "产线";
    } else if (index == 1) {
      title = "工单";
    } else if (index == 2) {
      title = "档位";
      enabled = true;
    }
    void Function() selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget wgt = MESSelectionItemWidget(
      title: title,
      enabled: enabled,
      content: c,
    );
    wgt.selectionBlock = selectionBlock;
    return wgt;
  }

  void _hasSelectedItem(int index) {
    print("_hasSelectedItem: $index");
    List<String> arrOfSelectionTitle = [];
    if (index == 0) {
      for (ProjectLineModel m in this.arrOfProductLine) {
        arrOfSelectionTitle.add('${m.LineCode}|${m.LineName}');
      }
    } else if (index == 1) {
      for (ProjectWorkOrderModel m in this.arrOfPlanInfo) {
        arrOfSelectionTitle.add('${m.Wono}|${m.StateDesc}');
      }
    } else if (index == 2) {
      if (_isQingXiXian()) {
        HudTool.showInfoWithStatus("清洗线不可手动选择档位");
        return;
      }
      for (ProjectRealGradeItemModel m in this.arrofGradeInfo) {
        arrOfSelectionTitle.add('${m.Level}');
      }
    }

    if (arrOfSelectionTitle.length == 0) {
      return;
    }

    _showPickerWithData(arrOfSelectionTitle, index);

    hideKeyboard(context);
  }

  bool _isQingXiXian() {
    bool result = false;
    if (this.selectedProductLine != null) {
      if (this.selectedProductLine.LineCode == "QXX") {
        result = true;
      }
    }
    return result;
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
    if (index == 0) {
      this.selectedProductLine = this.arrOfProductLine[indexOfSelectedItem];
      print("this.selectedWork.LineCode: ${this.selectedProductLine.LineCode}");
      _getPlanListFromServer(this.selectedProductLine.LineCode);
      _selectionWgt0.setContent(title);
      if (_isQingXiXian()) {
        _pTextInputWgt1 = _buildTextInputWidgetItem(1);
      }
    } else if (index == 1) {
      this.selectedPlanInfo = this.arrOfPlanInfo[indexOfSelectedItem];
      this.lotAmount = '${this.selectedPlanInfo.LOTSize}';

      _getGradeInfoFromServer(this.selectedPlanInfo.ProdClass);

      _selectionWgt1.setContent(title);
      _pInfoDisplayWgt0.setContent(
          '${this.selectedPlanInfo.ProcessCode}|${this.selectedPlanInfo.ProcessName}');
      _pInfoDisplayWgt1.setContent(
          '${this.selectedPlanInfo.ItemCode}|${this.selectedPlanInfo.ItemName}');
      _pInfoDisplayWgt2.setContent('${this.selectedPlanInfo.WoPlanQty}');
      _pInfoDisplayWgt3.setContent('${this.selectedPlanInfo.WoOutPutQty}');

      _pTextInputWgt1.setContent('${this.selectedPlanInfo.LOTSize}');
    } else if (index == 2) {
      this.selectedGradeInfo = this.arrofGradeInfo[indexOfSelectedItem];
      _selectionWgt2.setContent(title);
    }

    setState(() {});
  }

  Future _btnConfirmClicked() async {
    if (this.selectedProductLine == null ||
        isAvailable(this.selectedProductLine.LineCode) == false) {
      HudTool.showInfoWithStatus("请选择产线");
      return;
    }

    if (_isQingXiXian() == false) {
      if (this.selectedPlanInfo == null ||
        isAvailable(this.selectedPlanInfo.LineCode) == false) {
      HudTool.showInfoWithStatus("请选择工单");
      return;
    }
    }

    if (isAvailable(this.lotNo) == false) {
      HudTool.showInfoWithStatus("请输入模具ID");
      return;
    }

    if (_isQingXiXian() == false) {
      if (isAvailable(this.lotAmount) == false) {
      HudTool.showInfoWithStatus("请输入模具数量");
      return;
    }
    }

    bool isOkay =
        await AlertTool.showStandardAlert(_scaffoldKey.currentContext, "确定提交?");

    if (isOkay) {
      _confirmAction();
    }
  }

  void _confirmAction() {
    Map<String, dynamic> mDict = Map();
    mDict["tool"] = this.lotNo;
    mDict["qty"] = this.lotAmount;
    if (_isQingXiXian()) {
      mDict["wono"] = "";
      mDict["grade"] = this.qingxixianInfo.Grade;
      mDict["line"] = this.qingxixianInfo.ItemCode;
      mDict["productCode"] = this.qingxixianInfo.ProcessCode;
    } else {
      mDict["wono"] = this.selectedPlanInfo.Wono;
      mDict["grade"] = this.selectedGradeInfo.Level;
      mDict["line"] = this.selectedPlanInfo.WorkCenterCode;
      mDict["productCode"] = this.selectedPlanInfo.ItemCode;
    }            

    HudTool.show();
    HttpDigger().postWithUri("LotSubmit/Submit", parameters: mDict,
        success: (int code, String message, dynamic responseJson) {
      print("LotSubmit/Submit: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("报工成功");
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
    _pTextInputWgt0.setContent(this.lotNo);
    _getDataFromServer();
  }

  Future _tryToScan() async {
    print("start scanning");

    String c = await BarcodeScanTool.tryToScanBarcode();
    this.lotNo = c;
    if (stringLength(c) >= 16) {
      this.lotNo = c.substring(0, 16);
    }
    _pTextInputWgt0.setContent(this.lotNo);
  }
}
