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

  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final List<MESSelectionItemWidget> selectionItemList = List();
  int selectedIndex = -1;
  String lotNo;
  String lotAmount;
  List arrOfWork;
  ProjectLineModel selectedWork = ProjectLineModel.fromJson({});
  List arrOfPlanInfo;
  ProjectWorkOrderModel selectedPlanInfo = ProjectWorkOrderModel.fromJson({});
  Map selectedGradeInfo;

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
    HttpDigger().postWithUri("LoadMaterial/AllLine",
        parameters: {}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LoadMaterial/AllLine: $responseJson");
      ;
      this.arrOfWork = (responseJson["Extend"] as List)
          .map((item) => ProjectLineModel.fromJson(item))
          .toList();
      if (listLength(this.arrOfWork) > 0) {
        ProjectLineModel firstWorkData = this.arrOfWork.first;
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
      _selectionWgt2.setContent("BBB");
      List gradeInfoList = responseJson['Extend'] as List;
      if (listLength(gradeInfoList) == 0) {
        return;
      }
      this.selectedGradeInfo = gradeInfoList.first;
      print("selectedGradeInfo: $selectedGradeInfo");
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
        _selectionWgt1,
        _pInfoDisplayWgt0,
        _pInfoDisplayWgt1,
        Container(
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
    TextInputType keyboardType = TextInputType.text;
    if (index == 0) {
      title = "LotNo/模具ID";
      placeholder = "扫描/输入";
    } else if (index == 1) {
      title = "数量";
      placeholder = "请输入数字";
      canScan = false;
      keyboardType = TextInputType.number;
    }
    ProjectTextInputWidget wgt = ProjectTextInputWidget(
      title: title,
      placeholder: placeholder,
      canScan: canScan,
      keyboardType: keyboardType,
    );

    wgt.functionBlock = () {
      hideKeyboard(context);
      _popSheetAlert();
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
      enabled = false;
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
      for (ProjectLineModel m in this.arrOfWork) {
        arrOfSelectionTitle.add('${m.LineCode}|${m.LineName}');
      }
    } else if (index == 1) {
      for (ProjectWorkOrderModel m in this.arrOfPlanInfo) {
        arrOfSelectionTitle.add('${m.Wono}|${m.StateDesc}');
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

  void _handlePickerConfirmation(int indexOfSelectedItem, String title, int index) {
    if (index == 0) {
      this.selectedWork = this.arrOfWork[indexOfSelectedItem];
      print("this.selectedWork.LineCode: ${this.selectedWork.LineCode}");
      _getPlanListFromServer(this.selectedWork.LineCode);
      _selectionWgt0.setContent(title);
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
      _pInfoDisplayWgt3.setContent('${this.selectedPlanInfo.WoRepareQty}');

      _pTextInputWgt1.setContent('${this.selectedPlanInfo.LOTSize}');
    }

    setState(() {});
  }

  Future _btnConfirmClicked() async {
    if (this.selectedWork == null ||
        isAvailable(this.selectedWork.LineCode) == false) {
      HudTool.showInfoWithStatus("请选择产线");
      return;
    }

    if (this.selectedPlanInfo == null ||
        isAvailable(this.selectedPlanInfo.LineCode) == false) {
      HudTool.showInfoWithStatus("请选择工单");
      return;
    }

    if (isAvailable(this.lotNo) == false) {
      HudTool.showInfoWithStatus("请输入模具ID");
      return;
    }

    if (isAvailable(this.lotAmount) == false) {
      HudTool.showInfoWithStatus("请输入模具数量");
      return;
    }

    bool isOkay = await AlertTool.showStandardAlert(_scaffoldKey.currentContext, "确定提交?");

    if (isOkay) {
      _confirmAction();
    }
  }

  void _confirmAction() {
    Map<String, dynamic> mDict = Map();
    mDict["tool"] = this.lotNo;
    mDict["wono"] = this.selectedPlanInfo.Wono;
    mDict["grade"] = "BBB";
    mDict["qty"] = this.lotAmount;
    mDict["line"] = this.selectedPlanInfo.WorkCenterCode;
    mDict["productCode"] = this.selectedPlanInfo.ItemCode;

    print("LotSubmit/Submit mDict: $mDict");

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
    this.lotNo = c;
    if (stringLength(c) >= 16) {
      this.lotNo = c.substring(0, 16);
    }
    _pTextInputWgt0.setContent(this.lotNo);
  }
}
