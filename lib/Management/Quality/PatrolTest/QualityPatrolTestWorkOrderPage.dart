import 'package:flutter/material.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/View/SelectionBar.dart';

import 'QualityPatrolTestSubWorkOrderListPage.dart';

import '../Model/QualityPatrolTestWorkOrderItemModel.dart';
import '../../Project/Model/ProjectLineModel.dart';

import 'package:flutter_picker/flutter_picker.dart';

class QualityPatrolTestWorkOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QualityPatrolTestWorkOrderPageState();
  }
}

class _QualityPatrolTestWorkOrderPageState extends State<QualityPatrolTestWorkOrderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SelectionBar _sBar = SelectionBar();

  String lineCode;
  List arrOfData;
  List arrOfLineItem;
  ProjectLineModel selectedLineItem;

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
    _getDataFromServer();
  }

  void _getDataFromServer() {
    // CHK/LoadWorkOrder    
    Map mDict = Map();
    if (isAvailable(this.lineCode) == true) {
      mDict["lineCode"] = this.lineCode;
    }

    HudTool.show();
    HttpDigger().postWithUri("CHK/LoadWorkOrder", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("CHK/LoadWorkOrder: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => QualityPatrolTestWorkOrderItemModel.fromJson(item))
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
        title: Text("巡检工单"),
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
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        itemCount: listLength(this.arrOfData),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _hasSelectedIndex(index),
            child: _buildListItem(index),
          );
        });
  }  

  Widget _buildListItem(int index) {
    QualityPatrolTestWorkOrderItemModel itemData = this.arrOfData[index];
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    height: 25,
                    color: Colors.white,
                    child: Text(
                      "${avoidNull(itemData.LineCode)}|${avoidNull(itemData.LineName)}",
                      maxLines: 2,
                      style: TextStyle(
                          color: hexColor(MAIN_COLOR_BLACK),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("工作中心：${avoidNull(itemData.WCName)}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("下单号：${avoidNull(itemData.IPQCWoNo)}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),                  
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("下发时间：${avoidNull(itemData.AppTime)}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),                  
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("类型：${avoidNull(itemData.AppIPQCType)}",
                            style: TextStyle(
                                color: hexColor("999999"), fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    color: hexColor("dddddd"),
                    height: 1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
            margin: EdgeInsets.only(right: 8),
            color: Colors.white,
            child: Icon(
              Icons.arrow_forward_ios,
              color: hexColor("dddddd"),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _hasSelectedIndex(int index) {
    QualityPatrolTestSubWorkOrderListPage w = QualityPatrolTestSubWorkOrderListPage(this.arrOfData[index]);
    Navigator.of(_scaffoldKey.currentContext).push(MaterialPageRoute(
              builder: (BuildContext context) => w));
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
    _sBar.setContent(title);
    this.selectedLineItem = this.arrOfLineItem[indexOfSelectedItem];
    this.lineCode = this.selectedLineItem.LineCode;

    _getDataFromServer();
  }
}