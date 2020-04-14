import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Tool/AlertTool.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import '../../../Others/View/SelectionBar.dart';

import '../../Project/Model/ProjectLineModel.dart';
import '../Model/QualitySelfTestItemModel.dart';

import 'package:flutter_picker/flutter_picker.dart';

class QualitySelfTestNewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QualitySelfTestNewPageState();
  }  
}

class _QualitySelfTestNewPageState extends State<QualitySelfTestNewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SelectionBar _sBar = SelectionBar();


  List arrOfData;
  ProjectLineModel selectedLineItem;
  List arrOfLineItem;

  @override
  void initState() {
    super.initState();

    _sBar.setSelectionBlock(() {
      List<String> arrOfSelectionTitle = [];
      for (ProjectLineModel m in this.arrOfLineItem) {
        arrOfSelectionTitle.add('${m.LineName}|${m.LineCode}');
      }

      if (arrOfSelectionTitle.length == 0) {
        return;
      }

      _showPickerWithData(arrOfSelectionTitle, 0);
    });

    _getProductionLineListFromServer();
  }

  void _getDataFromServer() {
    // MEC/GetWorkOrderAndProduct
    Map mDict = Map();
    if (this.selectedLineItem != null) {
      mDict["lineCode"] = this.selectedLineItem.LineCode;
    }

    HudTool.show();
    HttpDigger().postWithUri("MEC/GetWorkOrderAndProduct", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("MEC/GetWorkOrderAndProduct: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      } 

      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => QualitySelfTestItemModel.fromJson(item))
          .toList();     
      setState(() {        
      });      
    });
  }

  void _getProductionLineListFromServer() {
    // LoadMaterial/AllLine
    HudTool.show();
    HttpDigger().postWithUri("LoadMaterial/AllLine", parameters: {}, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("LoadMaterial/AllLine: $responseJson");
      // if (code == 0) {
      //   HudTool.showInfoWithStatus(message);
      //   return;
      // } 

      HudTool.dismiss();
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
        title: Text("自检工单"),
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
    return ListView.builder(
        itemCount: listLength(this.arrOfData),
        // itemCount: 10,
        itemBuilder: (context, index) {
          return _buildListItem(index);
        });
  }

  Widget _buildListItem(int index) {
    // GroupCheckDetailItemModel itemData = this.arrOfData[index];
    return _buildUncheckedListItem(index);
  }

  Widget _buildUncheckedListItem(int index) {
    QualitySelfTestItemModel itemData = this.arrOfData[index];
    return Container(
      color: Colors.white,
      // height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 15 + 3.0, 10, 3),
            // color: randomColor(),
            child: Text(
              "${itemData.LineName}：${itemData.MECWorkOrderNo}",
              style: TextStyle(color: hexColor("333333"), fontSize: 17),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: hexColor("f1f1f7"),
            height: 1,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10 + 3.0, 10, 3),
            // color: randomColor(),
            child: Text(
              "工序：${itemData.Step}",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 3.0, 10, 3),
            // color: randomColor(),
            child: Text(
              "项目：${itemData.Item}",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            // color: randomColor(),
            child: Text(
              "工具：${itemData.MethodTool}",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            // color: randomColor(),
            child: Text(
              "工单类型：${itemData.AppWoType}",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            // color: randomColor(),
            child: Text(
              "机型：${itemData.Product}",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            // color: randomColor(),
            child: Text(
              "基准：${itemData.AppStandard}",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              _buildCorrespondingWidget(index),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 1,
            color: hexColor("dddddd"),
          ),
        ],
      ),
    );
  }

  Widget _buildCorrespondingWidget(int index) {
    QualitySelfTestItemModel itemData = this.arrOfData[index];
    bool isTextFeild = (isAvailable(itemData.Judge) && (itemData.Judge != "人为判断"));
    if (isTextFeild) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
        color: hexColor("f1f1f1"),
        width: 100,
        height: 30,
        child: TextField(
          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
          style: TextStyle(fontSize: 18, color: hexColor(MAIN_COLOR_BLACK)),
          textAlignVertical: TextAlignVertical.center,
          controller: TextEditingController(text: itemData.Actual),
          decoration: InputDecoration(
              hintText: "请输入数值",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 9)
          ),
          onChanged: (text) {
            print("text: $text");
            itemData.Actual = text;
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 5, 0, 3),
        // color: randomColor(),
        width: 150,
        height: 30,
        child: Row(
          children: <Widget>[
            Expanded(
              child: CupertinoSegmentedControl(
                children: {
                  0: Text("OK"),
                  1: Text("NG"),
                },
                groupValue: (isAvailable(itemData.Actual) ? (int.parse(itemData.Actual) == 1 ? 0 : 1) : 0),
                onValueChanged: (value) {
                  print("onValueChanged: $value");
                  hideKeyboard(context);
                  setState(() {
                    itemData.Actual = (value == 0 ? "1" : "0");
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
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
    _sBar.setContent(title);
    this.selectedLineItem = this.arrOfLineItem[indexOfSelectedItem];

    _getDataFromServer();
  }

  Future _btnConfirmClicked() async {
    hideKeyboard(context);
    
    List arrayResult = List();
    for (QualitySelfTestItemModel model in this.arrOfData) {
      if (isAvailable(model.Actual) == false) {
        continue;
      }

      Map<String, dynamic> obj = Map();
      obj["MECWorkOrderNo"] = model.MECWorkOrderNo;
      obj["Actual"] = model.Actual;
      obj["Judge"] = model.Judge;
      obj["ManualJudge"] = model.AppStandard;
      obj["Product"] = model.Product;
      arrayResult.add(obj);
    }

    if (listLength(arrayResult) == 0) {
      HudTool.showInfoWithStatus("请至少修改一项数据");
      return;
    }

    bool isOkay = await AlertTool.showStandardAlert(context, "确定提交更改项?");

    if (isOkay) {
      _realConfirmationAction(arrayResult);
    }
  }

  void _realConfirmationAction(List arrayResult) {
    Map mDict = Map();
    mDict["arrayResult"] = arrayResult;
    print("MEC/Commit mDict: $mDict");

    HudTool.show();
    HttpDigger().postWithUri("MEC/Commit", parameters: mDict, success: (int code, String message, dynamic responseJson) {
      print("MEC/Commit: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.showInfoWithStatus("操作成功");
      Navigator.pop(context);
    });
  }
}