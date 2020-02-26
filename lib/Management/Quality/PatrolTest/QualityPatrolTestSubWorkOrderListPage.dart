import 'package:flutter/material.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import 'package:mes/Others/Tool/HudTool.dart';

import 'QualityPatrolTestWorkOrderReportPage.dart';

import '../Model/QualityPatrolTestWorkOrderItemModel.dart';
import '../Model/QualityPatrolTestSubWorkOrderItemModel.dart';

class QualityPatrolTestSubWorkOrderListPage extends StatefulWidget {
  QualityPatrolTestSubWorkOrderListPage(this.itemData);
  final QualityPatrolTestWorkOrderItemModel itemData;
  @override
  State<StatefulWidget> createState() {
    return _QualityPatrolTestSubWorkOrderListPageState(this.itemData);
  }  
}

class _QualityPatrolTestSubWorkOrderListPageState extends State<QualityPatrolTestSubWorkOrderListPage> {
  _QualityPatrolTestSubWorkOrderListPageState(
    this.itemData,
  );
  final QualityPatrolTestWorkOrderItemModel itemData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List arrOfData;

  @override
  void initState() {
    super.initState();

    _getDataFromServer();
  }

  void _getDataFromServer() {
    // CHK/LoadWorkOrderItem
    Map mDict = Map();
    mDict["ipqcPlanNo"] = this.itemData.IPQCPlanNo;
    mDict["ipqcType"] = this.itemData.IPQCType;
    mDict["ipqcWoNo"] = this.itemData.IPQCWoNo;

    HudTool.show();
    HttpDigger().postWithUri("CHK/LoadWorkOrderItem", parameters: mDict, shouldCache: true, success: (int code, String message, dynamic responseJson) {
      print("CHK/LoadWorkOrderItem: $responseJson");
      if (code == 0) {
        HudTool.showInfoWithStatus(message);
        return;
      }

      HudTool.dismiss();
      this.arrOfData = (responseJson['Extend'] as List)
          .map((item) => QualityPatrolTestSubWorkOrderItemModel.fromJson(item))
          .toList();
      
      setState(() {        
      });
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
    QualityPatrolTestSubWorkOrderItemModel itemData = this.arrOfData[index];
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
                      "项目|${avoidNull(itemData.Item)}",
                      maxLines: 2,
                      style: TextStyle(
                          color: hexColor(MAIN_COLOR_BLACK),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),                                
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    height: 21,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("工序：${avoidNull(itemData.Step)}",
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
    QualityPatrolTestWorkOrderReportPage w = QualityPatrolTestWorkOrderReportPage(this.arrOfData[index], this.itemData);
    Navigator.of(_scaffoldKey.currentContext).push(MaterialPageRoute(
              builder: (BuildContext context) => w));
  }
}