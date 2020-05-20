import 'package:flutter/material.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Tool/WidgetTool.dart';
import '../../Others/Const/Const.dart';

import 'Model/ProductLineItemModel.dart';
import 'Model/ProductLineDetailModel.dart';
import 'Model/ProductLineExceptionTypeItemModel.dart';
import 'Model/ProductLineExceptionProcessItemModel.dart';
import 'Model/ProductLineMachineItemModel.dart';
import 'Model/ProductLineFirstCheckItemModel.dart';

import 'package:flutter_picker/flutter_picker.dart';

class ProductLineSubmitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductLineSubmitPageState();
  }
}

class _ProductLineSubmitPageState extends State<ProductLineSubmitPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String remarkContent;
  List arrOfData;
  ProductLineItemModel selectedProductLine;
  ProductLineDetailModel productLineDetailData;

  final List<Map> productLineStatusList = [
    {"title": " ", "value": ""},
    {"title": "生产", "value": "RUNING"},
    {"title": "休息", "value": "RESTING"},
    {"title": "品质异常", "value": "QCCHANGE"},
    {"title": "机型调整", "value": "MODELCHANGE"},
    {"title": "不良报警", "value": "BADALARM"},
    {"title": "首检", "value": "FISTTEST"}
  ];
  Map selectedProductLineStatus;

  List arrOfExceptionType;
  ProductLineExceptionTypeItemModel selectedExceptionTypeItem;
  List arrOfExceptionProcess;
  ProductLineExceptionProcessItemModel selectedExceptionProcessItem;
  List arrOfMachine;
  ProductLineMachineItemModel selectedMachine;
  List arrOfFirstCheck;
  ProductLineFirstCheckItemModel selectedFirstCheckItem;

  @override
  void initState() {
    super.initState();

    _getProductLineListFromServer();
  }

  void _getProductLineListFromServer() {
    HudTool.show();
    HttpDigger()
        .postWithUri("LineCode/LoadList", parameters: {}, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("LineCode/LoadList: $responseJson");
      // if (code == 0) {
      //   HudTool.showInfoWithStatus(message);
      //   return;
      // }

      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => ProductLineItemModel.fromJson(item))
          .toList();
    });
  }

  void _getProductLineDetailFromServer() {
    HudTool.show();
    HttpDigger().postWithUri("LineState/LoaDetailed",
        parameters: {"linecode": this.selectedProductLine.LineCode},
        shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("LineState/LoaDetailed: $responseJson");
      // if (code == 0) {
      //   HudTool.showInfoWithStatus(message);
      //   return;
      // }

      HudTool.dismiss();
      List arr = (responseJson['Extend'] as List)
          .map((item) => ProductLineDetailModel.fromJson(item))
          .toList();
      if (listLength(arr) > 0) {
        this.productLineDetailData = arr.first;
      } else {
        this.productLineDetailData = null;
      }
    });
  }

  void _getExceptionTypeListFromServer() {
    // ExceptionType/LoadList
    HudTool.show();
    HttpDigger().postWithUri("ExceptionType/LoadList",
        parameters: {"linecode": this.selectedProductLine.LineCode},
        shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("ExceptionType/LoadList: $responseJson");
      // if (code == 0) {
      //   HudTool.showInfoWithStatus(message);
      //   return;
      // }

      HudTool.dismiss();
      this.arrOfExceptionType = (responseJson['Extend'] as List)
          .map((item) => ProductLineExceptionTypeItemModel.fromJson(item))
          .toList();
    });
  }

  void _getExceptionProcessListFromServer() {
    // ExceptionStep/LoadList
    HudTool.show();
    HttpDigger().postWithUri("ExceptionStep/LoadList",
        parameters: {"linecode": this.selectedProductLine.LineCode},
        shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("ExceptionStep/LoadList: $responseJson");
      // if (code == 0) {
      //   HudTool.showInfoWithStatus(message);
      //   return;
      // }

      HudTool.dismiss();
      this.arrOfExceptionProcess = (responseJson['Extend'] as List)
          .map((item) => ProductLineExceptionProcessItemModel.fromJson(item))
          .toList();
    });
  }

  void _getMachineListFromServer() {
    // ProductCode/LoadList
    HudTool.show();
    HttpDigger().postWithUri("ProductCode/LoadList",
        parameters: {"code": ""}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("ProductCode/LoadList: $responseJson");
      // if (code == 0) {
      //   HudTool.showInfoWithStatus(message);
      //   return;
      // }

      HudTool.dismiss();
      this.arrOfMachine = (responseJson['Extend'] as List)
          .map((item) => ProductLineMachineItemModel.fromJson(item))
          .toList();
    });
  }

  void _getFirstCheckListFromServer() {
    // FirstQC/LoadList
    HudTool.show();
    HttpDigger().postWithUri("FirstQC/LoadList",
        parameters: {"code": ""}, shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("ProductCode/LoadList: $responseJson");
      // if (code == 0) {
      //   HudTool.showInfoWithStatus(message);
      //   return;
      // }

      HudTool.dismiss();
      this.arrOfFirstCheck = (responseJson['Extend'] as List)
          .map((item) => ProductLineFirstCheckItemModel.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("状态变更"),
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
        _buildSelectionItemCellFunction(0),
        _buildSelectionItemCellFunction(1),
        _buildSelectionItemCellFunction(2),
        WidgetTool.createListViewLine(1, hexColor("dddddd")),
        _buildSelectionItemCellFunction(3),
        WidgetTool.createListViewLine(1, hexColor("dddddd")),
        _buildSelectionItemCellFunction(4),
        _buildSelectionItemCellFunction(5),
        _buildSelectionItemCellFunction(6),
        _buildSelectionItemCellFunction(7),
        WidgetTool.createListViewLine(1, hexColor("dddddd")),
        _buildContentInputItemCell("备注:        "),
      ],
    );
  }

  Widget _buildSelectionItemCellFunction(int index) {
    String title = "";
    bool shouldShow = true;
    bool canInteract = true;
    if (index == 0) {
      title = "产线信息";
    } else if (index == 1) {
      title = "当前状态";
      shouldShow = (this.productLineDetailData != null);
      canInteract = false;
    } else if (index == 2) {
      title = "生产机型";
      shouldShow = (this.productLineDetailData != null);
      canInteract = false;
    } else if (index == 3) {
      title = "状态变更";
    } else if (index == 4) {
      title = "异常类型";
      shouldShow = false;
      if (this.selectedProductLineStatus != null &&
          this.selectedProductLineStatus["value"] == "QCCHANGE") {
        shouldShow = true;
      }
    } else if (index == 5) {
      title = "异常工序";
      shouldShow = false;
      if (this.selectedProductLineStatus != null &&
          this.selectedProductLineStatus["value"] == "QCCHANGE") {
        shouldShow = true;
      }
    } else if (index == 6) {
      title = "调整机型";
      shouldShow = false;
      if (this.selectedProductLineStatus != null &&
          this.selectedProductLineStatus["value"] == "MODELCHANGE") {
        shouldShow = true;
      }
    } else if (index == 7) {
      title = "首检类型";
      shouldShow = false;
      if (this.selectedProductLineStatus != null &&
          this.selectedProductLineStatus["value"] == "FISTTEST") {
        shouldShow = true;
      }
    }

    return _buildSelectionItemCell(
        title: title,
        index: index,
        shouldShow: shouldShow,
        canInteract: canInteract);
  }

  Widget _buildSelectionItemCell(
      {String title = "",
      int index = 0,
      bool shouldShow = true,
      bool canInteract = true}) {
    return Offstage(
      offstage: !shouldShow,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: hexColor(MAIN_COLOR_BLACK),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _buildSelectChoiseItem(index, canInteract),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectChoiseItem(int index, bool canInteract) {
    return GestureDetector(
      onTap: () {
        if (canInteract == false) {
          return;
        }
        print("_buildSelectChoiseItem: $index");
        _hasSelectedChoiseItem(index);
      },
      child: Container(
        color: Colors.white,
        height: 60,
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
          decoration: BoxDecoration(
            color: canInteract ? Colors.white : hexColor("f5f5f5"),
            border: new Border.all(width: 1, color: hexColor("999999")),
            borderRadius: new BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  _getChoiseItemContent(index),
                  style: TextStyle(
                      color: hexColor(MAIN_COLOR_BLACK), fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Offstage(
                offstage: !canInteract,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 8),
                  child: Image(
                    width: 10,
                    height: 10,
                    image: AssetImage("Others/Images/downward_triangle.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getChoiseItemContent(int index) {
    String result = "";

    if (index == 0) {
      if (this.selectedProductLine != null) {
        result = avoidNull(
            "${this.selectedProductLine.LineCode}|${this.selectedProductLine.LineName}");
      }
    } else if (index == 1) {
      if (this.productLineDetailData != null) {
        result = avoidNull("${this.productLineDetailData.CurrStateName}");
      }
    } else if (index == 2) {
      if (this.productLineDetailData != null) {
        result = avoidNull("${this.productLineDetailData.CurrProductName}");
      }
    } else if (index == 3) {
      if (this.selectedProductLineStatus != null) {
        result = this.selectedProductLineStatus["title"];
      }
    } else if (index == 4) {
      if (this.selectedExceptionTypeItem != null) {
        result =
            "${this.selectedExceptionTypeItem.Code}|${this.selectedExceptionTypeItem.Remark}";
      }
    } else if (index == 5) {
      if (this.selectedExceptionProcessItem != null) {
        result =
            "${this.selectedExceptionProcessItem.StepCode}|${this.selectedExceptionProcessItem.StepName}";
      }
    } else if (index == 6) {
      if (this.selectedMachine != null) {
        result =
            "${this.selectedMachine.ProductCode}|${this.selectedMachine.ProductName}";
      }
    } else if (index == 7) {
      if (this.selectedFirstCheckItem != null) {
        result =
            "${this.selectedFirstCheckItem.Code}|${this.selectedFirstCheckItem.Remark}";
      }
    }

    return result;
  }

  Widget _buildContentInputItemCell(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: hexColor(MAIN_COLOR_BLACK),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: _buildContenInputItem("备注", (String newContent) {
              print("_buildContenInputItem: $newContent");
              this.remarkContent = newContent;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildContenInputItem(
      String placeholder, void Function(String) textChangedHandler) {
    return Container(
      color: Colors.white,
      height: 140,
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 1, color: hexColor("999999")),
          borderRadius: new BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            style: TextStyle(fontSize: 17, color: hexColor("333333")),
            maxLines: 5,
            decoration: InputDecoration(
                hintText: placeholder, border: InputBorder.none),
            onChanged: (text) {
              print("the text: $text");
              this.remarkContent = text;
            },
          ),
        ),
      ),
    );
  }

  Future _btnConfirmClicked() async {
    if (this.selectedProductLineStatus == null) {
      HudTool.showInfoWithStatus("请选择变更后的状态");
      return;
    }

    if (this.selectedProductLineStatus["value"] == "QCCHANGE") {
      if (this.selectedExceptionTypeItem == null) {
        HudTool.showInfoWithStatus("请选择异常类型");
        return;
      }
      if (this.selectedExceptionProcessItem == null) {
        HudTool.showInfoWithStatus("请选择异常工序");
        return;
      }
    } else if (this.selectedProductLineStatus["value"] == "MODELCHANGE") {
      if (this.selectedMachine == null) {
        HudTool.showInfoWithStatus("请选择调整机型类型");
        return;
      }
    } else if (this.selectedProductLineStatus["value"] == "FISTTEST") {
      if (this.selectedFirstCheckItem == null) {
        HudTool.showInfoWithStatus("请选择首检类型");
        return;
      }
    }

    if (isAvailable(this.remarkContent) == false) {
      HudTool.showInfoWithStatus("请输入备注");
      return;
    }

    bool isOkay =
        await AlertTool.showStandardAlert(_scaffoldKey.currentContext, "确定提交?");

    if (isOkay) {
      _confirmAction();
    }
  }

  void _confirmAction() {
    Map mDict = Map();
    mDict["itemLine"] = this.selectedProductLine.LineCode;
    mDict["itemChangeState"] = this.selectedProductLineStatus["value"];
    if (this.selectedExceptionTypeItem != null) {
      mDict["itemExceptionType"] = this.selectedExceptionTypeItem.Code;
    }    
    if (this.selectedExceptionProcessItem != null) {
      mDict["itemStep"] = this.selectedExceptionProcessItem.StepCode;
    }
    if (this.selectedMachine != null) {
      mDict["itemToProduct"] = this.selectedMachine.ProductCode;
    }    
    if (this.selectedFirstCheckItem != null) {
      mDict["itemFirstQC"] = this.selectedFirstCheckItem.Code;
    }
    mDict["txtRemark"] = this.remarkContent;

    HudTool.show();
    HttpDigger().postWithUri("LineState/ChangeComit", parameters: mDict,
        success: (int code, String message, dynamic responseJson) {
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.of(context).pop();
    });
  }

  void _hasSelectedChoiseItem(int index) {
    List<String> arrOfSelectionTitle = [];
    if (index == 0) {
      for (ProductLineItemModel m in this.arrOfData) {
        arrOfSelectionTitle.add('${m.LineCode}|${m.LineName}');
      }
    } else if (index == 3) {
      for (Map m in this.productLineStatusList) {
        arrOfSelectionTitle.add(m["title"]);
      }
    } else if (index == 4) {
      for (ProductLineExceptionTypeItemModel m in this.arrOfExceptionType) {
        arrOfSelectionTitle.add("${m.Code}|${m.Remark}");
      }
    } else if (index == 5) {
      for (ProductLineExceptionProcessItemModel m
          in this.arrOfExceptionProcess) {
        arrOfSelectionTitle.add("${m.StepCode}|${m.StepName}");
      }
    } else if (index == 6) {
      for (ProductLineMachineItemModel m in this.arrOfMachine) {
        arrOfSelectionTitle.add("${m.ProductCode}|${m.ProductName}");
      }
    } else if (index == 7) {
      for (ProductLineFirstCheckItemModel m in this.arrOfFirstCheck) {
        arrOfSelectionTitle.add("${m.Code}|${m.Remark}");
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
    picker.show(_scaffoldKey.currentState);
  }

  void _handlePickerConfirmation(
      int indexOfSelectedItem, String title, int index) {
    if (index == 0) {
      this.selectedProductLine = this.arrOfData[indexOfSelectedItem];
      _getProductLineDetailFromServer();
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
      this.selectedProductLineStatus =
          this.productLineStatusList[indexOfSelectedItem];
      if (this.selectedProductLineStatus["value"] == "QCCHANGE") {
        _getExceptionTypeListFromServer();
        _getExceptionProcessListFromServer();
      } else if (this.selectedProductLineStatus["value"] == "MODELCHANGE") {
        _getMachineListFromServer();
      } else if (this.selectedProductLineStatus["value"] == "FISTTEST") {
        _getFirstCheckListFromServer();
      }
    } else if (index == 4) {
      this.selectedExceptionTypeItem =
          this.arrOfExceptionType[indexOfSelectedItem];
    } else if (index == 5) {
      this.selectedExceptionProcessItem =
          this.arrOfExceptionProcess[indexOfSelectedItem];
    } else if (index == 6) {
      this.selectedMachine = this.arrOfMachine[indexOfSelectedItem];
    } else if (index == 7) {
      this.selectedFirstCheckItem = this.arrOfFirstCheck[indexOfSelectedItem];
    }

    setState(() {});
  }
}
