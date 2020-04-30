import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/WidgetTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/View/MESContentInputWidget.dart';

import '../Model/QualityPatrolTestWorkOrderItemModel.dart';
import '../Model/QualityMachineTypeItemModel.dart';
import '../Model/QualityMachineDetailInfoModel.dart';
import '../Model/QualityPatrolTestSubWorkOrderItemModel.dart';

import 'QualityPatrolTestImageBrowserPage.dart';

import 'package:flutter_picker/flutter_picker.dart';
import 'package:image_picker/image_picker.dart';

class QualityPatrolTestWorkOrderReportPage extends StatefulWidget {
  QualityPatrolTestWorkOrderReportPage(this.detailData, this.itemData);
  final QualityPatrolTestSubWorkOrderItemModel detailData;
  final QualityPatrolTestWorkOrderItemModel itemData;

  @override
  State<StatefulWidget> createState() {
    return _QualityPatrolTestWorkOrderReportPageState(detailData, itemData);
  }
}

class _QualityPatrolTestWorkOrderReportPageState
    extends State<QualityPatrolTestWorkOrderReportPage> {
  _QualityPatrolTestWorkOrderReportPageState(
    this.detailData,
    this.itemData,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final QualityPatrolTestSubWorkOrderItemModel detailData;
  final QualityPatrolTestWorkOrderItemModel itemData;
  
  MESContentInputWidget _contentInputWgt;

  String imageBase64String;
  List remarkContentList = [];
  List arrOfData;
  int selectedIndex = -1;
  QualityMachineTypeItemModel selectedMachineType;
  // QualityMachineDetailInfoModel machineDetailInfo;
  Map currentStandardDetail;
  // String nonManualJudgeValue;
  // String selectedManualJudgeResult;
  List actualList = [];
  // List standardList = [];
  List pictureList = [];



  @override
  void initState() {
    super.initState();

    _contentInputWgt = _buildContentInputCell();

    _getDataFromServer();
    _getAttachmentImageDataFromServer();
  }

  void _getDataFromServer() {    
    // CHK/LoadItem
    Map mDict = Map();
    mDict["ipqcItemNo"] = this.detailData.IPQCItemNo;
    mDict["ipqcType"] = "${this.itemData.IPQCType},${this.itemData.IPQCWoNo}";

    HudTool.show();
    HttpDigger().postWithUri("CHK/LoadItem",
        parameters: mDict,
        shouldCache: true,
        success: (int code, String message, dynamic responseJson) {
      print("CHK/LoadItem: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      if (responseJson["Extend"] == null) {
        HudTool.showInfoWithStatus("暂无机型数据");
        return;
      }

      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => QualityMachineTypeItemModel.fromJson(item))
          .toList();
      this.remarkContentList.clear();
      this.actualList.clear();
      this.pictureList.clear();
      for (int i = 0; i < listLength(this.arrOfData); i++) {
        this.remarkContentList.add("");
        this.actualList.add("");
        this.pictureList.add(null);        
      }
      if (listLength(this.arrOfData) > 0) {
        this.selectedIndex = 0;
        this.selectedMachineType = this.arrOfData.first;
        _getMachineDetailInfoFromServer();
      }
      setState(() {});
    });
  }

  void _getAttachmentImageDataFromServer() {
    // CHK/Browse
    Map mDict = Map();
    mDict["ipqcType"] = this.detailData.IPQCItemNo;
    mDict["ipqcType"] = this.itemData.IPQCType;

    HttpDigger().postWithUri("CHK/Browse", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("CHK/Browse: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      this.imageBase64String = responseJson["data"];
    });
  }

  void _getMachineDetailInfoFromServer() {
    // CHK/LoadProduct
    Map mDict = Map();
    mDict["ipqcType"] = this.itemData.IPQCType;
    mDict["ipqcPlanNo"] = this.detailData.IPQCPlanNo;
    mDict["ipqcItemNo"] = this.detailData.IPQCItemNo;

    HudTool.show();
    HttpDigger()
        .postWithUri("CHK/LoadProduct", parameters: mDict, shouldCache: true,
            success: (int code, String message, dynamic responseJson) {
      print("CHK/LoadProduct: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      // this.machineDetailInfo = QualityMachineDetailInfoModel.fromJson(responseJson["Extend"]);
      this.currentStandardDetail = responseJson["Extend"];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("巡检工单报工"),
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
        WidgetTool.createListViewLine(5, hexColor("f2f2f7")),
        _buildWorkOrderHeaderCell(),
        WidgetTool.createListViewLine(1, hexColor("f2f2f7")),
        _buildDetailInfoCell(),
        WidgetTool.createListViewLine(15, hexColor("f2f2f7")),
        _buildSelectionItemCell(title: "机    型：", index: 0),
        _buildMachineBaseJudgementInfoCell(),
        _buildMachineStandardInfoCell(),
        Offstage(
          offstage: _isManualJudget() == true,
          child: _buildConsequeceNumberInputCell(),
        ),
        Offstage(
          offstage: _isManualJudget() == false,
          child: _buildSelectionItemCell(title: "结    果：", index: 1),
        ),
        _contentInputWgt,
        _buildImageInputCell(),
        WidgetTool.createListViewLine(20, hexColor("f2f2f7")),        
      ],
    );
  }

  bool _isManualJudget() {
    if (this.currentStandardDetail != null) {
      if (this.currentStandardDetail["StandardType"] == "人为判断") {
        return true;
      }
    }

    return false;
  }

  Widget _buildWorkOrderHeaderCell() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      height: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${this.itemData.LineName}|${this.detailData.Item}",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: hexColor("333333")),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailInfoCell() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "作业中心：${this.itemData.WCName}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
                Text(
                  "工序：${this.detailData.Step}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "巡检类型：${this.itemData.AppIPQCType}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
                Text(
                  "抽检数量：${this.detailData.QTY}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "工单号：${this.itemData.IPQCWoNo}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "工单下发时间：${this.itemData.AppTime}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "检测工具：${this.detailData.Tool}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "检测方法：${this.detailData.Method}",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "附        件：",
                  style: TextStyle(color: hexColor("666666"), fontSize: 15),
                ),
                GestureDetector(
                  onTap: () {
                    if (isAvailable(this.imageBase64String) == false) {
                      print("无图片");
                      return;
                    }                    
                    _tryToSeeImage();
                  },
                  child: Text(
                  isAvailable(this.imageBase64String) ? "点击查看图片" : "无图片",
                  style: TextStyle(color: hexColor(MAIN_COLOR), fontSize: 15),
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _tryToSeeImage() {
    print("_tryToSeeImage");

    QualityPatrolTestImageBrowserPage imageBrowser = QualityPatrolTestImageBrowserPage(this.imageBase64String);
    Navigator.of(_scaffoldKey.currentContext).push(MaterialPageRoute(
              builder: (BuildContext context) => imageBrowser));
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
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          decoration: BoxDecoration(
            color: canInteract ? Colors.white : hexColor("f5f5f5"),
            border: new Border.all(width: 1, color: hexColor("999999")),
            borderRadius: new BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
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

  Widget _buildMachineBaseJudgementInfoCell() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            this.currentStandardDetail == null
                ? "判断基准："
                : "判断基准：${this.currentStandardDetail['StandardType']}",
            style: TextStyle(color: hexColor("666666"), fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildMachineStandardInfoCell() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            this.currentStandardDetail == null
                ? "标        准："
                : "标        准：${this.currentStandardDetail['Standard']}",
            style: TextStyle(color: hexColor("666666"), fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildConsequeceNumberInputCell() {
    return Container(
      height: 50,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "结    果：",
            style: TextStyle(color: hexColor("666666"), fontSize: 15),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(width: 1, color: hexColor("999999")),
                    borderRadius: new BorderRadius.all(Radius.circular(4))),
                child: TextField(
                    enabled: true,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                        fontSize: 15, color: hexColor(MAIN_COLOR_BLACK)),
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: "请输入数值(只能输入数值)", border: InputBorder.none),
                    onChanged: (text) {
                      print("contentChanged: $text");
                      // this.nonManualJudgeValue = text;
                      this.actualList[this.selectedIndex] = text;
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentInputCell() {
    void Function(String newContent) contentChangedBlock = (String newContent) {
      print("_buildContentInputCell: $newContent");
      this.remarkContentList[this.selectedIndex] = newContent;
    };
    MESContentInputWidget wgt = MESContentInputWidget(
      placeholder: "备注",
      contentChangedBlock: contentChangedBlock,
    );    
    return wgt;
  }

  Widget _buildImageInputCell() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 40,
            child: FlatButton(
            textColor: hexColor("333333"),
            color: hexColor("dddddd"),
            child: Text("上传图片"),
            onPressed: () {
              _tryToGetImage();
            },
          ),
          ),

          _buildImageContentArea(),          
        ],
      ),
    );
  }

  Widget _buildImageContentArea() {
    File picture;
    if (this.selectedIndex >= 0) {
      picture = this.pictureList[this.selectedIndex];
    }

    if (picture == null) {
      return Container(
        height: 1,
      );
    } else {
      return Container(
        margin: EdgeInsets.all(10),
        height: 200,
        color: randomColor(),
        child: Image.file(picture),
      );
    }
  }

  void _tryToGetImage() {
    print("_tryToGetImage");
    _popSheetAlert();    
  }

  void _popSheetAlert() {
    List<String> titleList = ["相册", "拍照"];
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
                  child: Text(titleList[index])),
              onTap: () {
                print('tapped item ${index + 1}');
                Navigator.pop(context);
                _tryToObtainImage(index);
              }),
        )),
        height: 120,
      ),
    );
  }

  Future _tryToObtainImage(int index) async {
    print("_tryToChooseImage");
    var picture = await ImagePicker.pickImage(source: (index == 0 ? ImageSource.gallery : ImageSource.camera));
    print("picture: $picture");
    if (picture == null) {
      return;
    }
    this.pictureList[this.selectedIndex] = picture;

    setState(() {      
    });
  }

  void _hasSelectedChoiseItem(int index) {
    List<String> arrOfSelectionTitle = [];
    if (index == 0) {
      for (QualityMachineTypeItemModel m in this.arrOfData) {
        arrOfSelectionTitle.add('${m.ItemCode}|${m.ItemName}|${m.AppState}');
      }
    } else if (index == 1) {
      arrOfSelectionTitle.add("OK");
      arrOfSelectionTitle.add("NG");
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
    picker.show(_scaffoldKey.currentState);
  }

  void _handlePickerConfirmation(
      int indexOfSelectedItem, String title, int index) {
    if (index == 0) {
      this.selectedIndex = indexOfSelectedItem;
      this.selectedMachineType = this.arrOfData[indexOfSelectedItem];
      _getMachineDetailInfoFromServer();

      _contentInputWgt.setContent(this.remarkContentList[this.selectedIndex]);
    } else if (index == 1) {
      // this.selectedManualJudgeResult = title;
      this.actualList[this.selectedIndex] = title;
    }

    setState(() {});
  }

  String _getChoiseItemContent(int index) {
    if (index == 0) {
      if (this.selectedMachineType != null) {
        return "${this.selectedMachineType.ItemCode}|${this.selectedMachineType.ItemName}|${this.selectedMachineType.AppState}";
      }
    } else if (index == 1) {
      // if (this.selectedManualJudgeResult != null) {
      //   return this.selectedManualJudgeResult;
      // }
      if (this.selectedIndex >= 0) {
        String actual = this.actualList[this.selectedIndex];
      if (isAvailable(actual) == true) {
        return actual;
      }
      }      
    }
    return "-";
  }

  Future _btnConfirmClicked() async {
    if (this.detailData == null) {
      HudTool.showInfoWithStatus("无效工单信息");
      return;
    }

    if (this.selectedMachineType == null) {
      HudTool.showInfoWithStatus("请选择机型");
      return;      
    }

    if (this.currentStandardDetail == null) {
      HudTool.showInfoWithStatus("请先获取判断基准相关信息");
      return;
    }

    if (_isManualJudget() == true && isAvailable(this.actualList[this.selectedIndex]) == false) {
      HudTool.showInfoWithStatus("请选择人为判断结果");
      return;
    }

    if (_isManualJudget() == false && isAvailable(this.actualList[this.selectedIndex]) == false) {
      HudTool.showInfoWithStatus("请填写结果数值");
      return;
    }

    // if (isAvailable(this.remarkContent) == false) {
    //   HudTool.showInfoWithStatus("请填写备注");
    //   return;
    // }
    for (String remarkContent in this.remarkContentList) {
      if (isAvailable(remarkContent) == false) {
        HudTool.showInfoWithStatus("请填写备注");
        return;
      }
    }

    bool isOkay = await AlertTool.showStandardAlert(context, "确定报工?");

    if (isOkay) {
      _realConfirmationAction();
    }
  }

  void _realConfirmationAction() {
    // CHK/WorkOrderBook
    Map mDict = Map();
    mDict["ipqcItemNo"] = this.detailData.IPQCItemNo;
    mDict["ipqcWoNo"] = this.itemData.IPQCWoNo;
    mDict["ipqcType"] = this.itemData.IPQCType;
    mDict["judgeType"] = this.currentStandardDetail["StandardType"];
    mDict["standard"] = this.currentStandardDetail["Standard"];
    mDict["item"] = this.detailData.Item;
    mDict["productCode"] = this.selectedMachineType.ItemCode;
    mDict["product"] = this.selectedMachineType.ItemName;
    mDict["lineCode"] = this.itemData.LineCode;
    mDict["lineName"] = this.itemData.LineName;
    mDict["wcCode"] = this.itemData.WCCode;
    mDict["wcName"] = this.itemData.WCName;
    mDict["stepCode"] = this.detailData.StepCode;
    mDict["step"] = this.detailData.Step;
    mDict["solveList"] = "";

    // solveList
    List solveList = [];
    for (int i = 0; i < listLength(this.actualList); i++) {
      // QualityMachineTypeItemModel machineData = this.arrOfData[i];
      Map solveDict = Map();
      solveDict["Actual"] = this.actualList[i];
      solveDict["BookComment"] = this.remarkContentList[i];
      solveDict["Index"] = i;
      solveDict["StandardType"] = this.currentStandardDetail["StandardType"];
      solveList.add(solveDict);
    }
    mDict["solveList"] = solveList;

    // picList
    List picList = [];
    for (int i = 0; i < listLength(this.pictureList); i++) {
      File picture = this.pictureList[i];
      Map picDict = Map();
      picDict["No"] = i;
      if (picture != null) {
        picDict["Pic"] = base64Encode(picture.readAsBytesSync());
      } else {
        picDict["Pic"] = "";
      }
      picList.add(picDict);
    }
    mDict["picList"] = picList;

    print("mDict: $mDict");

    HudTool.show();
    HttpDigger().postWithUri("CHK/WorkOrderBook", parameters: mDict, success: (int code, String message, dynamic responseJson) {
      print("CHK/WorkOrderBook: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.of(context).pop();
    });
  }
}
