import 'package:flutter/material.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import '../../../Others/Const/Const.dart';
import '../../../Others/Tool/HudTool.dart';
import '../../../Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import '../../../Others/View/MESSelectionItemWidget.dart';
import '../../../Others/View/MESContentInputWidget.dart';
import '../Widget/ProjectTextInputWidget.dart';

import '../Model/ProjectReturnRepairmentWorkOrderItemModel.dart';
import '../Model/ProjectReturnRepairmentProjectItemModel.dart';
import '../Model/ProjectReturnRepairmentCurrentDayProjectModel.dart';
import '../Model/ProjectReturnRepairmentRepairCodeItemModel.dart';
import '../Model/ProjectReturnRepairmentReasonProcessItemModel.dart';

import 'package:flutter_picker/flutter_picker.dart';

class ProjectReturnRepairmentNonLotPage extends StatefulWidget {
  ProjectReturnRepairmentNonLotPage(
    this.parentScaffoldKey,
  );
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  State<StatefulWidget> createState() {   
    return _ProjectReturnRepairmentNonLotPageState(this.parentScaffoldKey);
  }  
}

class _ProjectReturnRepairmentNonLotPageState extends State<ProjectReturnRepairmentNonLotPage> with AutomaticKeepAliveClientMixin {
  _ProjectReturnRepairmentNonLotPageState(
    this.parentScaffoldKey,
  );
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  MESSelectionItemWidget _selectionWgt0;
  MESSelectionItemWidget _selectionWgt1;
  MESSelectionItemWidget _selectionWgt2;
  MESSelectionItemWidget _selectionWgt3;
  MESSelectionItemWidget _selectionWgt4;

  ProjectTextInputWidget _txtInputWgt0;

  MESContentInputWidget _contentInputWgt;

  String remarkContent;
  String returnRepairmentNum;

  List arrOfWorkOrder;
  ProjectReturnRepairmentWorkOrderItemModel selectedWorkOrder;
  List arrOfProject;
  ProjectReturnRepairmentProjectItemModel selectedProject;
  ProjectReturnRepairmentCurrentDayProjectModel currentDayProject;
  List arrOfReasonProcess;
  ProjectReturnRepairmentReasonProcessItemModel selectedReasonProcess;
  List arrOfRepairCode;
  ProjectReturnRepairmentRepairCodeItemModel selectedRepairCode;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _selectionWgt0 = _buildSelectionInputItem(0);
    _selectionWgt1 = _buildSelectionInputItem(1);
    _selectionWgt2 = _buildSelectionInputItem(2);
    _selectionWgt3 = _buildSelectionInputItem(3);
    _selectionWgt4 = _buildSelectionInputItem(4);

    _txtInputWgt0 = _buildTextInputWidgetItem(0);

    _contentInputWgt = _buildContentInputItem();

    _getDataFromServer();
  }

  void _getDataFromServer() {
    // Loadmaterial/GetAllWorkCenter
    HudTool.show();
    HttpDigger().postWithUri("Loadmaterial/GetAllWorkCenter", parameters: {}, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("Loadmaterial/GetAllWorkCenter: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfWorkOrder = (responseJson["Extend"] as List).map((item) => ProjectReturnRepairmentWorkOrderItemModel.fromJson(item))
          .toList();
    });
  }

  void _getProjectsListFromServer() {
    // Repair/GetProcessByLineCode
    Map mDict = Map();
    mDict["line"] = this.selectedWorkOrder.WorkCenterCode;

    HudTool.show();
    HttpDigger().postWithUri("Repair/GetProcessByLineCode", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("Repair/GetProcessByLineCode: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }
      
      HudTool.dismiss();
      this.arrOfProject = (responseJson["Extend"] as List).map((item) => ProjectReturnRepairmentProjectItemModel.fromJson(item))
          .toList();      
      // if (listLength(this.arrOfProject) == 0) {
      //   HudTool.showInfoWithStatus("该作业中心无工程信息");
      // } else {
      //   HudTool.dismiss();
      // }
    });
  }

  void _getCurrentDayProjectFromServer() {
    // Repair/GetOnLineWo
    Map mDict = Map();
    mDict["line"] = this.selectedProject.ProcessCode;

    HudTool.show();
    HttpDigger().postWithUri("Repair/GetOnLineWo", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("Repair/GetOnLineWo: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.currentDayProject = ProjectReturnRepairmentCurrentDayProjectModel.fromJson(responseJson["Extend"]);
      _selectionWgt2.setContent(this.currentDayProject.Wono);
    });
  }

  void _getReasonProcessListFromServer() {
    // Repair/GetStep
    Map mDict = Map();
    mDict["line"] = this.selectedWorkOrder.LineCode;

    HudTool.show();
    HttpDigger().postWithUri("Repair/GetStep", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("Repair/GetStep: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfReasonProcess = (responseJson["Extend"] as List).map((item) => ProjectReturnRepairmentReasonProcessItemModel.fromJson(item))
          .toList();
    });
  }

  void _getRepairCodeListFromServer() {
    // Repair/GetRepairCode
    Map mDict = Map();
    mDict["line"] = this.selectedWorkOrder.LineCode;

    HudTool.show();
    HttpDigger().postWithUri("Repair/GetRepairCode", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("Repair/GetRepairCode: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfRepairCode = (responseJson["Extend"] as List).map((item) => ProjectReturnRepairmentRepairCodeItemModel.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: randomColor(),
      child: Column(
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
      ),
    );
  }

  Widget _buildListView() {
    return ListView(
      children: <Widget>[
        _selectionWgt0,
        _selectionWgt1,
        _selectionWgt2,
        _selectionWgt3,
        _txtInputWgt0,
        _selectionWgt4,
        _contentInputWgt,
        _buildFooter(),
      ],
    );
  }

  Widget _buildTextInputWidgetItem(int index) {
    String title = "";
    String placeholder = "";
    bool canScan = false;
    TextInputType keyboardInputType = TextInputType.text;
    if (index == 0) {
      title = "返修数量";
      placeholder = "请输入数字(只能输入数字)";
      keyboardInputType = TextInputType.number;
    }

    ProjectTextInputWidget wgt = ProjectTextInputWidget(
      title: title,
      placeholder: placeholder,
      canScan: canScan,
      keyboardType: keyboardInputType,
    );
    wgt.contentChangeBlock = (String newContent) {
      if (index == 0) {
        this.returnRepairmentNum = newContent;
      }
    };

    return wgt;
  }

  Widget _buildSelectionInputItem(int index) {
    String title = "";
    bool enabled = true;
    if (index == 0) {
      title = "作业中心";
    } else if (index == 1) {
      title = "工程";
    } else if (index == 2) {
      title = "工单";
      enabled = false;
    } else if (index == 3) {
      title = "原因工序";
    } else if (index == 4) {
      title = "返修代码";
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
      for (ProjectReturnRepairmentWorkOrderItemModel m in this.arrOfWorkOrder) {
      arrOfSelectionTitle.add('${m.WorkCenterCode}|${m.WorkCenterName}');
    }
    } else if (index == 1) {
      if (listLength(this.arrOfProject) == 0) {
        HudTool.showInfoWithStatus("该作业中心无工程信息");
        return;
      }
      for (ProjectReturnRepairmentProjectItemModel m in this.arrOfProject) {
        arrOfSelectionTitle.add('${m.ProcessCode}|${m.ProcessName}');
      }
    } else if (index == 2) {

    } else if (index == 3) {
      for (ProjectReturnRepairmentReasonProcessItemModel m in this.arrOfReasonProcess) {
        arrOfSelectionTitle.add('${m.StepCode}|${m.StepName}');
      }
    } else if (index == 4) {
      for (ProjectReturnRepairmentRepairCodeItemModel m in this.arrOfRepairCode) {
        arrOfSelectionTitle.add('${m.LOTRepairCode}|${m.Description}');
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
    picker.show(this.parentScaffoldKey.currentState);
  }

  void _handlePickerConfirmation(
      int indexOfSelectedItem, String title, int index) {
    if (index == 0) {
      this.selectedWorkOrder = this.arrOfWorkOrder[indexOfSelectedItem];

      _selectionWgt0.setContent(title);

      _getProjectsListFromServer();
      _getReasonProcessListFromServer();
      _getRepairCodeListFromServer();
    } else if (index == 1) {
      this.selectedProject = this.arrOfProject[indexOfSelectedItem];

      _selectionWgt1.setContent(title);

      _getCurrentDayProjectFromServer();
    } else if (index == 2) {

    } else if (index == 3) {
      this.selectedReasonProcess = this.arrOfReasonProcess[indexOfSelectedItem];

      _selectionWgt3.setContent(title);
    } else if (index == 4) {
      this.selectedRepairCode = this.arrOfRepairCode[indexOfSelectedItem];

      _selectionWgt4.setContent(title);
    }
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
                  '>未流出构成Lot的返修，请在"工程"中返修',
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
                Text(
                  '>已流出Lot的返修，请在"流出"中返修',
                  style: TextStyle(color: hexColor("333333"), fontSize: 10),
                ),
                Text(
                  '>已流出Lot部分返修，请先"分批"后再返修',
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
    hideKeyboard(context);
    
    if (this.selectedWorkOrder == null) {
      HudTool.showInfoWithStatus("请选择作业中心");
      return;
    }

    if (this.selectedProject == null) {
      HudTool.showInfoWithStatus("请选择工程");
      return;
    }

    if (this.selectedReasonProcess == null) {
      HudTool.showInfoWithStatus("请选择原因工序");
      return;
    }

    if (isAvailable(this.returnRepairmentNum) == false) {
      HudTool.showInfoWithStatus("请输入返修数量");
      return;
    }

    if (this.selectedRepairCode == null) {
      HudTool.showInfoWithStatus("请选择返修代码");
      return;
    }

    if (isAvailable(this.remarkContent) == false) {
      HudTool.showInfoWithStatus("请输入备注");
      return;
    }

    bool isOkay = await AlertTool.showStandardAlert(context, "确定提交?");

    if (isOkay) {
      _realConfirmationAction();
    }
  }

  void _realConfirmationAction() {
    // Repair/RepairNotLot
    Map mDict = Map();
    mDict["Wono"] = this.currentDayProject.Wono;
    mDict["LotNo"] = "";
    mDict["StepCode"] = this.selectedReasonProcess.StepCode;
    mDict["Comment"] = this.remarkContent;
    mDict["Qty"] = this.returnRepairmentNum;
    mDict["RepairCode"] = this.selectedRepairCode.LOTRepairCode;

    HudTool.show();
    HttpDigger().postWithUri("Repair/RepairNotLot", parameters: mDict, success: (int code, String message, dynamic responseJson) {
      print("Repair/RepairNotLot: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.of(context).pop();
    });
  }
}